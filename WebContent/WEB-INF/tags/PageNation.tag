<%@ tag  pageEncoding="UTF-8"%>
<%@ tag import ="DTO.*,DAO.*,java.util.*" %>
<%@attribute name="search" type="java.lang.String" required="true" %> 
<%@attribute name="currentPage" type="java.lang.Integer" required="true" %>
<%@attribute name="pageSize" type="java.lang.Integer" required="true" %>





<%
String search=(String)jspContext.getAttribute("search"); 
int currentPage=(int)jspContext.getAttribute("currentPage");
int pageSize=(int)jspContext.getAttribute("pageSize");

int totalPage=StudentDAO.CountResult(search, pageSize);
String url;
%>
<nav>
  <ul class="pagination">
    <%
		for(int i=0;i<totalPage;i++){	
			
		 url="?search="+search+"&page="+Integer.toString(i+1) ; 
		 if(i+1==currentPage){
		 %>
		 <li ><a href=<%=url %> ><%=(i+1) %></a></li><%
		continue; } %>
    <li><a href=<%=url %> ><%=(i+1) %></a></li>
   <%} %>
  </ul>
</nav>