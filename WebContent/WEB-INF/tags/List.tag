<%@ tag description="pagination" pageEncoding="UTF-8"%>

<%@ tag import ="DTO.*,DAO.*,java.util.*" %>
<%@ attribute name="search" type="java.lang.String" required="true" %> 
<%@ attribute name="currentPage" type="java.lang.Integer" required="true" %>
<%@ attribute name="pageSize" type="java.lang.Integer" required="true" %>
<%
	String search=(String)jspContext.getAttribute("search");
	int currentPage=(Integer)jspContext.getAttribute("currentPage");
	int pageSize=(Integer)jspContext.getAttribute("pageSize");
	List<Student> list = StudentDAO.findByName(search,currentPage,pageSize);


%>
<table class="table table-bordered table-condensed">
	<thead>
		<tr>
			<th>ID</th>
			<th>학번</th>
			<th>이름</th>
			<th>학과</th>
			<th>학년</th>
		</tr>
	</thead>
	<tbody>
	<%for (Student student : list ){ %>
		<tr data-url="studentEdit.jsp?id=<%=student.getId() %>&currentPage=<%=currentPage %>">
			<td><%=student.getId() %></td>
			<td><%=student.getStudentNumber() %></td>
			<td><%=student.getStudentName() %></td>
			<td><%=student.getDepartmentName() %></td>
			<td><%=student.getGrade() %></td>
		</tr>
		<%
		}
	%>
	</tbody>
</table>