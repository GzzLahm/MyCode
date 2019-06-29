package cn.edu.guet.utils;

import java.util.Date;

public class HrmsMath {
	public static String getBirthday(String cardID) {
		String birth = null;
		StringBuffer tempStr = null;
		if (cardID != null && cardID.trim().length() > 0) {
			if (cardID.trim().length() == 15) { // 2000年以前出生的
				tempStr = new StringBuffer(cardID.substring(6, 12));
				tempStr.insert(4, '-');
				tempStr.insert(2, '-');
				tempStr.insert(0, "19");
			} else if (cardID.trim().length() == 18) {
				tempStr = new StringBuffer(cardID.substring(6, 14));
				tempStr.insert(6, '-');
				tempStr.insert(4, '-');
			}
		}
		if (tempStr != null && tempStr.toString().trim().length() > 0) {
			birth = tempStr.toString();
		}
		return birth;
	}
}