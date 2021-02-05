<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Snack Mall</title>
</head>
<body>
	<%
		//세션초기화
		session.invalidate();
	%>
	<script>
		alert("로그아웃 되었습니다.");
		location.href = "../../UserMain.jsp";
	</script>
</body>
</html>