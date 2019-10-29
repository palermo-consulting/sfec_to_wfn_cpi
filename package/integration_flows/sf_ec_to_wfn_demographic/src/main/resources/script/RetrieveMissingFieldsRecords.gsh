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
import java.io.IOException;
import java.util.List;
import org.jdom.Content;
import org.jdom.Document;
import org.jdom.Element
import org.jdom.input.SAXBuilder;
import org.jdom.JDOMException;
import org.jdom.output.XMLOutputter;
import java.util.ArrayList;

def Message processData(Message message) {
	
	//Body 
	def body = message.getBody();
	def map = message.getProperties();
	
	List<String> p = map.get("missingMandatoryFieldsRecordsProperty");
	StringBuffer str = new StringBuffer();
	str.append("<Messages>");
	
	for(String entry : p){
		str.append(entry);
	}
	str.append("</Messages>");
	def count = p.size();
	message.setProperty("emptyCheckMF",count);
	
	message.setBody(str.toString());
	
	return message;
	
}

