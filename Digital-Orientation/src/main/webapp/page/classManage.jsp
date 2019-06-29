<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script type="text/javascript">
	var ids = [];
	var url;
	function importStu() {
		$("#importStu").upload(
		{
			action : '${pageContext.request.contextPath }/student/importStudent.html',/* 提交地址 */
			name : 'studentFile', /* 文件名称 */
			onComplete : function() { /*上传成功后的回调方法 */
				$.messager.alert("系统提示！", "数据导入成功！",
						"info", function() {
							$("#dg").datagrid("reload");
						});
			}
		});
	}
	function separateStu() {
		var selectedRows = $("#dg").datagrid("getSelections");
		if (selectedRows.length < 1) {
			$.messager.alert("系统提示", "请选择要编辑的数据！");
			return;
		}
		for (var i = 0; i < selectedRows.length; i++) {
			var row = selectedRows[i];
			if ((row.studentId != null) && (row.studentId != "")) {
				$.messager.alert("系统提示", "请选择未编辑的数据！");
				return;
			}
		}
		var stuIds = [];
		for (var i = 0; i < selectedRows.length; i++) {
			var row = selectedRows[i];
			stuIds.push(row.id)
		}
		ids = stuIds.join(",");
		$("#dlg").dialog("open").dialog("setTitle", "分配班级");
	}
	function closeDialog() {
		$("#dlg").dialog("close");
	}
	function closeDialog1() {
		$("#dlg1").dialog("close");
	}
	function submitSeparate() {
		url = "${pageContext.request.contextPath }/student/separateStu.html";
		$("#ids").val(ids);
		$("#fm").form("submit", {
			url : url,
			success : function(result) {
				result = eval("(" + result + ")");
				if (result.success) {
					$.messager.alert("系统提示", "分配班级成功", "info", function() {
						$("#dlg").dialog("close");
						$('#dg').datagrid('reload');
					});
				}
			}
		});
	}
	jQuery(document).ready(function() {
		$("#dlg").dialog({
			onClose : function() {
				$("#classNo").val("");
			}
		});
	});
	function preUpdateStuId() {
		$("#addr").val("");
		var selectedRows = $("#dg").datagrid("getSelections");
		if (selectedRows.length != 1) {
			$.messager.alert("系统提示", "请选择一条要编辑的数据！");
			return;
		}
		var row = selectedRows[0];
		$("#dlg1").dialog("open").dialog("setTitle", "修改学号");
		$("#fm1").form("load", row);
	}
	function updateStuId() {
		$("#fm1")
				.form(
						"submit",
						{
							url : "${pageContext.request.contextPath }/student/updateStuId.html",
							success : function(result) {
								result = eval("(" + result + ")");
								if (result.success) {
									$.messager.alert("系统提示", "修改学号成功", "info",
											function() {
												$("#dlg1").dialog("close");
												$('#dg').datagrid('reload');
											});
								} else {
									$.messager.alert("系统提示", "修改学号失败,学号已近存在",
											"error", function() {
											});
								}
							}
						});
	}
</script>
</head>
<body>
	<table id="dg" title="学生信息管理" class="easyui-datagrid" pagination="true"
		rownumbers="true" fit="true"
		url="${pageContext.request.contextPath}/student/list.html?majorId=1"
		toolbar="#tb">
		<thead data-options="frozen:true">
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
				<th field="id" width="50" align="center" hidden="true">编号</th>
				<th field="studentId" width="100" align="center">学号</th>
				<th field="studentName" width="100" align="center">学生姓名</th>
				<th field="genderv" width="50" align="center">性别</th>
				<th field="IDCard" width="200" align="center">身份证号</th>
				<th field="ticket" width="200" align="center">准考证号</th>
				<th field="formatBirth" width="100" align="center">出生年月日</th>
				<th field="highsc" width="80" align="center">毕业高中</th>
				<th field="score" width="50" align="center">高考成绩</th>
				<th field="majorName" width="100" align="center">录取专业</th>
			</tr>
		</thead>
	</table>
	<div id="tb" style="padding-top: 15px; padding-bottom: 15px;">
		专业: <input class="easyui-combobox" style="width: 220px; height: 25px"
			id="major" name="major"
			data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'majorName',
		url:'${pageContext.request.contextPath}/major/list.html'" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<table style="float: right;">
			<tr>
				<td><a href="javascript:importStu()" id="importStu"
					class="easyui-linkbutton" iconCls="icon-upload" plain="true">导入学生</a></td>
				<td><a href="javascript:separateStu()" id="separate"
					class="easyui-linkbutton" iconCls="icon-separator" plain="true">分班</a></td>
				<td><a href="javascript:preUpdateStuId()" id="updateStuId"
					class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改学号</a></td>
			</tr>
		</table>
		<script type="text/javascript">
			$("#major")
					.combobox(
							{
								onSelect : function(major) {
									var url = "${pageContext.request.contextPath}/student/list.html?majorId="
											+ major.id;
									$("#dg").datagrid({
										url : url
									});
									$("#dg").datagrid("reload");
								}
							});
		</script>
	</div>
	<div id="dlg" class="easyui-dialog"
		style="width: 350px; height: 150px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form method="post" id="fm">
			<table cellpadding="15px">
				<tr>
					<td>班级编号:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"
						id="classNo" name="classNo" class="easyui-validatebox"
						required="true" style="height: 20px" /></td>
				</tr>
				<tr>
					<td><input type="hidden" id="ids" name="ids"></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript: submitSeparate()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:closeDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div id="dlg1" class="easyui-dialog"
		style="width: 350px; height: 400px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons1">
		<form method="post" id="fm1">
			<table cellpadding="15px">
				<tr>
					<td>学号:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"
						id="studentId" name="studentId" class="easyui-validatebox"
						required="true" style="height: 20px" /></td>
				</tr>
				<tr>
					<td>姓名:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"
						id="studentName" name="studentName" class="easyui-validatebox"
						editable="false" required="true" style="height: 20px" /></td>
				</tr>
				<tr>
					<td><input type="hidden" id="id" name="id"></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons1">
		<a href="javascript:updateStuId()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:closeDialog1()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>