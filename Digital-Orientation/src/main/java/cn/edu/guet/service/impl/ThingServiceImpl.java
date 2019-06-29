package cn.edu.guet.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.guet.dao.ThingDao;
import cn.edu.guet.entity.Thing;
import cn.edu.guet.service.ThingService;
@Service("thingService")
public class ThingServiceImpl implements ThingService{
	@Autowired
	private ThingDao thingDao;
	@Override
	public Integer addThing(String thingName) {
		// TODO Auto-generated method stub
		return thingDao.addThing(thingName);
	}
	@Override
	public Thing getThingByName(String thingName) {
		// TODO Auto-generated method stub
		return thingDao.getThingByName(thingName);
	}
	@Override
	public Thing getThingById(int parseInt) {
		// TODO Auto-generated method stub
		return thingDao.getThingById(parseInt);
	}

}
