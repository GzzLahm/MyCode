package cn.edu.guet.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import cn.edu.guet.entity.College;
import cn.edu.guet.entity.Major;
import cn.edu.guet.entity.PayRecord;
import cn.edu.guet.entity.Student;
import cn.edu.guet.entity.Thing;
import cn.edu.guet.service.CollegeService;
import cn.edu.guet.service.MajorService;
import cn.edu.guet.service.PayRecordService;
import cn.edu.guet.service.StudentService;
import cn.edu.guet.service.ThingService;
import cn.edu.guet.utils.Date2StringUtil;
import cn.edu.guet.utils.FileUtils;
import cn.edu.guet.utils.HrmsMath;
import cn.edu.guet.utils.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@RequestMapping("/student")
public class StudentController {
	@Resource
	private StudentService studentService;
	@Resource
	private CollegeService collegeService;
	@Resource
	private MajorService majorService;
	@Autowired
	private ThingService thingService;
	@Autowired
	private PayRecordService payRecordService;
	@RequestMapping("/list")
	public String listStudent(@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "studentId", required = false) String studentId,
			@RequestParam(value = "stuName", required = false) String stuName,
			@RequestParam(value = "majorId", required = false) String majorId, HttpServletResponse response)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		if ((majorId != null) && (!majorId.equals(""))) {
			Integer mId = Integer.parseInt(majorId);
			map.put("majorId", mId);
		}
		if ((studentId != null) && (!studentId.equals(""))) {
			map.put("studentId", studentId);
		}
		if ((stuName != null) && (!stuName.equals(""))) {
			map.put("stuName", stuName);
		}
		int start = (Integer.parseInt(page) - 1) * Integer.parseInt(rows);
		map.put("start", start);
		map.put("size", Integer.parseInt(rows));
		List<Student> list = studentService.getStudentByPage(map);
		for (Student stu : list) {
			List<Thing> notGet = new ArrayList<>();
			for (Thing t : stu.getMajor().getThings()) {
				notGet.add(t);
			}
			String[] arrStr = null;
			if ((stu.getThing() != null) && (!stu.getThing().equals(""))) {
				arrStr = stu.getThing().split(",");
				List<Thing> ths = new ArrayList<>();
				for (String thId : arrStr) {
					Thing thing = thingService.getThingById(Integer.parseInt(thId));
					ths.add(thing);
					if (notGet.size() > 0) {
						for (int i = 0; i < notGet.size(); i++) {
							if (notGet.get(i).getId() == thing.getId()) {
								notGet.remove(i);
							}
						}
					}
				}
				stu.setThings(ths);
			}
			stu.setNotGet(notGet);
			List<PayRecord> payList=payRecordService.getPayRecordByStuId(stu.getId());
			BigDecimal paiedTuition=new BigDecimal("0.00");
			for(PayRecord pay:payList) {
				paiedTuition=paiedTuition.add(pay.getAmount());
			}
			stu.setPaiedTuition(paiedTuition);
		}
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[] { "major", "archives", "thing", "gender", "birth", "things" });
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list, jsonConfig);
		int total = studentService.getTotal(map);
		result.put("total", total);
		result.put("rows", jsonArray);
		ResponseUtil.write(response, result);
		return null;
	}

	@RequestMapping(value = "/importStudent")
	public String importStudent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartRequest.getFile("studentFile");
		String fileName = file.getOriginalFilename();
		System.out.println(fileName);
		String suffix = fileName.substring(fileName.lastIndexOf("."));
		File uploadFile = new File(
				request.getSession().getServletContext().getRealPath("/upload/") + System.currentTimeMillis() + suffix);
		file.transferTo(uploadFile);
		System.out.println(uploadFile.getPath());
		HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(uploadFile));
		// 根据名称获得指定Sheet对象
		HSSFSheet hssfSheet = workbook.getSheet("Sheet1");
		for (Row row : hssfSheet) {
			int rowNum = row.getRowNum();
			if (rowNum == 0) {
				continue;
			}
			String IDCard = row.getCell(0).getStringCellValue();
			String stuName = row.getCell(1).getStringCellValue();
			String gender = row.getCell(2).getStringCellValue();
			String ticket = new BigDecimal(row.getCell(3).getNumericCellValue()).toPlainString();
			double score = row.getCell(4).getNumericCellValue();
			String highsc = row.getCell(5).getStringCellValue();
			String majorName = row.getCell(6).getStringCellValue();
			String collegeName = row.getCell(7).getStringCellValue();
			College existCollege = collegeService.getCollegeByName(collegeName);
			if (existCollege == null) {
				College college = new College();
				college.setCollegeName(collegeName);
				collegeService.addCollege(college);
				college = collegeService.getCollegeByName(college.getCollegeName());
				Major major = new Major();
				major.setCollege(college);
				major.setMajorName(majorName);
				majorService.addMajor(major);
			} else {
				Major existMajor = majorService.getMajorByName(majorName);
				if (existMajor == null) {
					Major major = new Major();
					major.setMajorName(majorName);
					major.setCollege(existCollege);
					majorService.addMajor(major);
					major = majorService.getMajorByName(major.getMajorName());
				}
			}
			Major major = majorService.getMajorByName(majorName);
			Student existStudent = studentService.getStudentByIDCard(IDCard);
			if (existStudent == null) {
				Student student = new Student();
				Date date=Date2StringUtil.stringToDateLong(HrmsMath.getBirthday(IDCard));
				student.setBirth(date);
				student.setStudentName(stuName);
				student.setScore((int) score);
				student.setHighsc(highsc);
				student.setMajor(major);
				student.setIDCard(IDCard);
				student.setTicket(ticket);
				if (gender.equals("男")) {
					student.setGender(1);
				} else {
					student.setGender(0);
				}
				studentService.addStudent(student);
			}
		}
		return null;
	}

	@RequestMapping("/update")
	public String update(Student student, String birthv, String majorName, String addr,HttpServletResponse response)
			throws Exception {
		if((addr!=null)&&(!addr.equals(""))) {
			student.setAddress(addr);
		}
		student.setMajor(majorService.getMajorByName(majorName));
		student.setBirth(Date2StringUtil.stringToDateLong(birthv));
		int total = studentService.updateStudent(student);
		JSONObject result = new JSONObject();
		if (total > 0) {
			result.put("success", true);
		} else {
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}

	@RequestMapping("/preDistribute")
	public String preDistribute(String id, String thingGet, HttpServletResponse response) throws Exception {
		Student student = studentService.getStudentById(Integer.parseInt(id));
		if ((thingGet != null) && (!thingGet.equals(""))) {
			String[] thingNames = thingGet.split("、");
			for (String thingName : thingNames) {
				Thing thing = thingService.getThingByName(thingName);
				for (int i = 0; i < student.getMajor().getThings().size(); i++) {
					if (student.getMajor().getThings().get(i).getId() == thing.getId()) {
						student.getMajor().getThings().remove(i);
					}
				}
			}
		}
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(student.getMajor().getThings());
		result.put("things", jsonArray);
		ResponseUtil.write(response, result);
		return null;
	}

	@RequestMapping("/distribute")
	public String distribute(String ids, String id, HttpServletResponse response) throws Exception {
		Student student = studentService.getStudentById(Integer.parseInt(id));
		if ((student.getThing() != null)&&(!student.getThing().equals(""))) {
			ids = student.getThing() + "," + ids;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", student.getId());
		map.put("thing", ids);
		int total = studentService.updateThing(map);
		JSONObject result = new JSONObject();
		if (total > 0) {
			result.put("success", true);
		} else {
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/separateStu")
	public String separateStu(String ids,String classNo,HttpServletResponse response) throws Exception{
		String [] array=ids.split(",");
		Map<String,Object> map=new HashMap<>();
		map.put("studentId", classNo);
		List<String> idList=new ArrayList<>();
		for(String id:array) {
			idList.add(id);
		}
		int total=studentService.getTotal(map);
		List<Student> studentList=studentService.getStudentByMap(map);
		if(studentList.size()>0) {
			int index=studentList.get(0).getStudentId().length()-2;
			int preTemp=0,nextTemp;
			for(int j=0;j<total;j++) {
				if(j==0) {
					nextTemp=Integer.parseInt(studentList.get(j).getStudentId().substring(index));
				}else {
					preTemp=Integer.parseInt(studentList.get(j-1).getStudentId().substring(index));
					nextTemp=Integer.parseInt(studentList.get(j).getStudentId().substring(index));
				}
				if((nextTemp-preTemp)>1) {
					for(int i=0;(i<(nextTemp-preTemp-1))&&(idList.size()>0);i++) {
						Student student=studentService.getStudentById(Integer.parseInt(idList.get(0)));
						System.out.println(classNo+"0"+(preTemp+i+1));
						if((preTemp+i+1)<9) {
							student.setStudentId(classNo+"0"+(preTemp+i+1));
						}else {
							student.setStudentId(classNo+(total+i+1));
						}
						studentService.updateStudent(student);
						idList.remove(0);
					}
				}
			}
		}
		total=studentService.getTotal(map);
		if(idList.size()>0) {
			for(int i=0;i<idList.size();i++) {
				Student student=studentService.getStudentById(Integer.parseInt(idList.get(0)));
				if((total+i+1)<9) {
					student.setStudentId(classNo+"0"+(total+i+1));
				}else {
					student.setStudentId(classNo+(total+i+1));
				}
				studentService.updateStudent(student);
				idList.remove(0);
			}
		}
		JSONObject result = new JSONObject();
		if(idList.size()==0) {
			result.put("success", true);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/deleteThing")
	public String deleteThing(String thingName,String sid,HttpServletResponse response) throws Exception {
		Thing thing=thingService.getThingByName(thingName);
		Student student=studentService.getStudentById(Integer.parseInt(sid));
		String [] thingStr=student.getThing().split(",");
		List<String> thingList=new ArrayList<>();
		for(String str:thingStr) {
			thingList.add(str);
		}
		for(int i=0;i<thingList.size();i++) {
			if(thingList.get(i).equals(""+thing.getId())){
				thingList.remove(i);
			}
		}
		String ids="";
		if(thingList.size()>0) {
			for(int i=0;i<thingList.size();i++) {
				if(i!=(thingList.size()-1)) {
					ids=ids+thingList.get(i)+",";
				}else {
					ids=ids+thingList.get(i);
				}
			}
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", student.getId());
		map.put("thing", ids);
		int total = studentService.updateThing(map);
		JSONObject result = new JSONObject();
		if(total>0) {
			result.put("success", true);
		}else {
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/updateStuId")
	public String updateStuId(Student student,HttpServletResponse response) throws Exception {
		String stuId=student.getStudentId();
		Student existStudent=studentService.getStudentByStuid(student.getStudentId());
		student=studentService.getStudentById(student.getId());
		student.setStudentId(stuId);
		int total=0;
		JSONObject result = new JSONObject();
		if(existStudent==null) {
			total = studentService.updateStudent(student);
		}
		if(total>0) {
			result.put("success", 1);
		}else {
			result.put("success", 0);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/setNoticeNo")
	public String setNoticeNo(String majorId,String noticeNO,HttpServletResponse response) throws Exception {
		Map<String,Object> map=new HashMap<>();
		map.put("majorId", Integer.parseInt(majorId));
		List<Student> stuList=studentService.getStudentByMap(map);
		Student student=null;
		Map<String,Object> map1=new HashMap<>();
		map1.put("noticeNO", noticeNO);
		List<Student> checkList=studentService.getStudentByNotice(map1);
		JSONObject result = new JSONObject();
		if(checkList.size()>0) {
			result.put("success", 0);
		}else {
			for(int i=0;i<stuList.size();i++)
			{
				if(i<9) {
					student=stuList.get(i);
					student.setNoticeNO(noticeNO+"00"+(i+1));
				}else if((i>=9)&&(i<99)) {
					student=stuList.get(i);
					student.setNoticeNO(noticeNO+"0"+(i+1));
				}else {
					student=stuList.get(i);
					student.setNoticeNO(noticeNO+(i+1));
				}
				studentService.updateStudent(student);
			}
			result.put("success", 1);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/exportData")
	public String exportXls(String majorId,HttpServletRequest request,HttpServletResponse response) throws IOException{
		//第一步：查询所有的学生数据
		Map<String,Object> map=new HashMap<>();
		map.put("majorId", Integer.parseInt(majorId));
		List<Student> stuList=studentService.getStudentByMap(map);
		
		//第二步：使用POI将数据写到Excel文件中
		//在内存中创建一个Excel文件
		HSSFWorkbook workbook = new HSSFWorkbook();
		String majorName=stuList.get(0).getMajorName();
		//创建一个标签页
		HSSFSheet sheet = workbook.createSheet(majorName);
		//创建标题行
		HSSFRow headRow = sheet.createRow(0);
		headRow.createCell(0).setCellValue("学号");
		headRow.createCell(1).setCellValue("姓名");
		headRow.createCell(2).setCellValue("性别");
		headRow.createCell(3).setCellValue("身份证号码");
		headRow.createCell(4).setCellValue("出生日期");
		headRow.createCell(5).setCellValue("毕业高中");
		headRow.createCell(6).setCellValue("准考证号");
		headRow.createCell(7).setCellValue("高考成绩");
		headRow.createCell(8).setCellValue("通知书编号");
		
		for (Student student : stuList) {
			HSSFRow dataRow = sheet.createRow(sheet.getLastRowNum() + 1);
			dataRow.createCell(0).setCellValue(student.getStudentId());
			dataRow.createCell(1).setCellValue(student.getStudentName());
			dataRow.createCell(2).setCellValue(student.getGenderv());
			dataRow.createCell(3).setCellValue(student.getIDCard());
			dataRow.createCell(4).setCellValue(student.getFormatBirth());
			dataRow.createCell(5).setCellValue(student.getHighsc());
			dataRow.createCell(6).setCellValue(student.getTicket());
			dataRow.createCell(7).setCellValue(student.getScore());
			dataRow.createCell(8).setCellValue(student.getNoticeNO());
		}
		
		//第三步：使用输出流进行文件下载（一个流、两个头）
		
		String filename =majorName+ "专业学生信息.xls";
		String contentType = request.getServletContext().getMimeType(filename);
		ServletOutputStream out = response.getOutputStream();
		response.setContentType(contentType);
		
		//获取客户端浏览器类型
		String agent = request.getHeader("User-Agent");
		filename = FileUtils.encodeDownloadFilename(filename, agent);
		response.setHeader("content-disposition", "attachment;filename="+filename);
		workbook.write(out);
		return null;
	}
}
