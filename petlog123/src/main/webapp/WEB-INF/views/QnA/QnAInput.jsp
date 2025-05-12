<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>문의사항</title>
  <style>
    body {
      margin: 0;
      padding: 0;
    }

    .contact-form-container {
      background-color: rgba(255, 255, 255, 0.95);
      width: 420px;
      margin: 100px auto;
      padding: 35px 30px;
      border-radius: 18px;
      box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      margin-bottom: 25px;
      color: #444;
      font-size: 24px;
    }

    input, textarea {
      width: 100%;
      padding: 12px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 10px;
      box-sizing: border-box;
      font-size: 14px;
      transition: 0.3s;
    }

    input:focus, textarea:focus {
      outline: none;
      border-color: #a0ded7; /* 민트 테두리 */
      box-shadow: 0 0 5px rgba(160, 222, 215, 0.5);
    }

    button {
      width: 100%;
      padding: 13px;
      background-color: #d8f8f1; /* 파스텔 민트 */
      color: #333;
      border: none;
      border-radius: 10px;
      font-size: 15px;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    button:hover {
      background-color: #bcebe1;
    }
  </style>
</head>
<body>
  <div class="contact-form-container">
    <h2>QnA 작성</h2>
    <form action="submitContact" method="post">
      <input type="text" name="qna_title" placeholder="제목을 입력하세요." required>
      <textarea rows="5" name="qna_content" placeholder="내용을 입력하세요." required></textarea>
      <button type="submit">등록</button>
    </form>
  </div>
</body>
</html>
