package cn.edu.guet.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.guet.dao.Thing_MajorDao;
import cn.edu.guet.service.Thing_MajorService;
@Service("thing_MajorService")
public class Thing_MajorServiceImpl implements Thing_MajorService {
	@Autowired
	private Thing_MajorDao thing_MajorDao;
	@Override
	public Integer addThing_Major(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return thing_MajorDao.addThing_Major(map);
	}
	@Override
	public int deleteThing_Major(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return thing_MajorDao.deleteThing_Major(map);
	}

}
