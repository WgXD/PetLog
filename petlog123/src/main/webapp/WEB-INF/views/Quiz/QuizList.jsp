<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html >
<head>
<style>
  body {
    font-family: Arial, sans-serif;
    text-align: center;
    margin-top: 100px;
  }
  .btn-ox {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    border: none;
    font-size: 30px;
    margin: 20px;
    cursor: pointer;
  }
  .btn-o {
    background-color: #b4d8f7;
  }
  .btn-x {
    background-color: #f7b4b4;
  }
  .btn-submit {
    display: block;
    margin: 30px auto;
    padding: 10px 30px;
    font-size: 20px;
    background-color: #add8e6;
    border: none;
    border-radius: 10px;
    cursor: pointer;
  }
</style>
<meta charset="UTF-8">
<title>Quiz</title>
</head>
<body>

<c:if test="${sessionScope.user_role eq 'admin'}">
  <a href="/QuizInsertPage" style="display:inline-block; margin-bottom:20px;">➕ 퀴즈 등록</a>
</c:if>

<c:forEach items="${dto}" var="quiz">
	<form action="QuizSave" method="post">
		<h3><c:out value="${quiz.quiz_question}"/></h3>
        <input type="hidden" name="quiz_id" value="${quiz.quiz_id}">

        <p><input type="radio" name="quiz_answer" value="1" required> <c:out value="${quiz.quiz_option1}"></c:out></p>
        <p><input type="radio" name="quiz_answer" value="2" required> <c:out value="${quiz.quiz_option2}"></c:out></p>
        <p><input type="radio" name="quiz_answer" value="3" required> <c:out value="${quiz.quiz_option3}"></c:out></p>
        <p><input type="radio" name="quiz_answer" value="4" required> <c:out value="${quiz.quiz_option4}"></c:out></p>

        <button type="submit">제출</button>
	</form>
</c:forEach>
</body>
</html>