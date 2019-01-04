<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html  lang="zh-cn">
<head>
<meta charset="utf-8">
<title>注册</title>
<link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
<style>
	#main{background-image:url(images/d.jpg);
		width:1300px;
		height:650px;
		margin:0 auto;
		position:relative;}
	#input1{border:1px solid rgb(0,64,128);
		border-left:none;
		box-shadow:1px 2px 4px #808080;
		margin:5px;
		width:200px;
		border-radius: 5px;
		background:linear-gradient(to right,rgba(0,64,128,0.3),rgba(255,255,255,0.6));
		padding:4px;
		color:black;}
	#container{
		padding:50px;
		text-align:center;
		width:340px;
		height:400px;
		border-radius: 5px;
		background:rgba(255,255,255,0.6);
		position:absolute;
		left:440px;
		top:120px;}
	#icon1,#icon2{color:rgb(0,64,128);margin:10px 0;}
	#icon3{color:red;}
	#bt,#bt2{width:50px;
		margin: 5px;
		background:rgba(0,64,128,0.8);
		border-radius: 5px;
		padding:5px 10px;
		color:white;}
	#bt:active,#bt:hover,#bt2:active,#bt2:hover{
		color:rgba(0,64,128,0.8);
		background:white;
	}
</style>
</head>
<body>
<div id="main">
<div id="container">
<form action="http://localhost:8080/Dingbao/register.jsp" method="post" > 
	<div>
		用户编号<i id="icon1"class="fa fa-user fa-lg"></i>
		<input id="input1" name="gno" type="text" placeholder="用户编号">
	</div>
	<div>
		用户姓名<i id="icon2" class="fa fa-key fa-lg"></i>
		<input id="input1" name="gna" type="text" placeholder="姓名">
	</div>
	<div>
		充值金额<i id="icon3" class="fa fa-key fa-lg"></i>
		<input id="input1" name="mon" type="text" placeholder="充值金额">
	</div>
	<div>	
		电话<input id="input1" name="tel" type="text" placeholder="电话">
	</div>
	<div>		
		地址<input id="input1" name="add" type="text" placeholder="地址">
	</div>
	<div>		
		邮编<input id="input1" name="gpo" type="text" placeholder="邮编">
	</div>
	
	<input id="bt" name="submit" type="submit" value="注册"></input>
	<input id="bt2" name="back" type="button" value="返回"></input> 
	<%
	request.setCharacterEncoding("utf-8");
	String submit = request.getParameter("submit");
	String method = request.getMethod();
	boolean post = method.equalsIgnoreCase("post");	
	
	if(submit!=null){
	String gno = request.getParameter("gno");//用户编号
	String gna = request.getParameter("gna");//姓名
	String mon = request.getParameter("mon");//充值金额
	String tel = request.getParameter("tel");//电话
	String add = request.getParameter("add");//地址
	String gpo = request.getParameter("gpo");//邮编
	
	if(gno!=""&&gna!=""&&mon!=""){//判断用户是否填写了编号，用户名，充值金额
	String connectString = "jdbc:mysql://localhost:3306/dingbao_pro"
	+ "?autoReconnect=true&useUnicode =true&characterEncoding=UTF-8&&useSSL=false";
	try {
		Class.forName("com.mysql.jdbc.Driver");//连接数据库
		Connection con = DriverManager.getConnection(connectString, "root", "nowdirk,14");
		Statement stat=con.createStatement();
		int rs = stat.executeUpdate("insert into customer(gno,gna,gte,gad,gpo,gmo)values('"+gno+"','"+gna+"','"+tel+"','"+add+"','"+gpo+"','"+mon+"');");
		%><p><%="注册成功，请返回主界面登录"%><p><%
	    stat.close();
	    con.close();
	} catch (Exception e) {
		%><p><%="注册失败：用户编号冲突"%><p><%
		System.out.println(e.getMessage());
	}
	}
	else{
		%><p><%="注册失败：请检查是否输入充值金额,用户名"%><p><%
	}
}
%>
</form>
 
<script type="text/javascript">
	var bt2=document.getElementById("bt2");
	var f2=function(){
		alert("点击确定返回主界面");
		window.location.href="http://localhost:8080/Dingbao/index.jsp";
	};
	bt2.onclick= f2;
</script>

</div> 
</div>
</body>
</html>