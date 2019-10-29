/*
 * The integration developer needs to create the method processData 
 * This method takes Message object of package com.sap.gateway.ip.core.customdev.util
 * which includes helper methods useful for the content developer:
 * 
 * The methods available are:
    public java.lang.Object getBody()
    
    //This method helps User to retrieve message body as specific type ( InputStream , String , byte[] ) - e.g. message.getBody(java.io.InputStream)
    public java.lang.Object getBody(java.lang.String fullyQualifiedClassName)

    public void setBody(java.lang.Object exchangeBody)

    public java.util.Map<java.lang.String,java.lang.Object> getHeaders()

    public void setHeaders(java.util.Map<java.lang.String,java.lang.Object> exchangeHeaders)

    public void setHeader(java.lang.String name, java.lang.Object value)

    public java.util.Map<java.lang.String,java.lang.Object> getProperties()

    public void setProperties(java.util.Map<java.lang.String,java.lang.Object> exchangeProperties) 

	public void setProperty(java.lang.String name, java.lang.Object value)
 * 
 */
import com.sap.gateway.ip.core.customdev.util.Message;
import java.util.HashMap;
import java.util.Properties;
import java.io.InputStream;
import java.util.List;
import java.util.ArrayList;
import org.jaxen.SimpleNamespaceContext;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.Namespace;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Logger;  

def Message processData(Message message) {
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	def pMap = message.getProperties();
	def goLive_date = pMap.get("Go-live");
	Date goLive = dateFormat.parse(goLive_date);
	InputStream is = new ByteArrayInputStream(message.getBody(String.class).getBytes("UTF-8"));
	XMLOutputter xmlOutputter = new XMLOutputter(Format.getCompactFormat());
	SAXBuilder builder = new SAXBuilder();
	Document doc = builder.build(is);
	List <Element> CompoundEmployeeList = doc.getRootElement().getChildren("CompoundEmployee");
	List <Element> CompoundEmployeesToDelete = new ArrayList <Element>();
	def info = '';
	
	def historicalRecords = pMap.get("historicalRecordsProperty");
	XMLOutputter xml = new XMLOutputter();
	
	for(Element ce : CompoundEmployeeList) {
		List <Element> elementsToDelete = new ArrayList <Element>();
		Element person = ce.getChild("person");
		List<Element> snapshot = person.getChildren("snapshot");
		for(Element snap : snapshot) {
			def asOf_date = snap.getChildText("asOfDate");
			Date asOf = dateFormat.parse(asOf_date);
			if(asOf < goLive) {
			elementsToDelete.add(snap);
			}
		}
		for(Element element : elementsToDelete)
		{
			element.getParent().removeContent(element);
		}
		snapshot = person.getChildren("snapshot");
		if(snapshot.size() == 0) {
			CompoundEmployeesToDelete.add(ce);
			def id = person.getChildText("person_id_external");
			// Create the Record element for the employee
			Element Record = new Element("Record")
			// Create a status element to set the Record status as INFO
			Element Status = new Element("Status").setText("INFO");
			// Create a Security ID element, to point at the erroneous employee
			Element SecurityID = new Element("person_id_external").setText(id);
			// Create an goLiveDate element to specify goLiveDate
			Element goLiveDate = new Element("Go-live_Date").setText(goLive_date);
			// Create a Text element which has an error message along with the missing fields
			Element Text = new Element("Message").setText("The Employee doesn't have any effective dated snapshots on or after the go-live date and hence this employee is ignored and not sent to Workforce Software.");
			
			Record.addContent(Status);
			Record.addContent(SecurityID);
			Record.addContent(goLiveDate);
			Record.addContent(Text);
			
			historicalRecords.add(xml.outputString(Record));
			
		}
	}
	for(Element element : CompoundEmployeesToDelete)
	{
		element.getParent().removeContent(element);
	}
		
	message.setBody(xmlOutputter.outputString(doc));
	return message;
}