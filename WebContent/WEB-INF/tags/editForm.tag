<%@ tag description="editForm" pageEncoding="UTF-8"%>
<%@ tag import ="DTO.*,DAO.*,java.util.*" %>
<%@attribute name="id" type="java.lang.Integer" required="true"%>
<%@attribute name="currentPage" type="java.lang.Integer" required="true"%>

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

int currentPage=(Integer)jspContext.getAttribute("currentPage");


int id = (Integer)jspContext.getAttribute("id");
Student student =StudentDAO.findOne(id);

List<Department> list =  DepartmentDAO.findAll();

//      수정하려고 접 속시 






String message =null;
String selected1=" ";
String selected2=" ";

//    수정 저장 요청시 
if(request.getMethod().equals("POST")){

String studentNumber=request.getParameter("studentNumber");
String studentName=request.getParameter("studentName");
String s1=request.getParameter("departmentId");

int departmentId=Integer.parseInt(s1);

String s2 =request.getParameter("grade");
int grade = Integer.parseInt(s2);

if(studentNumber==null||studentNumber.length()==0){
	message="학번을 입력해주세요 !";}
else if(studentName==null||studentName.length()==0){
	message="이름을 입력해주세요 !";}
else if(departmentId==0){
	message="학과를 선택해주세요 !";}
else if(grade==0){
	message="학년을 선택해주세요  !";}


if(message==null){
	Student new_student = new Student();
	new_student.setId(id);
	new_student.setStudentName(studentName);
	new_student.setStudentNumber(studentNumber);
	new_student.setDepartmentId(departmentId);
	new_student.setGrade(grade);
	if(StudentDAO.editOne(new_student)!=0){
	response.sendRedirect("index.jsp");}
	
}
else{
%>
<script>
alert('<%=message%>');
</script>
<%
}}
%>

<form method="post">
<div class="form-group">
	<label>학번:</label><input type="text" name="studentNumber" value="<%=student.getStudentNumber() %>" />
	<label>이름:</label><input type="text" name="studentName" value="<%=student.getStudentName() %>" />
	<label>학과:</label>
				<select name="departmentId" >
		      <% for (Department d : DepartmentDAO.findAll()) { 
		    	  
		    	selected1=(student.getDepartmentId()==d.getId())?"selected":" ";
          	  %>
          <option value="<%= d.getId() %>"<%=selected1%>>
            <%= d.getDepartmentName() %></option>
            
        <% } %>

				</select>
	<label>학년:</label>
	<select name=grade><%
for(int i=1; i<=4; i++){
 selected2 = student.getGrade()==i?"selected":" ";  %>

	<option value="<%=i %>" <%=selected2%>><%=i %></option><%} %>
</select>
	<button type="submit" >수정</button>
	<a href="delete.jsp?id=<%=id %>&currentPage=<%=currentPage %>" onclick="return confirm('삭제를 진행하시겠습니까?'')">삭제</a>
	</div>
</form> 