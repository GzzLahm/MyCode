package cn.edu.guet.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import cn.edu.guet.entity.Function;

public interface FunctionService {
	public List<Function> getMenu(HttpSession session);

	public List<Function> getAllFunction();
}
