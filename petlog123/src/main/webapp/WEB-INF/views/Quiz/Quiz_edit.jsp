<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>퀴즈 수정</title>
  <style>
    body {
      background-color: #fff6f6;
      font-family: 'Pretendard', sans-serif;
      margin: 0;
      padding: 0;
      color: #333;
    }

    .container {
      max-width: 700px;
      background-color: #fff;
      margin: 60px auto;
      padding: 40px;
      border-radius: 16px;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      color: #f48aa5;
      margin-bottom: 30px;
    }

    label {
      display: block;
      margin-bottom: 10px;
      font-weight: bold;
      color: #555;
    }

    input[type="text"],
    select {
      width: 100%;
      padding: 12px;
      margin-bottom: 20px;
      border: 1px solid #ddd;
      border-radius: 8px;
      font-size: 1em;
      box-sizing: border-box;
      background-color: #fff;
      transition: border-color 0.2s;
    }

    input[type="text"]:focus,
    select:focus {
      border-color: #f48aa5;
      outline: none;
    }

    button {
      background-color: #f48aa5;
      color: white;
      border: none;
      padding: 12px 20px;
      font-size: 1em;
      border-radius: 8px;
      cursor: pointer;
      width: 100%;
      transition: background-color 0.3s;
    }

    button:hover {
      background-color: #db7093;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>퀴즈 수정</h2>
  <form method="post" action="${pageContext.request.contextPath}/quiz_admin/update">
    <input type="hidden" name="quiz_id" value="${dto.quiz_id}" />

    <label>문제</label>
    <input type="text" name="quiz_question" value="${dto.quiz_question}" />

    <label>보기 1</label>
    <input type="text" name="quiz_option1" value="${dto.quiz_option1}" />

    <label>보기 2</label>
    <input type="text" name="quiz_option2" value="${dto.quiz_option2}" />

    <label>보기 3</label>
    <input type="text" name="quiz_option3" value="${dto.quiz_option3}" />

    <label>보기 4</label>
    <input type="text" name="quiz_option4" value="${dto.quiz_option4}" />

    <label>정답 번호</label>
    <select name="quiz_answer">
      <option value="1" ${dto.quiz_answer == '1' ? 'selected' : ''}>1</option>
      <option value="2" ${dto.quiz_answer == '2' ? 'selected' : ''}>2</option>
      <option value="3" ${dto.quiz_answer == '3' ? 'selected' : ''}>3</option>
      <option value="4" ${dto.quiz_answer == '4' ? 'selected' : ''}>4</option>
    </select>

    <button type="submit">수정 완료</button>
  </form>
</div>

</body>
</html>
