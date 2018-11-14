package DAO;

import DTO.*;

import java.sql.*;
import java.util.*; 
public class DepartmentDAO {

	
	//  전체 학과를 조회하는 메서드 
	public static List<Department> findAll() throws Exception{
		Connection con = StudentDAO.getConnection();
		String sql = "SELECT * FROM DEPARTMENT";
		Statement stmt =con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		List<Department> list = InvertList(rs);
		return list;
		
	}
	
	// ResultSet 을 List 콜렉션으로 전환 시켜주는 메서드 
	
	public static List<Department> InvertList(ResultSet rs) throws Exception{
		List<Department> list =new ArrayList<Department>();
		while(rs.next()) {
			Department department= new Department();
			department.setId(rs.getInt("id"));
			department.setDepartmentName(rs.getString("departmentName"));
			list.add(department);
			
			
		}
		return list;
		
		}
}
