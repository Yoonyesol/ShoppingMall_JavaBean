package User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn; 
	private PreparedStatement pstmt; 
	private ResultSet rs;

	public UserDAO() {
		try { 
			String dbURL = "jdbc:mysql://localhost:3306/snackmall?characterEncoding=UTF-8&serverTimezone=UTC"; 
			String dbID = "root"; 
			String dbPassword = "23er"; 
			Class.forName("com.mysql.jdbc.Driver"); 
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword); 
		} catch(Exception e) { 
			e.printStackTrace(); 
		} 
	}

	public int UserLogin(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM login_db WHERE userID = ?"; 
		try { 
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID); // sql 문에서 ?에 해당하는 값에 userID를 집어넣음 첫번째 물음표일 경우 1 두번째 물음표이면 2이런식으로 
			rs = pstmt.executeQuery(); // sql 수행결과를 rs에 저장(Boolean) 존재시 true 존재x = false
			if(rs.next()) { //결과가 존재
				if(rs.getString(1).equals(userPassword))  // ?로 사용자에게 받은 ID와 비밀번호가 일치하는 경우
					return 1; //로그인 성공
				else 
					return 0; //Password오류
			} 
			return -1; //ID오류
		} catch(Exception e) { 
			e.printStackTrace(); 
		} 
		return -2; //db오류
	}
	
	public int AdminLogin(String userID, String userPassword, String userType) {
		String admin = "admin";
		String SQL = "SELECT userType, userPassword FROM login_db WHERE userID = ?"; 
		try { 
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID); // sql 문에서 ?에 해당하는 값에 userID를 집어넣음 첫번째 물음표일 경우 1 두번째 물음표이면 2이런식으로 
			rs = pstmt.executeQuery(); // sql 수행결과를 rs에 저장(Boolean) 존재시 true 존재x = false
			if(rs.next()) { //결과가 존재
				if(rs.getString(1).equals(userPassword))  // ?로 사용자에게 받은 ID와 비밀번호가 일치하는 경우
					if(admin.equals(userType)) //유저타입이 admin인 경우
						return 1; //로그인 성공
					else 
						return 0;
				else 
					return 0; //Password오류
			} 
			return -1; //ID오류
		} catch(Exception e) { 
			e.printStackTrace(); 
		} 
		return -2; //db오류
	}

	public int join(User user) {
		String SQL = "INSERT INTO login_db (userID, userPassword, userName, userEmail, userContact, userAddress) VALUES(?, ?, ?, ?, ?, ?)"; //login_db table에 해당 값을 인서트
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserContact());
			pstmt.setString(6, user.getUserAddress());			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} 
		return -1; //데이터베이스 오류
	}
}