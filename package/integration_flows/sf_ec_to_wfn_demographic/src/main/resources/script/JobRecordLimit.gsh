import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import org.jaxen.SimpleNamespaceContext;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.Namespace;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import com.sap.gateway.ip.core.customdev.util.Message;


/**************************************
* Limit one job record per snapshot **
**************************************/


def Message limitJobRecords (Message message)
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
		
		Element compoundEmployeeList = doc.getRootElement();
		List<Element> compoundEmployees = compoundEmployeeList.getChildren("CompoundEmployee");
		
		//Iterate through each compound employee
		for(Element cEmployee : compoundEmployees)
		{
				// Extract the list of all the snapshots for the CompoundEmployee
			  	Element person = cEmployee.getChild("person");
				List<Element> snapshot = person.getChildren("snapshot");
				boolean processEmployee = true;
				// Iterate through each snapshot
				for(Element snap : snapshot)
				{
						List<Element> personalInfo = snap.getChildren("personal_information");
		
						if(personalInfo.isEmpty())
						{
								processEmployee = false;
								if(bad_data.isEmpty())
								{
										bad_data = person.getChildText("person_id_external")+" has no personal_information in the snapshot as of date "+snap.getChildText("asOfDate");
								}
								else
								{
										bad_data += "\n"+person.getChildText("person_id_external")+" has no personal_information in the snapshot as of date "+snap.getChildText("asOfDate");
								}
						}
		
						// Extract employment_information and job_information for each snapshot
					  	Element empInfo = snap.getChild("employment_information");
						if(empInfo == null)
						{
								processEmployee = false;
								if(bad_data.isEmpty())
								{
										bad_data = person.getChildText("person_id_external")+" has no employment_information in the snapshot as of date "+snap.getChildText("asOfDate");
								}
								else
								{
										bad_data += "\n"+person.getChildText("person_id_external")+" has no employment_information in the snapshot as of date "+snap.getChildText("asOfDate");
								}
						}
						else
						{
							  	List<Element> jobInfo = empInfo.getChildren("job_information");
		
								// Maintain a list of all the job_informations to be deleted
								List<Element> jobsToDelete = new ArrayList<Element>();
		
								if(jobInfo.isEmpty())
								{
										processEmployee = false;
										if(bad_data.isEmpty())
										{
												bad_data = person.getChildText("person_id_external")+" has no job_information in the snapshot as of date "+snap.getChildText("asOfDate");
										}
										else
										{
												bad_data += "\n"+person.getChildText("person_id_external")+" has no job_information in the snapshot as of date "+snap.getChildText("asOfDate");
										}
								}
		
								// If there exists a job_information and there is more than one job_information for this snapshot
								else if(jobInfo.size() > 1)
								{
										// Add all the jobs, except the latest one, to the jobsToDelete list
										for(int j = 1; j < jobInfo.size(); j++)
										{
												Element job = jobInfo.get(j);
												if(job != null)
												{
														jobsToDelete.add(job);
												}
										}
		
										// Delete all elements (job_informations) from the jobsToDelete list
										for(Element element : jobsToDelete)
										{
												element.getParent().removeContent(element);
										}
								}
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
