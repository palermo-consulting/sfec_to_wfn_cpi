import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

DateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
Date date = new Date(); //Format Fri Nov 15 17:55:48 EST 2019

println(date.toString());

String dateString = dateFormat.format(date); //Format 2019-11-15
println(dateString);