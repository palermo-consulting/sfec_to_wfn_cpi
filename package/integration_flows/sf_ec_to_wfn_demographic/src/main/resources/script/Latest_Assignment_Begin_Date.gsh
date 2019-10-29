import java.io.File;
import java.util.HashMap;
import java.util.List;
import org.jaxen.SimpleNamespaceContext;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.Namespace;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import com.sap.gateway.ip.core.customdev.util.Message;

// Calculate and add a latest_assignment_begin_date field to each employee in message
def Message addLatestAssignmentBeginDate (Message message)
{
		// Extract message body and properties
		def body = message.getBody(String.class);
		def props = message.getProperties();

		// Create a new JDOM XML Parser
		SAXBuilder builder = new SAXBuilder();

		// Obtain the XML data from the message body received, and build it using the parser
		InputStream is = new ByteArrayInputStream(body.getBytes("UTF-8"));
	  	Document doc = builder.build(is);
	  	
	  	String bad_data = "";
		List<Element> employeesToDelete = new ArrayList();
		
		def badDataRecords = props.get("badDataRecordsProperty");

		// Get a list of all the CompoundEmployees
		Element compoundEmployeeList = doc.getRootElement();
		List<Element> compoundEmployees = compoundEmployeeList.getChildren("CompoundEmployee");
		
		// Iterate through each CompoundEmployee
		for(Element cEmployee : compoundEmployees)
		{
				// Extract person, employment_information and job_information for each CompoundEmployee
				Element person = cEmployee.getChild("person");
				Element empInfo = person.getChild("employment_information");
				List<Element> jobInfo = empInfo.getChildren("job_information");
                boolean processEmployee = true;
                
				// Initialize latestAssignmentBeginDate to null
				String latestAssignmentBeginDate = null;

				// Traverse through all the job_informations received from earliest to present
				for(int j = jobInfo.size() - 1; j > -1; j--)
				{
			  			Element job = jobInfo.get(j);
			  			
						// If the job exists
			    		if(null != job)
						{
								// If the job is either a Hire (H) event or a ReHire (R) event set latestAssignmentBeginDate as the start_date
			     				if(job.getChildText("event") == "H" || job.getChildText("event") == "R")
								{
										latestAssignmentBeginDate = job.getChildText("start_date");
			      				}
			      				
								// If latestAssignmentBeginDate has been assigned
			    				if(latestAssignmentBeginDate != null)
								{
										// Create a new element 'latest_assignment_begin_date'
			      						Element latestAssignmentBeginDateElement = new Element("latest_assignment_begin_date");
			      						
										// Set the text for latestAssignmentBeginDateElement as the string date stored in latestAssignmentBeginDate variable
										latestAssignmentBeginDateElement.setText(latestAssignmentBeginDate);
										
										// Add the latestAssignmentBeginDateElement field to the current job being traversed
			        					job.getContent().add(latestAssignmentBeginDateElement);
			      				}
			  			}
				}
				
				// If hire record is missing for the employee, the latest_assignment_begin_date will not be populated and the employee should not be sent to WFS
			    if(jobInfo.get(0).getChildText("latest_assignment_begin_date") == null || jobInfo.get(0).getChildText("latest_assignment_begin_date") == ""){
			        processEmployee = false;
                    if(bad_data == null || bad_data == "")
				    {
					    bad_data = person.getChildText("person_id_external")+" has no Hire/ReHire record in job_information";
				    }
				    else
				    {
				    	bad_data += "\n"+person.getChildText("person_id_external")+" has no Hire/ReHire record in job_information";
				    }
			    }
				
				if(!processEmployee)
				{
						employeesToDelete.add(cEmployee)
				}
		}

        // Delete all employees from the employeesToDelete List missing
		for(Element employee : employeesToDelete)
		{
	  		employee.getParent().removeContent(employee);
		}
		
		// Create a new XMLOutputter object to write the new
	  	XMLOutputter outputter = new XMLOutputter(Format.getCompactFormat().setOmitDeclaration(true));

		// Write the modified XML data into a ByteArrayInputStream Object, which can then be set as the message's body
		is = new ByteArrayInputStream(outputter.outputString(doc).getBytes("UTF-8"));
	  	message.setBody(is);
	  	if(!bad_data.isEmpty())
		{
				badDataRecords.add(bad_data);
		}
	  	return message;
}
