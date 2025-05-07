<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html >
<head>
<style>
  .quiz-form {
    background: #e3fcec;
    padding: 30px 40px;
    margin: 30px auto;
    width: 90%;
    max-width: 600px;
    border-radius: 16px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
    text-align: left;
    border: 1px solid #c1e3d3;
  }

  .quiz-title {
    font-size: 1.4em;
    color: #2f4858;
    margin-bottom: 20px;
    text-align: center;
  }

  .quiz-option {
    display: block;
    margin: 12px 0;
    font-size: 1.05em;
    background: #fefae0;
    padding: 10px 16px;
    border-radius: 10px;
    transition: background-color 0.2s;
    cursor: pointer;
    border: 1px solid #f0e5b8;
  }

  .quiz-option:hover {
    background: #f9f4c8;
  }

  .quiz-option input {
    margin-right: 10px;
    transform: scale(1.1);
    accent-color: #66c2ff;
  }

  .quiz-submit {
    margin-top: 25px;
    display: block;
    width: 100%;
    padding: 12px;
    background: #b9e4cf;
    color: #234;
    font-size: 1.05em;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: 0.3s;
  }

  .quiz-submit:hover {
    background: #a9dcff;
  }

  .quiz-hint {
  font-size: 0.95em;     /* 조금 키움 */
  color: #444;           /* 더 진한 회색 */
  text-align: center;
  margin-top: 14px;
  font-weight: 500;      /* 살짝 굵게 */
}
</style>

<meta charset="UTF-8">
<title>🐶 오늘의 퀴즈 🐱</title>
</head>
<body>

<c:if test="${sessionScope.user_role eq 'admin'}">
  <a href="./QuizInsert" style="display:inline-block; margin-bottom:20px;">➕ 퀴즈 등록</a>
</c:if>

<c:forEach items="${dto}" var="quiz">
  <form action="QuizSave" method="post" class="quiz-form" onsubmit="return onSubmitQuiz(this)">
    <input type="hidden" name="quiz_id" value="${quiz.quiz_id}">
    <input type="hidden" name="result_time" id="result_time">

    <h3 class="quiz-title">❓ <c:out value="${quiz.quiz_question}" /></h3>

    <label class="quiz-option">
      <input type="radio" name="quiz_answer" value="1" required> ${quiz.quiz_option1}
    </label>
    <label class="quiz-option">
      <input type="radio" name="quiz_answer" value="2" required> ${quiz.quiz_option2}
    </label>
    <label class="quiz-option">
      <input type="radio" name="quiz_answer" value="3" required> ${quiz.quiz_option3}
    </label>
    <label class="quiz-option">
      <input type="radio" name="quiz_answer" value="4" required> ${quiz.quiz_option4}
    </label>

    <button type="submit" class="quiz-submit">제출하기</button>

    <p class="quiz-hint">⏱ 풀이 시간은 자동으로 기록됩니다</p>
  </form>
</c:forEach>

<script type="text/javascript">
const startTime = Date.now();
function onSubmitQuiz(form){
	const endTime = Date.now();
	const elapsed = Math.floor((endTime-startTime)/1000);
	const resultInput = form.querySelector("input[name='result_time']");
	resultInput.value =elapsed;
	 return true;
}
</script>
</body>
</html>