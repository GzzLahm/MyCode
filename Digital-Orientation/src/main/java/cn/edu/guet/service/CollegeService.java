package cn.edu.guet.service;

import java.util.List;

import cn.edu.guet.entity.College;

public interface CollegeService {
	public Integer addCollege(College college);
	public Integer updateCollege(College college);
	public College getCollegeByName(String name);
	public List<College> getAll();
}
