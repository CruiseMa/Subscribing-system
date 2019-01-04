<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
request.setCharacterEncoding("utf-8");
String username = (String)session.getAttribute("username");
String myname = "无";
String[] pno = new String[100];
String[] pna = new String[100];
int[] ppr = new int[100];
String[] pdw = new String[100];
int mgmo=0;
int paper_size=0;
String connectString = "jdbc:mysql://localhost:3306/dingbao_pro"
		+ "?autoReconnect=true&useUnicode =true&characterEncoding=UTF-8&&useSSL=false";
int index_ddl =0;
try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(connectString, "root", "nowdirk,14");
	Statement stat=con.createStatement();
	//得到用户当前余额 mgmo
	String my_money = "select gmo from customer where gno='"+username+"'";
	ResultSet rs_gmo= stat.executeQuery(my_money);
	if(rs_gmo.next()){
	 mgmo=rs_gmo.getInt("gmo");}
	//得到用户名myname
	String my_name = "select gna from customer where gno='"+username+"'";
	ResultSet rs_gna= stat.executeQuery(my_name);
	if(rs_gna.next()){
	 myname=rs_gna.getString("gna");}
	//得到用户购买的报纸
	ResultSet rs_paper= stat.executeQuery("select pno from buy where gno='"+username+"';");
	rs_paper.last();
	 paper_size = rs_paper.getRow()+1;
	 System.out.println("paper_size");
	String[] pname = new String[paper_size];
	rs_paper.first();
	do{
	     pname[index_ddl]= rs_paper.getString("pno");
	     index_ddl++;
	}while(rs_paper.next()) ;
	
	String select_cinf = "select * from paper where pno='"+pname[0]+"'";
	for(int j=1;j<index_ddl;j++)
	{
		select_cinf = select_cinf+" or pno='"+pname[j]+"'";
	}
	
	ResultSet rs_cinf= stat.executeQuery(select_cinf);
	rs_cinf.last();
	int cinf_dex=0; 
	rs_cinf.first();
	do{
	    	pno[cinf_dex]=rs_cinf.getString("pno");
			pna[cinf_dex]=rs_cinf.getString("pna");
	    	ppr[cinf_dex]=rs_cinf.getInt("ppr");
	    	pdw[cinf_dex]=rs_cinf.getString("pdw");
	    	cinf_dex++;
	}while(rs_cinf.next());
	rs_cinf.close();							
	rs_paper.close();
	rs_gmo.close();
	stat.close();
	con.close();
	} catch (Exception e) {
		System.out.println(e.getMessage());
	}
%>
<html  lang="zh-cn">
<head>
<meta charset="utf-8">
<title>个人主页</title>
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
	<div>
		<i id="icon"class="fa fa-user fa-lg"></i>
		<p>用户名：<%=myname%></p>
		<p>我的余额：<%=mgmo%></p>
	</div>
	<div><table class="paper_information" cellspacing="0">		
			<%
				for(int index_cinf=0;index_cinf<paper_size-1;index_cinf++){		
						%>							
						<tr>
						<td>报纸名称：<%=pna[index_cinf]%></td>
						</tr>
						<tr>
						<td>报纸单价：<%=ppr[index_cinf]%></td>
						</tr>	
						<tr>
						<td >出版单位：<%=pdw[index_cinf]%></td>
						</tr>	<%						
				}
			%>
			</table></div>
	
	<p><a href=http://localhost:8080/Dingbao/buy.jsp?username=<%=username%>>订阅新报纸</a></p>
</div> 
</div>
</body>

</html>
