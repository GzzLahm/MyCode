package cn.edu.guet.service;

import java.util.List;
import java.util.Map;

import cn.edu.guet.entity.User;
public interface UserService {
	public User getUser(Map<String,Object> map);

	public User getUserByName(String userName);

	public int updatePassword(User currentUser);

	public List<User> getUserByPage(Map<String, Object> map);

	public int getTotal();

	public int add(User user);

	public int update(User user);

	public User getUserById(Integer id);

	public int delete(int parseInt);
	
	
}
