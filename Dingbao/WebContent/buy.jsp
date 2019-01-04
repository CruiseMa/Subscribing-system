<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
request.setCharacterEncoding("utf-8");
String username = (String)session.getAttribute("username");
String connectString = "jdbc:mysql://localhost:3306/dingbao_pro"
	+ "?autoReconnect=true&useUnicode =true&characterEncoding=UTF-8&&useSSL=false";
String submit = request.getParameter("submit");
String method = request.getMethod();
boolean post = method.equalsIgnoreCase("post");
String[] pname=new String[100];
int mgmo=0;
int price=0;
int pno=0;
int paper_size=0;
//动态加载报纸选择栏	
 int count = 0;
		 try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(connectString, "root", "nowdirk,14");
			Statement stat=con.createStatement();
			ResultSet rs_paper= stat.executeQuery("select pna from paper ;");
			rs_paper.last();
			 paper_size = rs_paper.getRow()+1;		 
			rs_paper.first();
			do{
				pname[count]= rs_paper.getString("pna");
				count++;
		   }while(rs_paper.next());
			
			//得到用户当前余额
			String my_money = "select gmo from customer where gno='"+username+"'";
			ResultSet rs_gmo= stat.executeQuery(my_money);
			if(rs_gmo.next()){
				 mgmo=rs_gmo.getInt("gmo");}
	} catch (Exception e) {
			System.out.println(e.getMessage());
}
%>
<html  lang="zh-cn">
<head>
<meta charset="utf-8">
<title>订阅</title>
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
	<form action="http://localhost:8080/Dingbao/buy.jsp" method="post" > 
	<div id="l3">列表：
	<select  name="paper">
		<%for(int i=0;i<paper_size-1;i++){
    %><option value="<%=pname[i]%>"><%=pname[i]%></option><%

	}%>
	</select>
	</div><br><br><br><br><br>
	<div id="l2">订购份数： <input name="num" type="text"> </div>
	<input id="bt2" class="bt" name="submit" type="submit" value="购买"></input>
	<%

	if(submit!=null){
	String paper = request.getParameter("paper");//所选报纸paper
	String str = request.getParameter("num");
	 int num = Integer.parseInt(str);//购买数量num
	try {
		Class.forName("com.mysql.jdbc.Driver");	
		Connection con = DriverManager.getConnection(connectString, "root", "nowdirk,14");
		Statement stat=con.createStatement();
		ResultSet rs= stat.executeQuery("select ppr from paper where pna='"+paper+"';");
		if(rs.next())  price = rs.getInt("ppr");  //报纸单价price
           ResultSet rs1= stat.executeQuery("select pno from paper where pna='"+paper+"';");
          if(rs1.next())  pno = rs1.getInt("pno");
		if((price*num)<=mgmo){//如果单价*数量>余额，则无法购买
			int iii = mgmo-(price*num);
			int i = stat.executeUpdate("insert into buy(gno,pno,num)values('"+username+"','"+pno+"','"+num+"');");//购买成功，加入购买记录表
			int ii = stat.executeUpdate("update customer set gmo = '"+iii+"' where gno = '"+username+"';");//及时更新余额
			%><p><a href=http://localhost:8080/Dingbao/main.jsp?username=<%=username%>>购买成功，点击进入个人主页</a></p><%
		}else{
			%><p style="color:red;"><%="余额不足！"%><p><%
		}
	  	rs.close();
	  	rs1.close();
	    stat.close();
	    con.close();
	} catch (Exception e) {
		System.out.println(e.getMessage());
	}
}%>
	</form>
</div> 
</div>

</body>
</html>
