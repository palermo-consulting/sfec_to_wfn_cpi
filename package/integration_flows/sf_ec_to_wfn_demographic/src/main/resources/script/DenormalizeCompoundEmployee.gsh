import groovy.xml.StreamingMarkupBuilder;
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
import org.jaxen.jdom.JDOMXPath;
import org.jdom.Namespace;
import com.sap.gateway.ip.core.customdev.util.Message;

def Message processData(Message message) {

InputStream is = new ByteArrayInputStream(message.getBody(String.class).getBytes("UTF-8"));
XMLOutputter xmlOutputter = new XMLOutputter(Format.getCompactFormat());

List effectiveDatedNames = ["compensation_information", "employment_information", "personal_information", "address_information"];
List includeLatest = ["personal_information", "address_information"];

// Build XML Document
SAXBuilder builder = new SAXBuilder();
// Here's how to grab values from the current data
// Determine Current Date
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
Date currentDate = new Date();

// changes by Ashwani 

//precompile the xpath. Note document looping should be done below this.
XPath xPathStartDate = new JDOMXPath(".//start_date/..");
XPath xPathPersonChildren = new JDOMXPath("./person/*");

// end of changes by Ashwani
Document doc = builder.build(is);
List <Element> CompoundEmployeeList = doc.getRootElement().getChildren("CompoundEmployee");
Element root = new Element("queryCompoundEmployeeResponse");
Document newDocument = new Document(root);
//InputStream is = new ByteArrayInputStream(xml.getBytes());
for( Element origCompEmp: CompoundEmployeeList) {
  
  Element newCompEmp = new Element("CompoundEmployee");
  //Document newDoc = new Document(newDocRoot);

  
  Element newPerson = new Element("person");
  newCompEmp.addContent(newPerson);

  for(Element child: xPathPersonChildren.selectNodes(origCompEmp))
  {	//System.err.println(child.getName());
     if (!effectiveDatedNames.contains(child.getName()))
       newPerson.addContent(child.clone());
     
  }
  List employeeNodes = xPathStartDate.selectNodes(origCompEmp)
  //build sorted set of all start dates
  SortedSet sortedStartDates = new TreeSet();
 

  for (Element employeeNode : employeeNodes) 
  {
    //don't check for effective dates in non-effective dated entities
    if (isEffectiveDatedEntity(employeeNode))
      sortedStartDates.add(employeeNode?.getChildText("start_date", employeeNode.getNamespace()))	  
	
  }


   int setLength = sortedStartDates.size();
   int check = 0;
   int is_earliest_effective_dated_flag = 1;
  for (String snapShotDate:sortedStartDates)	
  {
	
     check = check + 1;
    //Document clonedDoc = doc.clone();
    Element clonedCompEmp = origCompEmp.clone();
	
    employeeNodes = xPathStartDate.selectNodes(clonedCompEmp)
    List<Element> elementsToDelete = new ArrayList<Element>()
  
    //Create a new document to hold the data snapshot
    Element snapShotElement = new Element("snapshot");
    newPerson.addContent(snapShotElement);
    Element dateElement = new Element("asOfDate");
    dateElement.setText(snapShotDate);
    snapShotElement.addContent(dateElement);		
    
    Element isEarliestEffectiveDatedElement = new Element("is_earliest_effective_dated");
    
    if (is_earliest_effective_dated_flag == 1){
    
    isEarliestEffectiveDatedElement.setText("true");
    is_earliest_effective_dated_flag = 0;
    
    }
    else {
    
    isEarliestEffectiveDatedElement.setText("false");
    
    }
    snapShotElement.addContent(isEarliestEffectiveDatedElement);
    
    currentDate = dateFormat.parse(snapShotDate);

    for (Element employeeNode : employeeNodes)
    {
      if (!employeeNode.getName().equals("employment_information"))
      {
        //don't check for effective dates in non-effective dated entities
        Date startDate = dateFormat.parse(employeeNode?.getChildText("start_date", employeeNode.getNamespace()))
        Date endDate = dateFormat.parse(employeeNode?.getChildText("end_date", employeeNode.getNamespace()))
        //Date outside current date range  must be removed
        if ( (currentDate < startDate || currentDate > endDate))
        {
          elementsToDelete.add(employeeNode)
        }
      }

    }
    // Remove node outside the current date range
    for (Element element : elementsToDelete) {
      element.getParent().removeContent(element);
    }
    for(Element child: xPathPersonChildren.selectNodes(clonedCompEmp))
    {
      if (effectiveDatedNames.contains(child.getName()))
         snapShotElement.addContent(child.clone());
	  if (includeLatest.contains(child.getName()) && check == setLength)
	  {
	     newPerson.addContent(child.clone());
	  }
    }
	  
  }
  
  //System.err.println(xmlOutputter.outputString(newPerson));
  root.addContent(newCompEmp)
  
}

  message.setBody(xmlOutputter.outputString(newDocument));
    //Message returnMessage =  new ByteArrayInputStream(xmlOutputter.outputString(newDocument).getBytes("UTF-8"));
  return message;
//println xmlOutputter.outputString(newDoc);
}
def boolean isEffectiveDatedEntity(Element employeeNode)
{
  return !(employeeNode.getChildText("start_date", employeeNode.getNamespace())==null
  || employeeNode.getChildText("end_date",employeeNode.getNamespace())==null
  || employeeNode.name =="employment_information");
}
