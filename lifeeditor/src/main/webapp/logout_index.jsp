<%@page import="com.lifeeditor.chatroom.ChatEndpoint"%>
<%@page import="com.lifeeditor.model.user_spec.user_specVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%
  if(session.getAttribute("LoginOK") != null) {
  	user_specVO user = (user_specVO)session.getAttribute("LoginOK");
  	if(ChatEndpoint.onlinePool.containsKey(user.getUserID()))    
  	  ChatEndpoint.onlinePool.remove(user.getUserID());
  }
  session.invalidate();
%>
<head>
<script>
window.location.href = "${ctx}"
</script>
</head>
<body>
</body>
</html>
