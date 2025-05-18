<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">

<style>
  body {
    background-color: #f9f4fc;
    margin-top: 20px;
    padding: 0;
    font-family: 'Pretendard', sans-serif;
    color: #333;
  }

  .quiz-insert-wrapper {
    text-align: center;
    margin: 30px 0 5px;
  }

  .quiz-insert-link {
    display: inline-block;
    font-size: 15px;
    text-decoration: none;
    color: #8658a8;
    font-weight: 500;
  }

  .quiz-insert-link:hover {
    text-decoration: underline;
  }

  .quiz-form {
    background: #ffffff;
    padding: 30px 40px;
    margin: 20px auto;
    width: 90%;
    max-width: 600px;
    border-radius: 16px;
    box-shadow: 0 8px 20px rgba(200, 160, 220, 0.15);
    border: 1px solid #ebd9f4;
    text-align: left;
  }

  .quiz-title {
    font-size: 1.4em;
    color: #8658a8;
    margin-bottom: 20px;
    text-align: center;
  }

  .quiz-option {
    display: block;
    margin: 12px 0;
    font-size: 1.05em;
    background: #fff7f4;
    padding: 12px 16px;
    border-radius: 10px;
    transition: background-color 0.2s;
    cursor: pointer;
    border: 1px solid #f6d8e7;
  }

  .quiz-option:hover {
    background: #fde3ec;
  }

  .quiz-option input {
    margin-right: 10px;
    transform: scale(1.1);
    accent-color: #c59cf3;
  }

  .quiz-submit {
    margin-top: 25px;
    display: block;
    width: 100%;
    padding: 12px;
    background: #d9c7f3;
    color: #fff;
    font-size: 1.05em;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    transition: 0.3s;
    font-weight: bold;
  }

  .quiz-submit:hover {
    background: #c29ee4;
  }

  .quiz-hint {
    font-size: 0.95em;
    color: #666;
    text-align: center;
    margin-top: 14px;
    font-weight: 500;
  }
</style>

</head>
<body>

<c:if test="${sessionScope.user_role eq 'admin'}">
  <div class="quiz-insert-wrapper">
    <a href="QuizInsertPage" class="quiz-insert-link">퀴즈 등록</a>
    <a href="Quizview" class="quiz-insert-link">퀴즈 목록</a>
  </div>
</c:if>

<!-- ✅ 퀴즈 출력 -->
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

<script>
  const startTime = Date.now();
  function onSubmitQuiz(form) {
    const endTime = Date.now();
    const elapsed = Math.floor((endTime - startTime) / 1000);
    form.querySelector("input[name='result_time']").value = elapsed;
    return true;
  }
</script>

<c:if test="${allDone}">
  <script>
    alert("🎉 모든 퀴즈를 완료했습니다! 홈으로 이동합니다.");
    window.location.href = "${pageContext.request.contextPath}/main";
  </script>
</c:if>

</body>
</html>