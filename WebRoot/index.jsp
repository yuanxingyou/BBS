<%@ page language="java" import="java.util.*,entity.*,dao.*,dao.impl.*" pageEncoding="utf-8"%>
<%
	BoardDao boardDao = new BoardDaoImpl();
	Map mapBoard = boardDao.findBoard();
	TopicDao topicDao = new TopicDaoImpl();
	UserDao userDao = new UserDaoImpl();
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页</title>
<style type="text/css">
<!--
#apDiv1 {
	position:absolute;
	left:1px;
	top:1px;
	width:800px;
	height:50px;
	z-index:1;
}
#apDiv2 {
	position:absolute;
	left:1px;
	top:51px;
	width:800px;
	height:25px;
	z-index:2;
	background-color: #e0f0f9;
}
#apDiv3 {
	position:absolute;
	left:1px;
	top:76px;
	width:800px;
	height:500px;
	z-index:3;
}
.STYLE1 {
	font-family: "黑体";
	font-weight: bold;
	font-size: 36px;
	color: #3399CC;
}
.STYLE3 {
	font-family: "黑体";
	color: #3399CC;
}
.STYLE4 {
	color:  #004c7d;
	font-size: 12px;
}
-->
</style>
</head>

<body>
<div id="apDiv3">
  <table width="100%" height="503" border="1" cellpadding="0" cellspacing="0">
    <tr>
      <td colspan="2" align="left" valign="middle"><span class="STYLE4">论坛</span></td>
      <td width="5%" class="STYLE4">主题</td>
      <td width="45%" class="STYLE4">最后发表</td>
    </tr>
    <!-- 主板块 -->
    <%
    	List listMainBoard = (List)mapBoard.get(0);
    	for(int i = 0; i< listMainBoard.size();i++) {
    		Board mainBoard = (Board)listMainBoard.get(i);
     %>
    <tr>
      <td colspan="4" class="STYLE4"><%=mainBoard.getBoardName() %></td>
    </tr>
    <!-- 子板块 -->
    <%
    	List listSonBoard = (List)mapBoard.get(mainBoard.getBoardId());
    	for(int j = 0; j< listSonBoard.size(); j++){
    		Board sonBoard = (Board)listSonBoard.get(j);
    		Topic topic = new Topic();
    		User user = new User();
    		int boardId = sonBoard.getBoardId();
    		List listTopic = topicDao.findListTopic(1,boardId);
    		if(listTopic != null && listTopic.size() > 0) {
    			topic = (Topic)listTopic.get(0);
    			user = userDao.findUser(topic.getUid());
    		}
     %>
    <tr>
      <td width="6%">&nbsp;</td>
      <td width="44%"><img src="image/board.gif" width="26" height="29" /><span class="STYLE4"><%=sonBoard.getBoardName() %></span></td>
      <td><%=topicDao.findCountTopic(boardId) %></td>
      <td><%=topic.getTitle() %><br><%=user.getUName() %>[<%=topic.getPublishTime() %>]</td>
    </tr>
    <%} 
    }%>
  </table>
</div>
</body>
</html>
