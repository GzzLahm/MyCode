package cn.edu.guet.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.guet.dao.PayRecordDao;
import cn.edu.guet.entity.PayRecord;
import cn.edu.guet.service.PayRecordService;
@Service("payRecordService")
public class PayRecordServiceImpl implements PayRecordService{
	@Autowired
	private PayRecordDao payRecordDao;
	@Override
	public int add(Map map) {
		// TODO Auto-generated method stub
		return payRecordDao.addPayRecord(map);
	}
	@Override
	public List<PayRecord> getPayRecordByStuId(Integer id) {
		// TODO Auto-generated method stub
		return payRecordDao.getPayRecordByStuId(id);
	}
	@Override
	public List<PayRecord> getPayRecordByPage(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return payRecordDao.getPayRecordByPage(map);
	}
	@Override
	public int getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return payRecordDao.getTotal(map);
	}
	@Override
	public int delete(int id) {
		// TODO Auto-generated method stub
		return payRecordDao.delete(id);
	}
	@Override
	public int update(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return payRecordDao.update(map);
	}

}
