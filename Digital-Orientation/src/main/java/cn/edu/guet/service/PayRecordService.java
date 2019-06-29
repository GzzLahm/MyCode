package cn.edu.guet.service;

import java.util.List;
import java.util.Map;

import cn.edu.guet.entity.PayRecord;

public interface PayRecordService {
	public int add(Map map);

	public List<PayRecord> getPayRecordByStuId(Integer id);

	public List<PayRecord> getPayRecordByPage(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

	public int delete(int id);

	public int update(Map<String, Object> map);
}
