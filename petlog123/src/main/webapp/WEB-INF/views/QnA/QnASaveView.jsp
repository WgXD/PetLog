<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>

  <style>
    body {
      text-align: center;
      background-color: #ffffff; /* 배경 제거 */
    }

    .btn {
      display: inline-block;
      margin: 0 8px;
      padding: 8px 18px;
      border: none;
      border-radius: 0;
      font-size: 13px;
      text-decoration: none;
      cursor: pointer;
      transition: background-color 0.3s ease;
      color: #2c3e50;
    }

    .btn-top {
      margin-top: 30px;
      margin-bottom: 15px;
    }

    .btn-green { background-color: #f48aa5; border-radius: 16px; }   /* 연 민트 */
    .btn-orange { background-color: #ffcc80; }  /* 파스텔 오렌지 */
    .btn-purple { background-color: #d1c4e9; }  /* 파스텔 보라 */

    .btn:hover {
      opacity: 0.85;
    }

    .box {
      display: inline-block;
      background: white;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }

    h2 {
      color: #2c3e50;
      margin-bottom: 15px;
    }

    p {
      color: #666;
      font-size: 14px;
    }

    .btn-group {
      margin-top: 25px;
    }
  </style>
</head>
<body>

  <div class="btn-top">
    <a href="${pageContext.request.contextPath}/QnAinput" class="btn btn-green">새 Q&A</a>
  </div>

  <div class="box">
    <h2>문의가 정상적으로 접수되었습니다!</h2>
    <p>확인 후 빠르게 답변드리겠습니다.</p>

    <div class="btn-group">
      <a href="${pageContext.request.contextPath}/main" class="btn btn-orange">메인 화면</a>
      <a href="javascript:history.back()" class="btn btn-purple">이전 페이지</a>
    </div>
  </div>

</body>
</html>
