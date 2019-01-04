<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html  lang="zh-cn">
<head>
<meta charset="utf-8">
<title>登录</title>
<link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
<style>
	#main{background-image:url(images/d.jpg);
		width:1300px;
		height:650px;
		margin:0 auto;
		position:relative;}
	input{border:1px solid rgb(0,64,128);
		border-left:none;
		box-shadow:1px 2px 4px #808080;
		margin:10px;
		width:200px;
		border-radius: 5px;
		background:linear-gradient(to right,rgba(0,64,128,0.3),rgba(255,255,255,0.6));
		padding:4px;
		color:black;}
	#container{
		padding:10px;
		text-align:center;
		width:420px;
		height:200px;
		border-radius: 5px;
		background:rgba(255,255,255,0.6);
		position:absolute;
		left:440px;
		top:215px;}
	#icon{color:rgb(0,64,128);margin-top:30px;}
	.bt{width:50px;
		
		margin: 10px;
		background:rgba(0,64,128,0.8);
		border-radius: 5px;
		padding:5px 10px;
		color:white;}
	.bt:active,.bt:hover {
		color:rgba(0,64,128,0.8);
		background:white;
	}
</style>
</head>
<body>
<div id="main">
<div id="container">
	<form action="http://localhost:8080/Dingbao/index.jsp" method="post" > 
	<div>
		用户编号<i id="icon"class="fa fa-user fa-lg"></i>
		<input type="text" name="user_num" placeholder="用户编号">
	</div>
	<div>
		用户名<i id="icon" class="fa fa-key fa-lg"></i>
		<input type="text" name="user_name" placeholder="用户名">
	</div>
	<input id="bt1" class="bt" name="register" type="button" value="注册"></input>
	<input id="bt2" class="bt" name="log" type="submit" value="登录"></input>
	<%
	
	request.setCharacterEncoding("utf-8");
	String submit = request.getParameter("log");
	String method = request.getMethod();
	boolean post = method.equalsIgnoreCase("post");
	
	if(submit!=null){
	String num = request.getParameter("user_num");//用户编号
	String name = request.getParameter("user_name");//姓名
	if(num!=""&&name!=""){
	String connectString = "jdbc:mysql://localhost:3306/dingbao_pro"
	+ "?autoReconnect=true&useUnicode =true&characterEncoding=UTF-8&&useSSL=false";
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString, "root", "nowdirk,14");
		Statement stat=con.createStatement();
		ResultSet rs= stat.executeQuery("select gna from customer where gno='"+num+"';");
		String true_name = "1";
		if(rs.next()) {
             true_name= rs.getString("gna");
	  }
		if(true_name.equals(name)){
			%><p><a href=http://localhost:8080/Dingbao/main.jsp?username=<%=num%>>验证成功，点击进入个人主页</a></p><%
		}else{
			%><p style="color:red;"><%="用户名错误，请重新登陆"%><p><%
		}
	  	rs.close();
	    stat.close();
	    con.close();
	} catch (Exception e) {
		%><p style="color:red;"><%="用户不存在，请重新登录"%><p><%
		System.out.println(e.getMessage());
	}
	session.setAttribute("username",num); 
	}
}%>
	<script type="text/javascript">
		var bt1=document.getElementById("bt1");
		var f1=  function(){window.location.href="http://localhost:8080/Dingbao/register.jsp";};
		bt1.onclick= f1;
	</script>
	</form>
</div> 
</div>

</body>
</html>
