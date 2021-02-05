<!-- /* JoinPro.jsp */-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="User.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장 작성 위해 필요 -->
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="User.User" scope="page" /> <!-- 현재 페이지에서만 빈즈 사용 -->
<!-- 이 페이지 안에 넘어온 userID와 userPassword가 담기게 된다 -->
<jsp:setProperty name="user" property="userType" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userContact" />
<jsp:setProperty name="user" property="userAddress" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Snack Mall 회원가입</title>
</head>
<body>
	<% 
		//로그인된 유저는 로그인 및 회원가입 페이지에 들어갈 수 없게 함
	    String userID = null;
	    if(session.getAttribute("userID") != null){ //로그인 세션을 가지고 있다면
	    	userID = (String)session.getAttribute("userID"); //세션값을 가질수 있게 함
	    }
	    if(userID != null){ //이미 로그인 한 유저는 또다시 로그인을 할 수 없음
	    	PrintWriter script = response.getWriter();
	    	script.println("<script>");
	    	script.println("alert('이미 로그인 되어 있습니다.')");
	    	script.println("location.href = '../../UserMain.jsp'");
	    	script.println("</script>");
	    }	
	    if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null 
			|| user.getUserEmail() == null || user.getUserContact() == null || user.getUserAddress() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력되지 않은 사항이 존재합니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();	//회원가입 시도(join함수 활용)
												//각각의 변수들을 입력받아서 만들어진 user라는 인스턴스가 join 함수의 매개변수가 됨					
			int result = userDAO.join(user); 
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else { //정상적인 회원가입 완료
				session.setAttribute("userID", user.getUserID()); //로그인 한 사용자에게 세션 부여
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}  
		}
	%>
</body>
</html>

<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
	
<%
	request.setCharacterEncoding("UTF-8"); 
	
%>

<%
	String ID = request.getParameter("ID"); // JoinForm.jsp에서 입력받은 값들을 받아옵니다.
	String PWD = request.getParameter("PWD");
	String UserName = request.getParameter("UserName");
	String Email = request.getParameter("Email");
	String Contact = request.getParameter("Contact");
	String Address = request.getParameter("Address");

	try {
		
		Class.forName("com.mysql.jdbc.Driver");
		String DB_URL = "jdbc:mysql://localhost:3306/snackmall?characterEncoding=UTF-8&serverTimezone=UTC";
		
		//기본: "jdbc:mysql://localhost:3306/web01"
		//"jdbc:mysql://localhost:3306/web01?user=user&password=password&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		//?characterEncoding=UTF-8&serverTimezone=UTC
		//?useUnicode=true&characterEncoding=utf8
		
		String userName="root";
		String password="23er";
		
		Connection con = DriverManager.getConnection(DB_URL, userName, password);
		String sql = "INSERT INTO login_db(ID, PWD, UserName, Email, Contact, Address) VALUES (?,?,?,?,?,?)"; // sql문 작성(입력받은 값들을 보내기 위한 작업)

		PreparedStatement pstmt = con.prepareStatement(sql);

		pstmt.setString(1, ID); // values에 들어갈 각각의 ID, PWD, UserName, Email, Contact, Address 설정
		pstmt.setString(2, PWD);
		pstmt.setString(3, UserName);
		pstmt.setString(4, Email);
		pstmt.setString(5, Contact);
		pstmt.setString(6, Address);

		pstmt.executeUpdate();

		pstmt.close();
		con.close();
	}

	catch(ClassNotFoundException e) {
		out.println(e);
	}
	catch(SQLException e) {
		out.println(e);
	}
%>


<script>
	alert("회원가입을 축하합니다!");
	location.href='../../UserMain.jsp'; 
</script>

 --%>