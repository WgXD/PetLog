<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html long="ko">
<head>
 <!-- Bootstrap CSS -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
   <style>
    body {
      font-family: "Malgun Gothic", sans-serif;
      background-color: #f9f9f9;
      padding: 50px;
    }
    .container {
      max-width: 600px;
      background: #fff;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    h2 {
      text-align: center;
      margin-bottom: 30px;
    }
    .form-group label {
      font-weight: bold;
    }
    .btn-primary {
      width: 100%;
    }
  </style>
<meta charset="UTF-8">
<title>퀴즈 문제 등록</title>
</head>
<body>
<h1>📝퀴즈 문제 등록📝</h1>

<form action="QuizInsertSave" method="post">
	<div class="form-group">
      <label for="quiz_question">문제</label>
      <input type="text" class="form-control" id="quiz_question" name="quiz_question" required>
    </div>
    
    <div class="form-group">
      <label for="quiz_option1">보기 1</label>
      <input type="text" class="form-control" name="quiz_option1" id="quiz_option1" required>
    </div>

    <div class="form-group">
      <label for="quiz_option2">보기 2</label>
      <input type="text" class="form-control" name="quiz_option2" id="quiz_option2" required>
    </div>

    <div class="form-group">
      <label for="quiz_option3">보기 3</label>
      <input type="text" class="form-control" name="quiz_option3" id="quiz_option3" required>
    </div>

    <div class="form-group">
      <label for="quiz_option4">보기 4</label>
      <input type="text" class="form-control" name="quiz_option4" id="quiz_option4" required>
    </div>
    
    <div class="form-group">
      <label for="quiz_answer">정답 번호(1~4)</label>
      <select class="form-control" name="quiz_answer" id="quiz_answer" required>
      	<option value="">==선택==</option>
      	<option value="1">1번 보기</option>
      	<option value="2">2번 보기</option>
      	<option value="3">3번 보기</option>
      	<option value="4">4번 보기</option>
      </select>
    </div>

    <button type="submit" class="btn btn-primary">등록하기</button>
  </form>
<!-- Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</body>
</html>