package DAO;
import java.sql.*;
import java.util.*;
import DTO.*;



public class StudentDAO {

	
	// 커넥션 메소드 
	public static Connection getConnection() throws Exception{
		
		Class.forName("com.mysql.jdbc.Driver");
		String dbUrl="jdbc:mysql://localhost:3306/student1?useTimezone=true&serverTimezone=Asia/Seoul&useSSL=false";
		String userId="user1";
		String userPassword ="test123";
		return DriverManager.getConnection(dbUrl, userId, userPassword);
	}
	
	
	// ResultSet 을 List로 바꿔주는 메서드 
	
	public static List<Student> InvertList(ResultSet rs) throws Exception{
		
		List<Student> list = new ArrayList<Student>();
		while(rs.next()) {
			Student student = new Student();
			student.setId(rs.getInt("id"));
			student.setStudentNumber(rs.getString("StudentNumber"));
			student.setStudentName(rs.getString("name"));
			student.setGrade(rs.getInt("year"));
			student.setDepartmentName(rs.getString("departmentName"));
			list.add(student);
		}
		return list;
		
	}
	
	
	//  전체조회 메소드
	// 페이지에 따른 리스트  반환 
public static List<Student> findAll(int currentPage,int pageSize) throws Exception{
	Connection con = getConnection();
	
	List<Student> list = new ArrayList<Student>();
	
	String sql="SELECT * FROM STUDENT S JOIN DEPARTMENT D ON S.DEPARTMENTID=D.ID ORDER BY S.ID LIMIT ?,?";
	PreparedStatement pstmt=con.prepareStatement(sql);
	int start_ID= (currentPage-1)*pageSize;
	pstmt.setInt(1,start_ID);
	pstmt.setInt(2,pageSize);
	ResultSet rs = pstmt.executeQuery();
	
	list=InvertList(rs);
	
	return list;
} 
//이름으로 조회한 학생의 총 페이지수 반환 
public static int  CountResult(String search,int pageSize) throws Exception{
	Connection con = getConnection();
	
	
	search+="%";
	search="%"+search;
	String sql="SELECT Count(*) FROM STUDENT S JOIN DEPARTMENT D ON S.DEPARTMENTID=D.ID WHERE NAME LIKE ? ";
	PreparedStatement pstmt=con.prepareStatement(sql);
	pstmt.setString(1,search);
	int Rows=0;
	ResultSet rs = pstmt.executeQuery();
	while(rs.next()) {
	Rows= rs.getInt(1);}
	int pageCount=(int) Math.ceil((double)(Rows/pageSize));
	return pageCount;
} 
// 아이디로 스튜던트객체를 찾아내는 메소드
public static Student findOne(int id) throws Exception{
	Connection con = getConnection();
	String sql = "SELECT S.*,D.departmentName FROM STUDENT S JOIN DEPARTMENT D ON S.DEPARTMENTID=D.ID WHERE S.ID=?";
	PreparedStatement pstmt= con.prepareStatement(sql);
	pstmt.setInt(1,id);
	ResultSet rs = pstmt.executeQuery();
	List<Student> list = InvertList(rs);
	return list.get(0);
}

// 이름과 페이지네이션이가능한 조회 메서드 
public static List<Student> findByName(String search,int currentPage,int pageSize) throws Exception{
	Connection con = getConnection();
	List<Student> list = new ArrayList<Student>();
	int start_ID= (currentPage-1)*pageSize;
	search+="%";
	search="%"+search;
	String sql="SELECT s.*,d.departmentName FROM STUDENT S JOIN DEPARTMENT D "
			+ "ON S.DEPARTMENTID=D.ID WHERE NAME LIKE ? ORDER BY S.ID LIMIT ?,?";
	PreparedStatement pstmt=con.prepareStatement(sql);
	pstmt.setString(1,search);
	pstmt.setInt(2,start_ID);
	pstmt.setInt(3,pageSize);
	ResultSet rs = pstmt.executeQuery();
	
	list=InvertList(rs);
	return list;
} 
// 학생정보를 업데이트하는 메소드
public static int editOne(Student student) throws Exception {
	
	Connection con =getConnection();
	String sql= "UPDATE STUDENT SET  NAME=?,STUDENTNUMBER=?,DEPARTMENTID=?,YEAR=? WHERE ID=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, student.getStudentName());
	pstmt.setString(2, student.getStudentNumber());
	pstmt.setInt(3,student.getDepartmentId());
	pstmt.setInt(4,student.getGrade());
	pstmt.setInt(5,student.getId());
	
	return pstmt.executeUpdate();
	
	
}
	


// 학생정보 추가
public static int insert(Student student) throws Exception{
	
	Connection con =getConnection();
	String sql="INSERT INTO STUDENT(StudentNumber,name,year,departmentId) VALUES  ?,?,?,? ";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,student.getStudentNumber());
	pstmt.setString(2,student.getStudentName());
	pstmt.setInt(3,student.getGrade());
	pstmt.setInt(4,student.getDepartmentId());
	
	return pstmt.executeUpdate();
	


	
}

public static int delete(int id) throws Exception{
	
	Connection con =getConnection();
	String sql="DELETE FROM STUDENT  WHERE ID = ? ";
	
	PreparedStatement pstmt = con.prepareStatement(sql);

	pstmt.setInt(1,id);
	
	return pstmt.executeUpdate();
	
	
}

}




















