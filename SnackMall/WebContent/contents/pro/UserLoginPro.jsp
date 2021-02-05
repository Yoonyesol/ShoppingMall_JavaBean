<!-- /* LoginPro.jsp */-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<%@ page import="User.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>	
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="User.User" scope="page" /> <!-- 현재 페이지에서만 빈즈 사용 -->
<!-- 이 페이지 안에 넘어온 userID와 userPassword가 담기게 된다 -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
</head>
<body>
	<% 
		//로그인된 유저는 로그인 및 회원가입 페이지에 들어갈 수 없게 함
		String userID = null;
		String userType = null;
		if(session.getAttribute("userID") != null){ //로그인 세션을 가지고 있다면
			userID = (String)session.getAttribute("userID"); //세션값을 가질수 있게 함
		}
		UserDAO userDAO = new UserDAO();
		//로그인 시도
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result == 1){	//로그인 성공
			session.setAttribute("userID", user.getUserID()); //로그인 한 사용자에게 세션 부여
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = '../../UserMain.jsp'");
			script.println("</script>");
		} else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀렸습니다.')");
			script.println("history.back()"); //메인페이지로 사용자 돌려보내기
			script.println("</script>");
		} else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}		
	%>
</body>
</html>