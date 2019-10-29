import com.sap.it.api.mapping.*;

//Add MappingContext as an additional argument to read or set Headers and properties.

def String customFunc(String input1, String input2){
	if(input1 == "1")
	   return input2;
	else
	  return input1;
}
