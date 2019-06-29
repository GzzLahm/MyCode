package cn.edu.guet.dao;

import java.util.List;
import java.util.Map;

import cn.edu.guet.entity.PayRecord;

public interface PayRecordDao {
	public int addPayRecord(Map map);

	public List<PayRecord> getPayRecordByStuId(Integer stuId);

	public List<PayRecord> getPayRecordByPage(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

	public int delete(int id);

	public int update(Map<String, Object> map);
}
