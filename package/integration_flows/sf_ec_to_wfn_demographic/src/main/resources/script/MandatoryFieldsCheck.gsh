import com.sap.gateway.ip.core.customdev.util.Message;
import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.*;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.xpath.*;
import org.jaxen.JaxenException;
import org.jaxen.jdom.JDOMXPath
import org.jaxen.SimpleNamespaceContext;
import org.jaxen.XPath;
import org.jdom.Content;
import org.jdom.Document;
import org.jdom.Element
import org.jdom.input.SAXBuilder;
import org.jdom.JDOMException;
import org.jdom.Namespace;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import java.text.SimpleDateFormat;
import java.util.Date;


def Message processData(Message message)
{

		// Obtain the message body in XML format
		def map = message.getProperties();
		SAXBuilder builder = new SAXBuilder();
		InputStream stream = message.getBody(java.io.InputStream);
		Document doc = builder.build(stream);

		// Get a list of all the Compound Employees
		Element compoundEmployeeList = doc.getRootElement();
		List<Element> compoundEmployees = compoundEmployeeList.getChildren("CompoundEmployee");
		List<Element> employeesToDelete = new ArrayList();
		
		//get previous missing fields log
		def missingFields = map.get("missingMandatoryFieldsRecordsProperty");
		
		//Set Property latest execution_timestamp, it will be used at the end of process to persist time. 
		def xpathCheck = map.get("persist_time_ListProperty");
		if(xpathCheck.size() == 0){
			
			def persist_time_value = compoundEmployees.get(0).getChildText("execution_timestamp");
			xpathCheck.add(persist_time_value);
		}
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String goLiveDate = map.get("Go-live");
		if(goLiveDate.equals("")){
			goLiveDate = "0000-00-00"
		}

		Date goLive = format.parse(goLiveDate);

		// Iterate through all the compound employees to check if mandatory fields are present.
		// If any mandatory field is missing, add the employee to employeesToDelete and the field to fieldsMissing
		
		XMLOutputter xml = new XMLOutputter();
		
		for(Element cEmployee : compoundEmployees)
		{
				// Extract the external person id for the current employee
				
				Element person = cEmployee.getChild("person");
				if(null == person)
				{
						continue;
				}
				String personIdExternal = person.getChildText("person_id_external");

				// Create a list in which all the missing fields will be stored
				List<String> fieldsMissing = new ArrayList();

        		// Create a list in which all the missing elements will be stored
				List<String> elementsMissing = new ArrayList();

				// Extract the employment information for the compound employees
				List<Element> employmentInformation = cEmployee.getChild("person").getChildren("employment_information")

		        if(employmentInformation.isEmpty())
		        {
		            	elementsMissing.add("Employment Information");
		            	employeesToDelete.add(cEmployee);
		        }
		
		        else
		    	{			
						// Create a list to maintain the employment_information nodes to be deleted
						// (The nodes which have assignment_class = GA)
						List<Element> empInfoToDelete = new ArrayList();
		
						// Iterate through each employmentInformation
						for(Element empInfo : employmentInformation)
						{
								// Check if the assignment_class of the current employment_information is GA
								// If so, add it to empInfoToDelete and continue to the next employment_information
								String assignmentClass = empInfo.getChildText("assignment_class");
								if(assignmentClass == "GA")
								{
										if(!empInfoToDelete.contains(empInfo))
												empInfoToDelete.add(empInfo);
										continue;
								}
		
								// Extract the fields which are supposed to be mandatory for employment_information
								String originalStartDate = empInfo.getChildText("originalStartDate");
								String serviceDate = empInfo.getChildText("serviceDate");
		
								// Check if originalStartDate is present or not
								if(originalStartDate=="" || originalStartDate == null)
								{
										fieldsMissing.add("originalStartDate in Employment Information");
										if(!employeesToDelete.contains(cEmployee))
												employeesToDelete.add(cEmployee);
								}
		
								// Check if serviceDate is present or not
								if(serviceDate == "" || serviceDate == null)
								{
										fieldsMissing.add("serviceDate in Employment Information");
										if(!employeesToDelete.contains(cEmployee))
												employeesToDelete.add(cEmployee);
								}
		
								// Extract the compensation information for the employment information
								List<Element> compensationInformation = empInfo.getChildren("compensation_information");
		
				                if(compensationInformation.isEmpty())
				                {
				                    	elementsMissing.add("Compensation Information");
				                    	if(!employeesToDelete.contains(cEmployee))
				                        		employeesToDelete.add(cEmployee);
				                }
								
				                else
				                {
				        						// Iterate through each compensationInformation
				        						for(Element compInfo : compensationInformation)
				        						{
				        								// Extract the fields which are supposed to be mandatory in compensation_information
				        								String payrollId = compInfo.getChildText("payroll_id");
				        								String startDate = compInfo.getChildText("start_date");
				        								String endDate = compInfo.getChildText("end_date");
														Date startDate1 = format.parse(startDate);
														if(startDate1.compareTo(goLive) >= 0 ){
															// Check if payrollId is present or not
															if(payrollId == "" || payrollId == null)
															{
																	fieldsMissing.add("payroll_id in Compensation Information with start date as "+startDate+" and end date as "+endDate);
																	if(!employeesToDelete.contains(cEmployee))
																			employeesToDelete.add(cEmployee);
															}
														}
				        						}
				                }
				                
								// Extract the job information for the employment information
								List<Element> jobInformation = empInfo.getChildren("job_information");
		
				                if(jobInformation.isEmpty())
				                {
					                    elementsMissing.add("Job Information");
					                    if(!employeesToDelete.contains(cEmployee))
					                        	employeesToDelete.add(cEmployee);
				                }
		            			
		            			else
								{
		                    			for(Element jobInfo : jobInformation)
		        						{
		        								// Extract the fields which are supposed to be mandatory in job_information
		        								String job_title = jobInfo.getChildText("job_title");
		        								String is_primary = jobInfo.getChildText("is_primary");
		        								String emplStatus = jobInfo.getChildText("emplStatus");
		        								String event = jobInfo.getChildText("event");
		        								String timezone = jobInfo.getChildText("timezone");
		        								String startDate = jobInfo.getChildText("start_date");
		        								String endDate = jobInfo.getChildText("end_date");
												
												Date startDate1 = format.parse(startDate);
												if(startDate1.compareTo(goLive) >= 0 ){
		        								// Check if job_title is present or not
													if(job_title == "" || job_title == null)
													{
															fieldsMissing.add("job_title in Job Information with start date as "+startDate+" and end date as "+endDate);
															if(!employeesToDelete.contains(cEmployee))
																	employeesToDelete.add(cEmployee);
													}
			
													// Check if is_primary is present or not
													if(is_primary == "" || is_primary == null)
													{
															fieldsMissing.add("is_primary in Job Information with start date as "+startDate+" and end date as "+endDate);
															if(!employeesToDelete.contains(cEmployee))
																	employeesToDelete.add(cEmployee);
													}
			
													// Check if payrollId is present or not
													if(emplStatus == "" || emplStatus == null)
													{
															fieldsMissing.add("emplStatus in Job Information with start date as "+startDate+" and end date as "+endDate);
															if(!employeesToDelete.contains(cEmployee))
																	employeesToDelete.add(cEmployee);
													}
			
													
													// Check if timezone is present or not
													if(timezone == "" || timezone == null)
													{
															fieldsMissing.add("timezone in Job Information with start date as "+startDate+" and end date as "+endDate);
															if(!employeesToDelete.contains(cEmployee))
																	employeesToDelete.add(cEmployee);
													}
												}
												// Check if startDate is present or not in case of a ReHire event (event = 'R')
												if(event == "R" && (startDate == "" || startDate == null))
												{
														fieldsMissing.add("startDate for Rehire Event in Job Information with start date as "+startDate+" and end date as "+endDate);
														if(!employeesToDelete.contains(cEmployee))
															employeesToDelete.add(cEmployee);
												}
		        						}
		            			}
						}
						// Delete all employmentInformation whose assignmentClass is GA
						for(Element element : empInfoToDelete)
						{
				  			element.getParent().removeContent(element);
						}
		    	}
		
		        String errorText = "";
		
		        if(!elementsMissing.isEmpty())
		        {
			            errorText += "The following elements are missing : ";
			            String separator = "";
			            for(String element : elementsMissing)
			            {
				                errorText += separator + element;
				                separator = ",";
			            }
		
		        }
		
		        if(!fieldsMissing.isEmpty())
		        {
		         	   String separator = ""
		            	if(!errorText.isEmpty())
		            	{
		                		separator = "\n"
		            	}
		            	errorText += "The data for the following mandatory field(s) is missing :"
		            	for(String field : fieldsMissing)
						{
								errorText += "\n" + field;
						}
		        }
		
				// In case there are any missing mandatory fields
				if(!errorText.isEmpty())
				{
						// Create the message element for the employee
						Element Message = new Element("Message")
						// Create a status element to set the message status as Error
						Element Status = new Element("Status").setText("Error");
						// Create a Security ID element, to point at the erroneous employee
						Element SecurityID = new Element("Person_ID_External").setText(personIdExternal);
						// Create a Text element which has an error message along with the missing fields
						Element Text = new Element("Text").setText(errorText);
						// Create an Entity element to specify that the error occurred in a Compound Employee
						Element Entity = new Element("Entity").setText("Compound Employee");
		
						// Add the created elements to Message
						Message.addContent(Status);
						Message.addContent(SecurityID);
						Message.addContent(Text);
						Message.addContent(Entity);
		
						// Add the message to the log
						missingFields.add(xml.outputString(Message));
				}
		}

		// Delete all employees from the input payload which have mandatory fields missing
		for(Element element : employeesToDelete)
		{
	  		element.getParent().removeContent(element);
		}

		//Set the message body as the log XML message generated
		message.setBody(new XMLOutputter().outputString(doc));
		

		// return the modified payload with the all_records_missing_mandatory_fields property attached
		return message;
}
