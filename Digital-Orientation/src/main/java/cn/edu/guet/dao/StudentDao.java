package cn.edu.guet.dao;

import java.util.List;
import java.util.Map;

import cn.edu.guet.entity.Major;
import cn.edu.guet.entity.Student;

public interface StudentDao {

	public List<Student> getStudentByPage(Map map);

	public int addStudent(Student student);

	public int getTotal(Map map);

	public Student getStudentByStuid(String stuId);

	public List<Student> getStudentByMajor(Major major);

	public int updateStudent(Student student);

	public Student getStudentById(Integer id);

	public int updateThing(Map<String, Object> map);

	public Student getStudentByIDCard(String iDCard);

	public List<Student> getStudentByMap(Map<String, Object> map);

	public List<Student> getStudentByNotice(Map map);
}
