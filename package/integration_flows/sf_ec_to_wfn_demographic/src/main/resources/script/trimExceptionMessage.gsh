import com.sap.gateway.ip.core.customdev.util.Message;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.IOException;

def Message processData(Message message) {
	
	//Body 
	def body = message.getBody();
	def map = message.getProperties();
	
	def exceptionString = "Exception at  " + map.get("pointOfFailure") + "with Message - " + body;
	if(exceptionString.length() > 499)
		exceptionString = exceptionString.substring(0,499);
	
	message.setProperty("exceptionProperty",exceptionString);
	Date currentDate = new Date();
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssz");
	message.setBody(dateFormat.format(currentDate));
	return message;

}