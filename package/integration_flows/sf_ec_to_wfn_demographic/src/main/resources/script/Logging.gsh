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
import java.util.ArrayList;
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
	
	def map = message.getProperties();
	
	SAXBuilder builder = new SAXBuilder();
	
	InputStream stream = new ByteArrayInputStream(body.getBytes("UTF-8"));
	
	Document doc = builder.build(stream);

	StringBuffer str = new StringBuffer();
	
	def invalidRecords = map.get("invalidRecordsProperty");
	
	def var_filter = "/queryCompoundEmployeeResponse/CompoundEmployee"
	str.append(evaluateXpath(body,var_filter))
	if(str.length() > 0)
		invalidRecords.add(str.toString());
	
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
	
	if(!xpath.evaluate("person/person_id_external",l.item(i),XPathConstants.NODE))
	missingString.append("person/person_id_external is missing \n")
	
	if(!xpath.evaluate("person/personal_information/first_name",l.item(i),XPathConstants.NODE))
	missingString.append("person/personal_information/first_name is missing \n")

	if(!xpath.evaluate("person/personal_information/last_name",l.item(i),XPathConstants.NODE))
	missingString.append("person/personal_information/last_name is missing \n")
	
	if(!missingString.toString().equals("")){
	if(xpath.evaluate("person/person_id_external",l.item(i),XPathConstants.NODE)){
		xmlString.append("Person ID External: " + xpath.evaluate("person/person_id_external/text()",l.item(i),XPathConstants.STRING) + "\n")
	}
	else if(xpath.evaluate("log/log_item/person_id_external",l.item(i),XPathConstants.NODE)){
		xmlString.append("Person ID External: " + xpath.evaluate("log/log_item/person_id_external/text()",l.item(i),XPathConstants.STRING) + "\n")
	}
	else{
		xmlString.append("CompoundEmployee ID: " + xpath.evaluate("id/text()",l.item(i),XPathConstants.STRING) + "\n")
	}
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

