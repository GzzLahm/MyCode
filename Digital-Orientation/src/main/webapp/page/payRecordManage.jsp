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
	function searchRecord() {
		var studentId = $("#stuId").val();
		var majorId = $("#major").val();
		var stuName = $("#stuName").val();
		var url = "${pageContext.request.contextPath}/pay/list.html?studentId="
				+ studentId + "&&majorId=" + majorId + "&&stuName=" + stuName;
		;
		$("#dg").datagrid({
			url : url
		});
		$("#dg").datagrid("reload");
	}
	function deleteRecord() {
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			 return;
		}
		var row=selectedRows[0];
		$.messager.alert("系统提示","确定删除这条缴费记录吗？","warning",function(){
			$.post("${pageContext.request.contextPath}/pay/deleteRecord.html",{"id":row.id},function(result){
				if(result.success){
					$.messager.alert("系统提示","删除缴费记录成功","info",function(){
						 $('#dg').datagrid('reload');
					});
				}
			},"json");
		});
	}
	function preEditRecord() {
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			 return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑缴费记录");
		$("#fm").form("load",row);
	}
	function editRecord() {
		var selectedRows=$("#dg").datagrid("getSelections");
		var amount=$("#amount").val();
		var voucher=$("#voucher").val();
		var id=selectedRows[0].id;
		$.messager.alert("系统提示","确定修改这条缴费记录吗？","warning",function(){
			$.post("${pageContext.request.contextPath}/pay/editRecord.html",{
				"id":id,
				"amount":amount,
				"voucher":voucher
			},function(result){
				if(result.success){
					if(result.success){
						$.messager.alert("系统提示","缴费记录修改成功","info",function(){
							$("#dlg").dialog("close"); 
							$('#dg').datagrid('reload');
						});
					}
				}
			},"json");
		});
	}
	function closeDialog() {
		$("#dlg").dialog("close");
	}
</script>
</head>
<body>
	<table id="dg" title="缴费记录信息管理" class="easyui-datagrid" pagination="true"
		rownumbers="true" 
		url="${pageContext.request.contextPath}/pay/list.html" fit="true"
		toolbar="#tb">
		<thead data-options="frozen:true">
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
				<th field="id" width="50" align="center" hidden="true">编号</th>
				<th field="userName" width="60" align="center">操作员</th>
				<th field="studentId" width="100" align="center">学号</th>
				<th field="studentName" width="100" align="center">学生姓名</th>
				<th field="majorName" width="100" align="center">专业</th>
				<th field="amount" width="100" align="center">缴费金额</th>
				<th field="payTime" width="200" align="center">缴费时间</th>
				<th field="wayDetail" width="130" align="center">支付方式</th>
				<th field="voucher" width="200" align="center">支付凭证</th>
			</tr>
		</thead>
	</table>
	<div id="tb" style="padding-top: 15px;">
		专业: <input class="easyui-combobox" style="width: 220px; height: 25px"
			id="major" name="major"
			data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'majorName',
		url:'${pageContext.request.contextPath}/major/list.html'" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 学号: <input type="text"
			style="height: 23px; width: 184px;" class="easyui-validatebox"
			id="stuId" name="stuId"
			onkeydown="if(event.keyCode==13) return searchRecord()" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 姓名: <input type="text"
			style="height: 23px; width: 184px;" class="easyui-validatebox"
			id="stuName" name="stuName"
			onkeydown="if(event.keyCode==13) return searchRecord()" />
			
		<script type="text/javascript">
			$("#major")
					.combobox(
					{
						onSelect : function(major) {
							var studentId = $("#stuId").val();
							var stuName = $("#stuName").val();
							var url = "${pageContext.request.contextPath}/pay/list.html?studentId="
									+ studentId
									+ "&&majorId="
									+ major.id + "&&stuName=" + stuName;
							$("#dg").datagrid({
								url : url
							});
							$("#dg").datagrid("reload");
						}
					});
		</script>

		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:searchRecord()"
			id="searchRecord" class="easyui-linkbutton" iconCls="icon-search"
			plain="true">搜索</a> <br />
		<a href="javascript:preEditRecord()"
			id="editRecord" class="easyui-linkbutton" iconCls="icon-edit"
			plain="true">编辑</a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:deleteRecord()"
			id="deleteRecord" class="easyui-linkbutton" iconCls="icon-remove"
			plain="true">删除</a>
	</div>
	<div id="dlg" class="easyui-dialog"
		style="width: 400px; height: 400px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form method="post" id="fm">
			<table cellpadding="15px">
				<tr>
					<td>学&nbsp;&nbsp;号&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="studentId" name="studentId"
						class="easyui-validatebox" required="true" style="height: 20px"/></td>
				</tr>
				<tr>
					<td>姓&nbsp;&nbsp;名&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="studentName" name="studentName"
						class="easyui-validatebox" editable="false" required="true" style="height: 20px"/></td>
				</tr>
				<tr>
					<td>缴费方式:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="wayDetail" name="wayDetail"
						class="easyui-validatebox" editable="false" style="height: 20px"/></td>
				</tr>
				<tr>
					<td>缴费金额:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="amount" name="amount"
						class="easyui-numberbox"
						data-options="min:0,precision:2,suffix:' 元'" required="true" /></td>
				</tr>
				<tr>
					<td>支付单号:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="voucher" name="voucher"
						class="easyui-validatebox" style="height: 20px"/></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:editRecord()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> 
		<a href="javascript:closeDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>