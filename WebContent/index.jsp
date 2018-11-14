<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page errorPage="/studentEdit.jsp?id=0&currentPage=1"%>
    <%@ page import ="DTO.*,DAO.*,java.util.*" %>
<%@taglib tagdir="/WEB-INF/tags" prefix="my" %>
<!DOCTYPE html>

<html>
<%
String search="";
search=(request.getParameter("search")==null?search:request.getParameter("search"));

request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

int currentPage=(request.getParameter("page")==null?1:Integer.parseInt(request.getParameter("page")));

int pageSize=15;
//int recordCount=StudentDAO.CountResult(search,pageSize);



%>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
      body { font-family: 굴림체; }
      
      thead th { background-color: #eee; }
      
      table.table { width: 700px; }
      tr:hover td { background-color: #ffe; cursor: pointer; }
  </style>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
<form method="get" >
	<label>이름:</label>
	<input type="text" name="search" placeholder="검색조건" />
	<button type="submit" >조회 </button>
</form>

<my:List search="<%=search %>" currentPage="<%=currentPage%>" pageSize="<%=pageSize %>"/>
<my:PageNation search="<%=search %>" currentPage="<%=currentPage%>" pageSize="<%=pageSize %>" />
</div>
<script>
$("[data-url]").click(function(){
	var url = $(this).attr("data-url");
	location.href=url;
	
})
</script>
</body>
</html>