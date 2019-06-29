<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/usericons/myicon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/default.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath }/js/jquery.ocupload-1.1.2.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery.cityselect.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var url;
	function updateStudent() {
		$("#addr").val("");
		var selectedRows = $("#dg").datagrid("getSelections");
		if (selectedRows.length != 1) {
			$.messager.alert("系统提示", "请选择一条要编辑的数据！");
			return;
		}
		var row = selectedRows[0];
		if ((row.address != null) && (row.address != "")) {
			$.parser
					.parse($("#city_4")
							.append(
									"<input type='text' class='easyui-validatebox' style='height:18px;width:300px' id='address' name='address'/><a id='btn1' href='javascript:resetAddr()' title='重置'><img src='${pageContext.request.contextPath}/images/delete.png'></img></a>"));
			
		} else {
			var StrHtml = "<select id='prov' class='prov' style='width: 70px;height: 25px'></select> &nbsp;<select id='city' class='city' disabled='disabled' style='width: 70px;height: 25px'></select>&nbsp;<select id='dist' class='dist' disabled='disabled' style='width: 70px;height: 25px'></select>&nbsp;<input type='text' id='detailAdd' name='detailAdd' class='easyui-validatebox' style='width: 200px;height: 20px' required='true' placeholder='详细地址...'/>";
			$.parser.parse($("#city_4").append(StrHtml));
			$("#city_4").citySelect({
				prov : "-- 省 --",
				city : "-- 市 --",
				dist : "-- 区/县 --",
				nodata : "none"
			});
		}
		$("#dlg").dialog("open").dialog("setTitle", "编辑学生信息");
		$("#fm").form("load", row);
		url = "${pageContext.request.contextPath}/student/update.html";
		if (row.genderv == "男") {
			$('#gender').combobox('select', '1');
		} else {
			$('#gender').combobox('select', '0');
		}
		if (row.isarchives == "是") {
			$('#archives').combobox('select', '1');
		} else {
			$('#archives').combobox('select', '0');
		}
		if (row.isGreen_channel == "是") {
			$('#green_channel').combobox('select', '1');
		} else {
			$('#green_channel').combobox('select', '0');
		}
		if (row.isRegister == "是") {
			$('#register').combobox('select', '1');
		} else {
			$('#register').combobox('select', '0');
		}
		var birth = row.formatBirth;
		$('#birthv').datebox('setValue', birth);
		$.extend($.fn.validatebox.defaults.rules, {
			phoneNum : { //验证手机号  
				validator : function(value, param) {
					return /^1[3-9]+\d{9}$/.test(value);
				},
				message : '请输入正确的手机号码。'
			}
		});
	}
/* 	function formatOper(val, row, index) {
		return '<a href="#" style="text-decoration: none;"><img src="${pageContext.request.contextPath}/images/loading_icon.gif" alt=""></img></a>';
	} */
	function closeDialog() {
		$("#dlg").dialog("close");
	}
	function submitStudent() {
		var prov = $("#prov").val();
		var city = $("#city").val();
		var dist = $("#dist").val();
		var detailAdd = $("#detailAdd").val();
		var address;
		if (dist == null) {
			address = prov + city + detailAdd;
		} else {
			address = prov + city + dist + detailAdd;
		}
		$("#addr").val(address);
		if (prov == "--省--") {
			$.messager.alert("系统提示","请填写正确的地址","warning",function(){
			});
			/* alert("请填写正确的地址"); */
			return;
		}
		$("#fm").form("submit", {
			url : url,
			success : function(result) {
				result = eval("(" + result + ")");
				if (result.success) {
					$.messager.alert("系统提示", "修改学生信息成功", "info", function() {
						$("#dlg").dialog("close");
						$('#dg').datagrid('reload');
					});
				}
			}
		});
	}
	function resetAddr() {
		$("#address").remove();
		$("#btn1").remove();
		var StrHtml = "<select id='prov' class='prov' style='width: 70px;height: 25px'></select> &nbsp;<select id='city' class='city' disabled='disabled' style='width: 70px;height: 25px'></select>&nbsp;<select id='dist' class='dist' disabled='disabled' style='width: 70px;height: 25px'></select>&nbsp;<input type='text' id='detailAdd' name='detailAdd' class='easyui-validatebox' style='width: 200px;height: 20px' required='true' placeholder='详细地址...'/>";
		$.parser.parse($("#city_4").append(StrHtml));
		$("#city_4").citySelect({
			prov : "-- 省 --",
			city : "-- 市 --",
			dist : "-- 区/县 --",
			nodata : "none"
		});
	}
	function searchStu() {
		var studentId = $("#stuId").val();
		var majorId = $("#existMajorName").val();
		var stuName = $("#stuName").val();
		var url = "${pageContext.request.contextPath}/student/list.html?studentId="
				+ studentId + "&&majorId=" + majorId + "&&stuName=" + stuName;
		$("#dg").datagrid({
			url : url
		});
		$("#dg").datagrid("reload");
	}
	jQuery(document).ready(function() {
		$('#dlg').dialog({
			onClose : function() {
				$("#city_4").empty();
				$("#addr").remove();
			}
		});
	});
</script>
</head>
<body>
	<input id="existMajorName" type="hidden" value="${major.id}" />
	<table id="dg" title="学生信息管理" class="easyui-datagrid" pagination="true"
		rownumbers="true" 
		url="${pageContext.request.contextPath}/student/list.html" fit="true"
		toolbar="#tb">
		<thead data-options="frozen:true">
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
				<th field="id" width="10" align="center" hidden="true">编号</th>
				<th field="studentId" width="90" align="center">学号</th>
				<th field="studentName" width="90" align="center">学生姓名</th>
				<th field="genderv" width="30" align="center">性别</th>
				<th field="nation" width="50" align="center">民族</th>
				<th field="political" width="65" align="center">政治面貌</th>
				<th field="IDCard" width="100" align="center">身份证号</th>
				<th field="formatBirth" width="85" align="center">出生年月日</th>
				<th field="highsc" width="80" align="center">毕业高中</th>
				<th field="ticket" width="100" align="center">准考证号</th>
				<th field="score" width="50" align="center">高考成绩</th>
				<th field="majorName" width="100" align="center">录取专业</th>
				<th field="noticeNO" width="100" align="center">通知书编号</th>
				<th field="phone" width="100" align="center">电话号码</th>
				<th field="isarchives" width="70" align="center">提交档案</th>
				<th field="isRegister" width="70" align="center">是否报到</th>
				<th field="isGreen_channel" width="70" align="center">绿色通道</th>
				<th field="address" width="100" align="center">家庭住址</th>
				<!-- <th field="tuition" width="80" align="center">学费</th>
				<th field="paiedTuition" width="80" align="center">已交学费</th> -->
				<!-- <th field="unpaidTuition" width="80" align="center">未交学费</th> -->
				<!-- <th field="_operate" width="100" align="center"
					formatter="formatOper">操作</th> -->
			</tr>
		</thead>
	</table>
	<div id="tb" style="padding-top: 15px;">
		<c:if test="${empty major.id}">
			专业: <input class="easyui-combobox" style="width: 220px; height: 25px"
				id="major" name="major"
				data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'majorName',
			url:'${pageContext.request.contextPath}/major/list.html'" /> 
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</c:if>
		学号: <input type="text"
			style="height: 23px; width: 184px;" class="easyui-validatebox"
			id="stuId" name="stuId"
			onkeydown="if(event.keyCode==13) return searchStu()" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 姓名: <input type="text"
			style="height: 23px; width: 184px;" class="easyui-validatebox"
			id="stuName" name="stuName"
			onkeydown="if(event.keyCode==13) return searchStu()" />
		<script type="text/javascript">
			$("#major")
					.combobox(
							{
								onSelect : function(major) {
									var studentId = $("#stuId").val();
									var stuName = $("#stuName").val();
									var url = "${pageContext.request.contextPath}/student/list.html?studentId="
											+ studentId
											+ "&&majorId="
											+ major.id + "&&stuName=" + stuName;
									$("#dg").datagrid({
										url : url
									});
									$("#dg").datagrid("reload");
								}
							});
			var majorName = $("#existMajorName").val();
			if (majorName != null) {
				$("#major").combobox('select', majorName);
			}
			var majorId = $("#existMajorName").val();
			var url = "${pageContext.request.contextPath}/student/list.html?majorId=" + majorId;
			$("#dg").datagrid({
				url : url
			});
			$("#dg").datagrid("reload");
		</script>

		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:searchStu()"
			id="searchStu" class="easyui-linkbutton" iconCls="icon-search"
			plain="true">搜索</a> <br />
		<div>
			<table>
				<tr>
					<td><a href="javascript:updateStudent()"
						class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 700px; height: 550px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellpadding="15px">
				<tr>
					<td>学号:</td>
					<td><input type="text" id="studentId" name="studentId"
						class="easyui-validatebox" required="true" editable="false" /></td>
					<td>学生姓名:</td>
					<td><input type="text" id="studentName" name="studentName"
						class="easyui-validatebox" required="true" editable="false" /></td>
				</tr>
				<tr>
					<td>性别:</td>
					<td><select class="easyui-combobox" style="width: 154px"
						id="gender" name="gender" editable="false" panelHeight="auto">
							<option value="1">男</option>
							<option value="0">女</option>
					</select></td>
					<td>身份证号:</td>
					<td><input type="text" id="IDCard" name="IDCard"
						class="easyui-validatebox" required="true"
						missingMessage="身份证不能为空" /></td>
				</tr>
				<tr>
					<td>民族:</td>
					<td><input type="text" id="nation" name="nation"
						class="easyui-validatebox" required="true" /></td>
					<td>政治面貌:</td>
					<td><input type="text" id="political" name="political"
						class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<td>出生年月日:</td>
					<td><input type="text" id="birthv" name="birthv"
						class="easyui-datebox" required="true" /></td>
					<td>毕业高中:</td>
					<td><input type="text" id="highsc" name="highsc"
						class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<td>准考证号:</td>
					<td><input type="text" id="ticket" name="ticket"
						class="easyui-validatebox" required="true" editable="false" /></td>
					<td>高考成绩:</td>
					<td><input type="text" id="score" name="score"
						class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<td>录取专业:</td>
					<td><input type="text" id="majorName" name="majorName"
						class="easyui-validatebox" required="true" editable="false" /></td>
					<td>电话号码:</td>
					<td><input type="text" id="phone" name="phone"
						class="easyui-validatebox" required="true" missingMessage="电话不能空"
						validType='phoneNum' /></td>
				</tr>
				<tr>
					<td>家庭住址:</td>
					<td colspan="3" id="setAddr">
						<div id="city_4"></div>
					</td>
				</tr>
				<tr>
					<td>通知书编号:</td>
					<td><input type="text" id="noticeNO" name="noticeNO"
						class="easyui-validatebox" required="true" editable="false" /></td>
					<td>是否交了档案:</td>
					<td><select class="easyui-combobox" style="width: 154px"
						id="archives" name="archives" editable="false" panelHeight="auto">
							<option value="1">是</option>
							<option value="0">否</option>
					</select></td>
					<!-- <td>已交学费:</td>
					<td><input type="text" id="paiedTuition" name="paiedTuition"
						class="easyui-numberbox"
						data-options="min:0,precision:2,suffix:' 元'" required="true" /></td> -->
				</tr> 
				<tr>
					<td>是否报到:</td>
					<td><select class="easyui-combobox" style="width: 154px"
						id="register" name="register" editable="false" panelHeight="auto">
							<option value="1">是</option>
							<option value="0">否</option>
					</select></td>
					<td>办理绿色通道:</td>
					<td><select class="easyui-combobox" style="width: 154px"
						id="green_channel" name="green_channel" editable="false" panelHeight="auto">
							<option value="1">是</option>
							<option value="0">否</option>
					</select></td>
				</tr>
			</table>
			<input type="hidden" name="id" id="id" />
			<input type="hidden" id="addr" name="addr" />
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:submitStudent()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:closeDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>