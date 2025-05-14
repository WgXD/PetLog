<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">

<style>
  body {
    font-family: 'Pretendard', sans-serif;
    background-color: #fefefe;
    margin: 0;
    padding: 0;
  }

  .content-wrapper {
    max-width: 600px;
    height: 260px; /* 높이 지정 */
    background-color: white;
    margin: 40px auto;
    padding: 0 40px;
    border-radius: 24px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);

    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }

  .content-wrapper h2 {
    color: #444;
    font-size: 24px;
    margin-bottom: 20px;
  }

  .content-wrapper a {
    font-size: 16px;
    color: #f06292;
    font-weight: bold;
    text-decoration: none;
  }

  .content-wrapper a:hover {
    text-decoration: underline;
  }
</style>
</head>
<body>
  <div class="content-wrapper">
    <h2>아이템 착용 완료!</h2>
      <p style="font-size: 16px;">
    <a href="${pageContext.request.contextPath}/items/buy_items" 
       style="color: #f06292; font-weight: bold; text-decoration: none; display: inline;">
      💝 My 아이템 💝
    </a>
    으로 돌아가기
  </p>
  </div>

</body>
</html>