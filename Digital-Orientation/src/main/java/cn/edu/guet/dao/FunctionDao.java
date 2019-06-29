package cn.edu.guet.dao;

import java.util.List;

import cn.edu.guet.entity.Function;

public interface FunctionDao {
	public List<Function> getAllMenu();
	
	public List<Function> getMenuByUserId(Integer userId);
	
	public Function getFunctionById(Integer id);
	
	public List<Function> getParentMenu(Integer userId);

	public List<Function> getAllFunction();
}
