/*
 * The integration developer needs to create the method processData 
 * This method takes Message object of package com.sap.gateway.ip.core.customdev.util
 * which includes helper methods useful for the content developer:
 * 
 * The methods available are:
    public java.lang.Object getBody()

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
import java.io.StringWriter;
import org.xml.sax.InputSource;
import javax.xml.xpath.*;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.*;
import javax.xml.transform.TransformerFactory;  
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.dom.DOMSource;
import java.io.IOException;
import java.text.SimpleDateFormat
import java.util.HashMap;
import java.util.List;
import org.jdom.Content;
import org.jdom.Document;
import org.jdom.Element
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.XMLOutputter
import org.jdom.output.Format
import org.jaxen.JaxenException;
import org.jaxen.SimpleNamespaceContext;
import org.jaxen.XPath;
import org.jaxen.jdom.JDOMXPath
import org.jdom.Namespace;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;

def Message processData(Message message) {
	
	//Body 
	def body = message.getBody(String.class);
	
	def map = message.getHeaders();
	
	SAXBuilder builder = new SAXBuilder();
	
	InputStream stream = new ByteArrayInputStream(body.getBytes("UTF-8"));
	
	Document doc = builder.build(stream);

	StringBuffer str = new StringBuffer();
	
	//def var_filter = buildXpathQuery(message)
	def var_filter = "/queryCompoundEmployeeResponse/CompoundEmployee"
	//str.append("The following records either have mandatory fields missing or do not satisfy field restrictions. \n\n")
	//str.append('<?xml version="1.0" encoding="UTF-8"?><queryCompoundEmployeeResponse>')
	str.append(evaluateXpath(body,var_filter))
	message.setProperty("records_missing_mandatory_fields",str.toString());
	//str.append('</queryCompoundEmployeeResponse>')
	//message.setBody(str.toString());
	//message.setBody(var_filter)
	return message;
	}
	
def evaluateXpath( String xml, String xpathQuery) {

  	def xpath = XPathFactory.newInstance().newXPath()
  	def builder     = DocumentBuilderFactory.newInstance().newDocumentBuilder()
  	InputSource is = new InputSource(new StringReader(xml));
  	
  	def records     = builder.parse(is)
  	
  	org.w3c.dom.NodeList l = (org.w3c.dom.NodeList)xpath.evaluate( xpathQuery, records,XPathConstants.NODESET)
	def xmlString = new StringBuffer();
	
	for (int i = 0; i < l.getLength(); i++) {
    
    def missingString = new StringBuffer("");
     
    def snapshotXpath = XPathFactory.newInstance().newXPath()
    def snapshotBuilder     = DocumentBuilderFactory.newInstance().newDocumentBuilder()
    InputSource snapshotIs = new InputSource(new StringReader(nodeToString(l.item(i))))
  	def snapshotRecords     = snapshotBuilder.parse(snapshotIs)
  	
    org.w3c.dom.NodeList snapshotNodes = (org.w3c.dom.NodeList)snapshotXpath.evaluate( "/CompoundEmployee/person/snapshot", snapshotRecords,XPathConstants.NODESET)
    
   	//missingString.append("inside: "+snapshotNodes.getLength());
   	
    for (int j = 0; j < snapshotNodes.getLength(); j++){
       
		if(!xpath.evaluate("employment_information/job_information/job_title",snapshotNodes.item(j),XPathConstants.NODE))
		missingString.append("person/snapshot/employment_information/job_information/job_title is missing \n")
		
		if(!xpath.evaluate("employment_information/job_information/is_primary",snapshotNodes.item(j),XPathConstants.NODE))
		missingString.append("person/snapshot/employment_information/job_information/is_primary is missing \n")
		
		if(!xpath.evaluate("employment_information/job_information/emplStatus",snapshotNodes.item(j),XPathConstants.NODE))
		missingString.append("person/snapshot/employment_information/job_information/emplStatus is missing \n")
		
		if(xpath.evaluate("employment_information/job_information/event/text()",snapshotNodes.item(j),XPathConstants.STRING).equals("R")){
			if(!xpath.evaluate("employment_information/job_information/start_date",snapshotNodes.item(j),XPathConstants.NODE))
			missingString.append("person/snapshot/employment_information/job_information/start_date is missing \n")	
		}
		else {
			if(!xpath.evaluate("employment_information/originalStartDate",snapshotNodes.item(j),XPathConstants.NODE))
			missingString.append("person/snapshot/employment_information/originalStartDate is missing where event is not R \n")
		}
		
		if(!xpath.evaluate("employment_information/originalStartDate",snapshotNodes.item(j),XPathConstants.NODE))
		missingString.append("person/snapshot/employment_information/originalStartDate is missing \n")
		
		if(!xpath.evaluate("employment_information/compensation_information/payroll_id",snapshotNodes.item(j),XPathConstants.NODE))
		missingString.append("person/snapshot/employment_information/compensation_information/payroll_id is missing \n")
		
		if(!xpath.evaluate("employment_information/serviceDate",snapshotNodes.item(j),XPathConstants.NODE))
		missingString.append("person/snapshot/employment_information/serviceDate is missing \n")
		
		if(!xpath.evaluate("employment_information/job_information/timezone",snapshotNodes.item(j),XPathConstants.NODE))
		missingString.append("person/snapshot/employment_information/job_information/timezone is missing \n")
	
	  	
    }
    
	

    
	if(!missingString.toString().equals("")){
	xmlString.append("CompoundEmployee Person ID External : " + xpath.evaluate("person/person_id_external/text()",l.item(i),XPathConstants.STRING) + "\n")
	xmlString.append(missingString.toString() + "\n")
	}
	}
	def xmlString1 = xmlString.toString();
	
}

def nodeToString(org.w3c.dom.Node node) {
    StringWriter sw = new StringWriter();
      Transformer t = TransformerFactory.newInstance().newTransformer();
      t.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
      t.setOutputProperty(OutputKeys.INDENT, "yes");
      t.transform(new DOMSource(node), new StreamResult(sw));
      def xmlString = sw.toString();
  }

//An XpathQuery is built composed of custom filters and filters that take external parameters as inputs.
def buildXpathQuery(Message message){
	def map = message.getHeaders()
	def pMap = message.getProperties()
	def var_filter_query = new StringBuffer()
	def custom_filter_property =  pMap.get("custom_filter");
	
	def custom_filter_list = custom_filter_property.split(";");
	var_filter_query.append("(")
	for(int i=0;i<custom_filter_list.length;i++)
	{
	def custom_filter = custom_filter_list[i]
	
	if(custom_filter.contains("!"))
		
		{
			def custom_filter_operands = custom_filter.split("!=")
			if(custom_filter_operands[1].contains(","))
				
				{
					def custom_filter_comma_separated_values = custom_filter_operands[1].split(",")
					var_filter_query.append("(")
					for(int j=0; j<custom_filter_comma_separated_values.length;j++)
					{
						var_filter_query.append(custom_filter_operands[0]+"!="+"'"+custom_filter_comma_separated_values[j]+"'")	
						if(j!=custom_filter_comma_separated_values.length-1)
						{
							var_filter_query.append(" and ")
						}
					}
					var_filter_query.append(")")
				}
			else var_filter_query.append("("+custom_filter_operands[0]+"!='"+custom_filter_operands[1]+"')")
					
		}
	
	else	
		{
			def custom_filter_operands = custom_filter.split("=")
			if(custom_filter_operands[1].contains(","))
				
				{
					def custom_filter_comma_separated_values = custom_filter_operands[1].split(",")
					var_filter_query.append("(")
					for(int j=0; j<custom_filter_comma_separated_values.length;j++)
					{
						var_filter_query.append(custom_filter_operands[0]+"="+"'"+custom_filter_comma_separated_values[j]+"'")	
						if(j!=custom_filter_comma_separated_values.length-1)
						
						{
							var_filter_query.append(" or ")
						}
					}
					var_filter_query.append(")")
				}
			else var_filter_query.append("("+custom_filter_operands[0]+"='"+custom_filter_operands[1]+"')")
		}
		if(i!=custom_filter_list.length-1)
		{
			var_filter_query.append(" and ")
		}
		else var_filter_query.append(")")
	}

	def XpathQuerySB="/queryCompoundEmployeeResponse/CompoundEmployee["+var_filter_query.toString()+"]"
	
}