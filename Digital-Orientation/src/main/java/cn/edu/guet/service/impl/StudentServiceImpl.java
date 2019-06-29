package cn.edu.guet.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.edu.guet.dao.StudentDao;
import cn.edu.guet.entity.Student;
import cn.edu.guet.service.StudentService;
@Service("studentService")
public class StudentServiceImpl implements StudentService {
	@Resource
	private StudentDao studentDao;

	@Override
	public List<Student> getStudentByPage(Map map) {
		// TODO Auto-generated method stub
		return studentDao.getStudentByPage(map);
	}

	@Override
	public int addStudent(Student student) {
		// TODO Auto-generated method stub
		return studentDao.addStudent(student);
	}

	@Override
	public int getTotal(Map map) {
		// TODO Auto-generated method stub
		return studentDao.getTotal(map);
	}

	@Override
	public Student getStudentByStuid(String stuId) {
		// TODO Auto-generated method stub
		return studentDao.getStudentByStuid(stuId);
	}

	@Override
	public int updateStudent(Student student) {
		// TODO Auto-generated method stub
		return studentDao.updateStudent(student);
	}

	@Override
	public Student getStudentById(Integer id) {
		// TODO Auto-generated method stub
		return studentDao.getStudentById(id);
	}

	@Override
	public int updateThing(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return studentDao.updateThing(map);
	}

	@Override
	public Student getStudentByIDCard(String IDCard) {
		// TODO Auto-generated method stub
		return studentDao.getStudentByIDCard(IDCard);
	}

	@Override
	public List<Student> getStudentByMap(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return studentDao.getStudentByMap(map);
	}

	@Override
	public List<Student> getStudentByNotice(Map map) {
		// TODO Auto-generated method stub
		return studentDao.getStudentByNotice(map);
	}

}
