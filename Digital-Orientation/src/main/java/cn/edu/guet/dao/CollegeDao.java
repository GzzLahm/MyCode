package cn.edu.guet.dao;

import java.util.List;

import cn.edu.guet.entity.College;

public interface CollegeDao {
	public College getCollegeById(Integer id);
	public College getCollegeByName(String name);
	public Integer addCollege(College college);
	public Integer updateCollege(College college);
	public List<College> getAllCollege();
}
