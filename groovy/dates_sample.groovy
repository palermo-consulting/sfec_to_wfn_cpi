import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

DateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
Date date = new Date(); //Today's date in the format Fri Nov 15 17:55:48 EST 2019

println(date.toString());

String today = dateFormat.format(date); //Format 2019-11-15
println(today);