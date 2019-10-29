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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

def Message processData(Message message) {
	
	
	StringBuffer str = new StringBuffer();
	
	//Headers 
	def pMap = message.getProperties();
	def company_ext = pMap.get("company");
	def division_ext = pMap.get("division");
	def employee_class_ext = pMap.get("employee_class");
	def company_territory_code_ext = pMap.get("company_territory_code");
	def business_unit_ext = pMap.get("business_unit");
	def location_ext = pMap.get("location");
	def pay_group_ext = pMap.get("pay_group");
	def person_id_external_ext = pMap.get("person_id_external");
	def ignore_modified_dates_ext = pMap.get("ignore_modified_dates");
	def local_last_modified_on = pMap.get("LOCAL_LAST_MODIFIED_ON");
	
	def prepand_and = 0;
	
	
	DateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
	Date date = new Date();
	
	if(!(person_id_external_ext.trim().isEmpty()))
	{
		str.append("person_id_external in('" + person_id_external_ext +"')");
		message.setProperty("debug","true");	
	}
	else
	{
		message.setProperty("debug","false");
        
		if(ignore_modified_dates_ext == "0" || ignore_modified_dates_ext.trim().isEmpty())
		{
		
			if(local_last_modified_on.size()>5)
			{
				local_last_modified_on = local_last_modified_on.substring(0,local_last_modified_on.size()-5)+"Z";
			}	
			str.append(" last_modified_on>to_datetime('" + local_last_modified_on + "') ");
			//str.append(" and last_modified_on>to_datetime('" + last_modified_on + "') ");
			prepand_and = 1;
		}
		
		if(!(company_ext.trim().isEmpty()))
		{
			if(prepand_and == 0)
			{
				str.append("company in('" + company_ext +"') ");
				prepand_and = 1;
			}else
			{
				str.append("and company in('" + company_ext +"') ");
			}	
		}
		
		if(!(business_unit_ext.trim().isEmpty()))
		{
			if(prepand_and == 0)
			{
				str.append("business_unit in('" + business_unit_ext +"') ");
				prepand_and = 1;
			}else
			{
				str.append("and business_unit in('" + business_unit_ext +"') ");
			}
			
		}
		
		if(!(pay_group_ext.trim().isEmpty()))
		{
			if(prepand_and == 0)
			{
				str.append("pay_group in('" + pay_group_ext +"') ");
				prepand_and = 1;
			}else
			{
				str.append("and pay_group in('" + pay_group_ext +"') ");
			}
			
		}
		
		if(!(company_territory_code_ext.trim().isEmpty()))
		{
			if(prepand_and == 0)
			{
				str.append("company_territory_code in('" + company_territory_code_ext +"') ");
				prepand_and = 1;
			}else
			{
				str.append("and company_territory_code in('" + company_territory_code_ext +"') ");
			}
			
		}
		
		if(!(division_ext.trim().isEmpty()))
		{
			if(prepand_and == 0)
			{
				str.append("division in('" + division_ext +"') ");
				prepand_and = 1;
			}else
			{
				str.append("and division in('" + division_ext +"') ");
			}
			
		}
		
		if(!(location_ext.trim().isEmpty()))
		{
			if(prepand_and == 0)
			{
				str.append("location in('" + location_ext +"') ");
				prepand_and = 1;
			}else
			{
				str.append("and location in('" + location_ext +"') ");
			}
			
		}
		
		if(!(employee_class_ext.trim().isEmpty()))
		{
			if(prepand_and == 0)
			{
				str.append("employee_class in('" + employee_class_ext + "') ");
				prepand_and = 1;
			}else
			{
				str.append("and employee_class in('" + employee_class_ext + "') ");
			}
			
		}
		
					
	}
	
	def val = str.toString().replace(",","','")
	
	if(!str.toString().isEmpty()){
		message.setProperty("QueryFilter"," where "+val);
		message.setHeader("QueryFilter"," where "+val);
		
	}else{
		message.setProperty("QueryFilter",val);
		message.setHeader("QueryFilter",val);
	}
	
	return message;
}

