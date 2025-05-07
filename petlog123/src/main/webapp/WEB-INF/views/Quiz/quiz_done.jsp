<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퀴즈 완료</title>
<style>
  .quiz-complete-container {
    text-align: center;
    padding: 120px 20px;
    font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
  }

  .quiz-complete-icon {
    font-size: 3rem;
    margin-bottom: 10px;
  }

  .quiz-complete-message {
    font-size: 2rem;
    font-weight: bold;
    color: #43a047;
    margin-bottom: 30px;
  }

  .btn-home {
    background-color: #81d4fa;
    color: white;
    padding: 12px 30px;
    font-size: 1.1rem;
    text-decoration: none;
    border-radius: 12px;
    font-weight: bold;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    transition: background-color 0.3s ease;
  }

  .btn-home:hover {
    background-color: #4fc3f7;
  }
</style>
</head>
<body>

<div class="quiz-complete-container">
  <div class="quiz-complete-icon">🎁</div>
  <div class="quiz-complete-message">🎉 ${message} 🎉</div>
  <a href="main" class="btn-home">🏠 홈으로 가기</a>
</div>

</body>
</html>
