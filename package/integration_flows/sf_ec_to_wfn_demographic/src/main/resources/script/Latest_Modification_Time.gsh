import com.sap.gateway.ip.core.customdev.util.Message;
import java.io.StringWriter;
import org.xml.sax.InputSource;
import javax.xml.xpath.*;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.*;
import javax.xml.transform.TransformerFactory;  
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.dom.DOMSource;
import java.io.File;
import java.io.IOException;
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

def Message processData(Message message) {
	
	def body = message.getBody(String.class);
	def map = message.getHeaders();
	def prop = message.getProperties();
	SAXBuilder builder = new SAXBuilder();
	
	InputStream stream = new ByteArrayInputStream(body.getBytes("UTF-8"));	
	Document doc = builder.build(stream);
	
	XPath xPathLastModified = new JDOMXPath("//last_modified_on/..");
	List employeeNodes = xPathLastModified.selectNodes(doc);
	
	Element root = doc.getRootElement();	
	Element person = root.getChild("person");
	
	//build sorted set of all last modified dates
	SortedSet sortedModifiedDates = new TreeSet();
	
	for (Element employeeNode : employeeNodes) 
	{
		sortedModifiedDates.add(employeeNode.getChildText("last_modified_on"));
	}
	
	String latestLastModifiedDate = sortedModifiedDates.last();

	Element lastModificationTime = new Element("last_modification_time");
	lastModificationTime.setText(latestLastModifiedDate);
	
	person.addContent(lastModificationTime);
	
	// Output the XML request having the appropriate namespaces
	XMLOutputter outputter = new XMLOutputter(Format.getCompactFormat().setOmitDeclaration(true));
    is = new ByteArrayInputStream(outputter.outputString(doc).getBytes("UTF-8"));
    message.setBody(is);
    message.setProperty("originalPayload",outputter.outputString(doc));
    return message;
}