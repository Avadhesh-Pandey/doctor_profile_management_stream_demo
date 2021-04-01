
import 'package:intl/intl.dart';
import 'AppUtill.dart';


class DateTimeConverter{

  static String convert(String stringDate,{String outputFormat,String inputFormat})
  {
    if(stringDate!=null)
      {
        if(outputFormat==null)
        {
          outputFormat="dd MMM yy";
        }
        /*if(stringDate.contains("."))
        {
          stringDate=stringDate.split(".")[0];
        }*/
        DateTime dt = parseDate(stringDate,inputFormat);
        var newFormat = DateFormat(outputFormat);
        String updatedDt = newFormat.format(dt);
        return updatedDt;
      }
    return "";

  }

  static DateTime parseDate(String stringDate,String inputFormat)
  {
    if(AppUtill.isValid(inputFormat))
      {
        DateFormat dateFormat = DateFormat(inputFormat);
        return dateFormat.parse(stringDate);
      }
    else
      {
        return DateTime.parse(stringDate);
      }

  }

  static DateTime currentDateTime()
  {
    return DateTime.now();
  }

/*      Some predefined formats are mentioned here-under
        h:mm a                        //12:08 PM
        yyyy-MM-dd
        dd-MM-yyyy
        yyyy-MM-dd kk:mm:ss
        yyyy-MM-dd HH:mm:ss
        MM/dd/yyyy HH:mm:ss
        dd MMM yyyy
        MMM dd, yyyy HH:mm:ss aaa//   Mar 10, 2016 6:30:00 PM
        E, MMM dd yyyy                Fri, June 7 2013
        EEEE, MMM dd, yyyy HH:mm:ss a   //Friday, Jun 7, 2013 12:10:56 PM

        No.	Format	Example
        1	dd/mm/yy	03/08/06
        2	dd/mm/yyyy	03/08/2006
        3	d/m/yy	3/8/06
        4	d/m/yyyy	3/8/2006
        5	ddmmyy	030806
        6	ddmmyyyy	03082006
        7	ddmmmyy	03Aug06
        8	ddmmmyyyy	03Aug2006
        9	dd-mmm-yy	03-Aug-06
        10	dd-mmm-yyyy	03-Aug-2006
        11	dmmmyy	3Aug06
        12	dmmmyyyy	3Aug2006
        13	d-mmm-yy	3-Aug-06
        14	d-mmm-yyyy	3-Aug-2006
        15	d-mmmm-yy	3-August-06
        16	d-mmmm-yyyy	3-August-2006
        17	yymmdd	060803
        18	yyyymmdd	20060803
        19	yy/mm/dd	06/08/03
        20	yyyy/mm/dd	2006/08/03
        21	mmddyy	080306
        22	mmddyyyy	08032006
        23	mm/dd/yy	08/03/06
        24	mm/dd/yyyy	08/03/2006
        25	mmm-dd-yy	Aug-03-06
        26	mmm-dd-yyyy	Aug-03-2006
        27	yyyy-mm-dd	2006-08-03
        28	weekday, dth mmmm yyyy	Monday, 3 of August 2006
        29	weekday	Monday
        30	mmm-yy	Aug-06
        31	yy	06
        32	yyyy	2006
        33	dd-mmm-yyyy time	03-Aug-2006 18:55:30.35
        34	yyyy-mm-dd time24 (ODBC Std)	2006-08-03 18:55:30
        35	dd-mmm-yyyy time12	03-Aug-2006 6:55:30 pm
        36	time24	18:55:30
        37	time12	6:55:30 pm
        38	hours	48:55:30
        39	seconds	68538.350*/

}