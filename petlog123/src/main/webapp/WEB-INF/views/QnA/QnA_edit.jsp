<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>QnA 수정</title>
  <style>
    body {
      background-color: #fff6f6;
      font-family: 'Pretendard', sans-serif;
    }

    .container {
      max-width: 700px;
      margin: 60px auto;
      padding: 40px;
      background: #fff;
      border-radius: 16px;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      color: #f48aa5;
      margin-bottom: 30px;
    }

    input[type="text"], textarea {
      width: 100%;
      padding: 12px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 8px;
    }

    button {
      width: 100%;
      padding: 12px;
      background-color: #f48aa5;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 1em;
    }
  </style>
</head>
<body>

<c:if test="${not empty alertMsg}">
  <script>
    alert("${fn:escapeXml(alertMsg)}");
  </script>
</c:if>

  <div class="container">
    <h2>QnA 수정</h2>
    <form method="post" action="${pageContext.request.contextPath}/qna/update">
      <input type="hidden" name="qna_id" value="${dto.qna_id}" />
      <input type="hidden" name="user_id" value="${dto.user_id}" />
      <input type="hidden" name="qna_status" value="${dto.qna_status}">
      
      <input type="text" name="qna_title" value="${dto.qna_title}" placeholder="제목"/><br/>
      <textarea name="qna_content" rows="6" placeholder="내용">${dto.qna_content}</textarea><br/>
      
      <button type="submit">수정 완료</button>
    </form>
  </div>
</body>
</html>
