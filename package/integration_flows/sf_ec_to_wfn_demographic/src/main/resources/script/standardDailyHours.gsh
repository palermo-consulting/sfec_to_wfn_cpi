import com.sap.it.api.mapping.*;

//Add MappingContext as an additional argument to read or set Headers and properties.

def String customFunc(String workingDaysPerWeek, String standardHours){
	if(!workingDaysPerWeek) 
    	return 0;
	else
   		return String.valueOf(Integer.valueOf(standardHours)/Integer.valueOf(workingDaysPerWeek));
}
