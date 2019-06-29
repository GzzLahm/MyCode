package cn.edu.guet.utils;

import org.apache.shiro.crypto.hash.Md5Hash;

public class Md5Util {
	public static String md5(String password,String salt) {
		return new Md5Hash(password,salt).toString();
	}
	public static void main(String[] args) {
		System.out.println(Md5Util.md5("123456", "admin"));
	}
}
