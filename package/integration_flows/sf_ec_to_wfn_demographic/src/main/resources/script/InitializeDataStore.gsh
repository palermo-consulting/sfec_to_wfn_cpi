/*
* Initialize all the data store
*/


import com.sap.gateway.ip.core.customdev.util.Message;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

def Message processData(Message message) {
	
	//Body 
	def body = message.getBody();
	List<String> warningRecords = new ArrayList<String>();
	List<String> invalidRecords = new ArrayList<String>();
	List<String> badDataRecords = new ArrayList<String>();
	List<String> historicalRecords = new ArrayList<String>();
	List<String> missingMandatoryFieldsRecords = new ArrayList<String>();
	List<String> persist_time_List = new ArrayList<String>();
	
	message.setProperty("warningRecordsProperty",warningRecords);
	message.setProperty("invalidRecordsProperty",invalidRecords);
	message.setProperty("badDataRecordsProperty",badDataRecords);
	message.setProperty("historicalRecordsProperty",historicalRecords);
	message.setProperty("missingMandatoryFieldsRecordsProperty",missingMandatoryFieldsRecords);
	message.setProperty("persist_time_ListProperty",persist_time_List);

	
	return message;
}