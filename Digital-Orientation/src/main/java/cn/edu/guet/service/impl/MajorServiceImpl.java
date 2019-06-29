package cn.edu.guet.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.edu.guet.dao.MajorDao;
import cn.edu.guet.entity.Major;
import cn.edu.guet.service.MajorService;

@Service("majorService")
public class MajorServiceImpl implements MajorService{
	@Resource
	private MajorDao majorDao;
	@Override
	public Integer addMajor(Major major) {
		// TODO Auto-generated method stub
		return majorDao.addMajor(major);
	}

	@Override
	public Integer updateMajor(Major major) {
		// TODO Auto-generated method stub
		return majorDao.updateMajor(major);
	}

	@Override
	public Major getMajorByName(String name) {
		// TODO Auto-generated method stub
		return majorDao.getMajorByName(name);
	}

	@Override
	public List<Major> getMajorByMap(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return majorDao.getMajorByMap(map);
	}

	@Override
	public Major getMajorById(Integer id) {
		// TODO Auto-generated method stub
		return majorDao.getMajorById(id);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return majorDao.getTotal(map);
	}
}
