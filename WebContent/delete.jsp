<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="DAO.* , DTO.* , java.util.List "%>
 <%@page   errorPage="/index.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<% 
int id=Integer.parseInt(request.getParameter("id"));
int currentPage=Integer.parseInt(request.getParameter("currentPage"));
StudentDAO.delete(id);

%>


</body>
</html>