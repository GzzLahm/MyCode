package cn.edu.guet.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.edu.guet.dao.CollegeDao;
import cn.edu.guet.entity.College;
import cn.edu.guet.service.CollegeService;
@Service("collegeService")
public class CollegeServiceImpl implements CollegeService{
	@Resource
	private CollegeDao collegeDao;
	@Override
	public Integer addCollege(College college) {
		// TODO Auto-generated method stub
		return collegeDao.addCollege(college);
	}

	@Override
	public Integer updateCollege(College college) {
		// TODO Auto-generated method stub
		return collegeDao.updateCollege(college);
	}

	@Override
	public College getCollegeByName(String name) {
		// TODO Auto-generated method stub
		return collegeDao.getCollegeByName(name);
	}

	@Override
	public List<College> getAll() {
		// TODO Auto-generated method stub
		return collegeDao.getAllCollege();
	}

}
