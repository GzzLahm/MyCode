package cn.edu.guet.utils;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Date2StringUtil {
	public static String DateFormat(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(date);
	}
	public static String DateFormatDetail(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss");
		return sdf.format(date);
	}
	public static Date stringToDateLong(String strDate) {
	     SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	     ParsePosition pos = new ParsePosition(0);
	     Date strtodate = formatter.parse(strDate, pos);
	     return strtodate;
	 }
	public static void main(String[] args) {
		System.out.println(Date2StringUtil.DateFormat(new Date()));
	}
}
