<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>퀴즈 문제 등록</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">

<style>
  body {
    font-family: 'Gowun Dodum', 'Malgun Gothic', sans-serif;
    margin: 0;
    padding: 0;
  }

  .quiz-box {
    max-width: 720px;
    margin: 0 auto;
    background-color: #ffffff;
    padding: 40px 50px;
    border-radius: 30px;
    box-shadow: 0 8px 20px rgba(255, 204, 229, 0.2); /* 부드러운 그림자 */
    position: relative;
    border: none; /* ✅ 테두리 제거 */
  }

  .quiz-box h1 {
    text-align: center;
    font-size: 28px;
    margin-bottom: 40px;
    font-weight: bold;
    color: #4b357f;
  }

  .form-group {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
  }

  .form-group label {
    width: 90px;
    font-weight: bold;
    color: #444;
    margin-right: 10px;
    font-size: 16px;
    text-align: right;
  }

  .form-control {
    flex: 1;
    height: 42px;
    font-size: 15px;
    border-radius: 12px;
    border: 1px solid #ccc;
    padding: 10px 14px;
  }

  .form-control:focus {
    border-color: #ffbcd9;
    box-shadow: 0 0 4px #ffd7e6;
  }

  .btn-submit {
    background-color: #b6e6e0; /* 파스텔 민트 */
    color: #333;
    font-weight: bold;
    font-size: 16px;
    border: none;
    padding: 12px 28px;
    border-radius: 28px;
    display: block;
    margin: 35px auto 10px;
    transition: 0.2s ease-in-out;
  }

  .btn-submit:hover {
    background-color: #a2ddd5;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(178, 224, 216, 0.4);
  }
</style>
</head>

<body>

<div class="quiz-box">
  <h1>📄 퀴즈 문제 등록 🐾</h1>

  <form action="QuizInsertSave" method="post">
    <div class="form-group">
      <label for="quiz_question">❓ 문제</label>
      <input type="text" class="form-control" id="quiz_question" name="quiz_question" required>
    </div>

    <div class="form-group">
      <label for="quiz_option1">①</label>
      <input type="text" class="form-control" name="quiz_option1" id="quiz_option1" required>
    </div>

    <div class="form-group">
      <label for="quiz_option2">②</label>
      <input type="text" class="form-control" name="quiz_option2" id="quiz_option2" required>
    </div>

    <div class="form-group">
      <label for="quiz_option3">③</label>
      <input type="text" class="form-control" name="quiz_option3" id="quiz_option3" required>
    </div>

    <div class="form-group">
      <label for="quiz_option4">④</label>
      <input type="text" class="form-control" name="quiz_option4" id="quiz_option4" required>
    </div>

    <div class="form-group">
      <label for="quiz_answer">✅ 정답</label>
      <select class="form-control" name="quiz_answer" id="quiz_answer" required>
        <option value="">정답을 등록하세요.</option>
        <option value="1">1번</option>
        <option value="2">2번</option>
        <option value="3">3번</option>
        <option value="4">4번</option>
      </select>
    </div>

    <button type="submit" class="btn-submit">퀴즈 등록</button>
  </form>
</div>

<!-- Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</body>
</html>
