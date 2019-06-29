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
	href="${pageContext.request.contextPath }/css/default.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/usericons/myicon.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath }/js/jquery.ocupload-1.1.2.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function searchStu() {
		var studentId = $("#stuId").val();
		var majorId = $("#major").val();
		var stuName = $("#stuName").val();
		var url = "${pageContext.request.contextPath}/student/list.html?studentId="
				+ studentId + "&&majorId=" + majorId + "&&stuName=" + stuName;
		;
		$("#dg").datagrid({
			url : url
		});
		$("#dg").datagrid("reload");
	}
	function prePayTuition() {
		var selectedRows = $("#dg").datagrid("getSelections");
		if (selectedRows.length != 1) {
			$.messager.alert("系统提示", "请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle", "编辑缴费信息");
		$("#fm").form("load", row);
	}
	function payTuition() {
		var way=$("#way").val();
		var amount=$("#amount").val();
		var voucher=$("#voucher").val();
		var selectedRows = $("#dg").datagrid("getSelections");
		var stuId=selectedRows[0].id;
		if(way=="0"){
			$.messager.alert("系统提示", "请选择缴费方式！");
			return;
		}
		var v=$("#fm").form('validate');
		if(v){
			$.messager.alert("确认信息", selectedRows[0].studentName+"  缴费"+amount+"元！"+"   是否确认", "info", function() {
				$.post("${pageContext.request.contextPath}/pay/payTuition.html",{
					"way":way,
					"amount":amount,
					"voucher":voucher,
					"stuId":stuId
				},function(result){
					if(result.success){
						$.messager.alert("系统提示","缴费成功","info",function(){
							$("#dlg").dialog("close");
						   $('#dg').datagrid('reload');
						});
					}else{
						$.messager.alert("系统提示","缴费失败！缴费金额过大","info",function(){
						});
					}
				},"json");
			});
		}else{
			$.messager.alert("系统提示", "请正确填写信息！");
			return;
		}
	}
	function closeDialog() {
		$("#dlg").dialog("close");
	}
	jQuery(document).ready(function(){
		$('#dlg').dialog({
		    onClose:function(){
		    	$("#way").combobox('select', '0');;
		    	$("#amount").numberbox('setValue','');
		    	$("#voucher").val("");
		  	}
		});
	});
</script>
</head>
<body>
	<table id="dg" title="学生信息管理" class="easyui-datagrid" pagination="true"
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
				<th field="majorName" width="100" align="center">录取专业</th>
				<th field="phone" width="100" align="center">电话号码</th>
				<th field="isRegister" width="70" align="center">是否报到</th>
				<th field="isGreen_channel" width="70" align="center">绿色通道</th>
				<th field="tuition" width="80" align="center">学费</th>
				<th field="paiedTuition" width="80" align="center">已交学费</th>
				<th field="unpaidTuition" width="80" align="center">未交学费</th>
			</tr>
		</thead>
	</table>
	<div id="tb" style="padding: 15px;">
		专业: <input class="easyui-combobox" style="width: 220px; height: 25px"
			id="major" name="major"
			data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'majorName',
		url:'${pageContext.request.contextPath}/major/list.html'" />
		<script type="text/javascript">
			var majorName = $("#existMajorName").val();
			if (majorName != null) {
				$("#major").combobox('select', majorName);
			}
		</script>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 学号: <input type="text"
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
		</script>

		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:searchStu()"
			id="searchStu" class="easyui-linkbutton" iconCls="icon-search"
			plain="true">搜索</a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:prePayTuition()"
			id="payTuition" class="easyui-linkbutton" iconCls="icon-add-pay"
			plain="true">缴费</a> <br />
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
					<td>缴费方式:&nbsp;&nbsp;&nbsp;&nbsp;<select class="easyui-combobox" style="width: 154px"
						id="way" name="way" editable="false" panelHeight="auto" required="true" >
							<option value="0">--请选择--</option>
							<option value="1">现金缴费</option>
							<option value="2">刷卡缴费</option>
							<option value="3">支付宝缴费</option>
							<option value="3">微信支付</option>
					</select></td>
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
		<a href="javascript:payTuition()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> 
		<a href="javascript:closeDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>