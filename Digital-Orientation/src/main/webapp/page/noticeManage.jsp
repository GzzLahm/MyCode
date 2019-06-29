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
	var majorId;
	function closeDialog() {
		$("#dlg").dialog("close");
	}
	function preSetNoticeNo() {
		majorId=$("#major").val();
		if((majorId==null)||(majorId=="")){
			$.messager.alert("系统提示", "请先选择专业", "warning", function() {
			});
			return;
		}
		$("#dlg").dialog("open").dialog("setTitle","编辑通知书编号");
	}
	function setNoticeNo() {
		var noticeNO=$("#noticeNo").val();
		if((noticeNO!=null)&&(noticeNO!="")&&(noticeNO.trim().length != 0)){
			$.ajax({
				type : "POST",
				url : "${pageContext.request.contextPath}/student/setNoticeNo.html",
				data : {
					"majorId" : majorId,
					"noticeNO" : noticeNO
				},
				dataType : "json",
				success : function(result) {
					if(result.success){
						$.messager.alert("系统提示", "设置通知书编号成功", "info", function() {
							$("#dlg").dialog("close");
							$('#dg').datagrid('reload');
						});
					}else{
						$.messager.alert("系统提示", "通知书编号已经存在，请重新填写", "warning", function() {
						});
					}
				}
			});
		}else{
			$.messager.alert("系统提示", "请填写内容", "warning", function() {
			});
		}
	}
	function exportData() {
		majorId=$("#major").val();
		if((majorId==null)||(majorId=="")){
			$.messager.alert("系统提示", "请先选择专业", "warning", function() {
			});
			return false;
		}
		window.location.href="${pageContext.request.contextPath}/student/exportData.html?majorId="+majorId;
	}
</script>
</head>
<body>
	<table id="dg" title="学生信息" class="easyui-datagrid" pagination="true"
		rownumbers="true" 
		url="${pageContext.request.contextPath}/student/list.html" fit="true"
		toolbar="#tb">
		<thead data-options="frozen:true">
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
				<th field="id" width="50" align="center" hidden="true">编号</th>
				<th field="studentId" width="100" align="center">学号</th>
				<th field="studentName" width="100" align="center">学生姓名</th>
				<th field="genderv" width="50" align="center">性别</th>
				<th field="IDCard" width="100" align="center">身份证号</th>
				<th field="formatBirth" width="100" align="center">出生年月日</th>
				<th field="highsc" width="80" align="center">毕业高中</th>
				<th field="ticket" width="100" align="center">准考证号</th>
				<th field="score" width="50" align="center">高考成绩</th>
				<th field="majorName" width="100" align="center">录取专业</th>
				<th field="noticeNO" width="100" align="center">通知书编号</th>
			</tr>
		</thead>
	</table>
	<div id="tb" style="padding-top: 15px;padding-bottom: 15px;">
		专业: <input class="easyui-combobox" style="width: 220px; height: 25px"
			id="major" name="major"
			data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'majorName',
		url:'${pageContext.request.contextPath}/major/list.html'" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<a href="javascript:preSetNoticeNo()" id="separate" class="easyui-linkbutton" iconCls="icon-edit"
			plain="true">设置通知书编号</a>
		<a href="javascript:exportData()" id="updateStuId" class="easyui-linkbutton" iconCls="icon-undo"
			plain="true">导出学生信息</a>
		<script type="text/javascript">
			$("#major").combobox({
				onSelect : function(major){
					var url = "${pageContext.request.contextPath}/student/list.html?majorId="+ major.id;
					$("#dg").datagrid({
						url : url
					});
					$("#dg").datagrid("reload");
				}
			});
		</script>
	</div>
	<div id="dlg" class="easyui-dialog"
		style="width: 400px; height: 150px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form method="post" id="fm">
			<table cellpadding="15px">
				<tr>
					<td>通知书吧编号前缀:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="noticeNo" name="noticeNo"
						class="easyui-validatebox" required="true" style="height: 20px"/></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript: setNoticeNo()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> 
		<a href="javascript:closeDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>