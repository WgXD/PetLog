<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<!-- CSS 스타일 정의 -->
<style>
  body {
    font-family: Arial, sans-serif; /* 전체 폰트 */
    text-align: center; /* 텍스트 중앙 정렬 */
    margin-top: 100px; /* 위쪽 여백 */
  }

  /* 결과 텍스트 스타일 */
  .result {
    font-size: 30px; /* 폰트 크기 */
    margin-top: 30px; /* 위쪽 여백 */
  }

  /* 다음 문제 버튼 스타일 */
  .btn-next {
    margin-top: 30px;
    padding: 10px 30px;
    font-size: 20px;
    background-color: #add8e6; /* 연한 하늘색 */
    border: none;
    border-radius: 10px; /* 둥근 모서리 */
    cursor: pointer; /* 마우스 커서 모양 변경 */
  }
</style>
<meta charset="UTF-8">
<title>Quiz Result</title>
</head>
<body>
<h1>결과</h1>
<p class="result">
	<c:choose> <!-- 조건문 -->
		<c:when test="${isCorrect}">
		 <p>🎉 정답입니다! 포도알 10개 획득 🎉</p>
		</c:when>
		<c:otherwise>
		 <p>😢 오답입니다. 다음에 다시 도전!</p>
		</c:otherwise>
	</c:choose>
</p>
<a href="/QuizList">다시 풀기</a>
</body>
</html>