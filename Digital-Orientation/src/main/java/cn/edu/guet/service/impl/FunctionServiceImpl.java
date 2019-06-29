package cn.edu.guet.service.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.guet.dao.FunctionDao;
import cn.edu.guet.entity.Function;
import cn.edu.guet.entity.Role;
import cn.edu.guet.entity.User;
import cn.edu.guet.service.FunctionService;
@Service("/functionService")
public class FunctionServiceImpl implements FunctionService {
	@Autowired 
	private FunctionDao functionDao;
	@Override
	public List<Function> getMenu(HttpSession session) {
		// TODO Auto-generated method stub
		User currentUser=(User) session.getAttribute("loginUser");
		for(Role role:currentUser.getRoles()) {
			if(role.getRoleName().equals("超级管理员")) {
				return functionDao.getAllMenu();
			}
		}
		List<Function> chilList=functionDao.getMenuByUserId(currentUser.getId());
		List<Function> parentList=functionDao.getParentMenu(currentUser.getId());
		for(Function fun:parentList) {
			chilList.add(fun);
		}
		return chilList;
	}
	@Override
	public List<Function> getAllFunction() {
		// TODO Auto-generated method stub
		return functionDao.getAllFunction();
	}

}
