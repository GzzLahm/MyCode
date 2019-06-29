package cn.edu.guet.utils;

import java.util.ArrayList;
import java.util.List;

public class StringUtil {
	public static boolean isEmpty(String str){
		if(str==null||"".equals(str.trim())){
			return true;
		}else{
			return false;
		}
	}
	public static boolean isNotEmpty(String str){
		if((str!=null)&&!"".equals(str.trim())){
			return true;
		}else{
			return false;
		}
	}
	public static void main(String[] args) {
		System.out.println(Integer.parseInt("09"));
		List<String> list=new ArrayList<>();
		list.add("1234");
		list.add("zs");
		list.remove(0);
		System.out.println(list.get(0));
	}
}
