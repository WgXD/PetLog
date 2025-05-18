<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    body {
      font-family: "Pretendard", sans-serif;
      background-color: #fff6f6;
      margin: 0;
      padding: 0;
      color: #333;
    }

    .qna-box {
      width: 100%;
      max-width: 800px;
      margin: 40px auto 80px auto;
      background-color: #fff;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }
    
    h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #f48aa5;
      font-weight: normal;
      font-size: 1.8em;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th, td {
      padding: 14px;
      text-align: left;
      vertical-align: top;
      border-bottom: 1px solid #eee;
      font-size: 1em;
    }

    th {
      width: 20%;
      font-weight: bold;
      color: #444;
      background-color: #fff0f4;
      text-align: center;
    }

    td {
      color: #333;
    }

    .qna-content {
      white-space: pre-wrap;
      line-height: 1.6;
    }

    .btn-wrap {
      margin-top: 30px;
      text-align: right;
    }

    .btn-wrap button {
      padding: 8px 16px;
      font-size: 14px;
      border: none;
      background-color: #ffe3e3;
      color: #333;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .btn-wrap button:hover {
      background-color: #e0bfc7;
    }

    .admin-answer-box {
      margin-top: 40px;
      padding: 25px;
      background-color: #fff8fb;
      border-radius: 10px;
    }

    .admin-answer-box h3 {
      color: #d66b7d;
      margin-bottom: 15px;
      font-size: 18px;
    }

    .admin-answer-box label {
      display: block;
      font-weight: bold;
      color: #555;
      margin-bottom: 6px;
      font-size: 14px;
    }

    .admin-answer-box textarea {
      width: 100%;
      padding: 10px;
      border-radius: 6px;
      border: 1px solid #ccc;
      resize: vertical;
      font-size: 14px;
    }

    .admin-answer-box select {
      padding: 8px 12px;
      border-radius: 6px;
      border: 1px solid #ccc;
      background-color: #fff;
      font-size: 14px;
    }

    .admin-answer-box button {
      margin-top: 15px;
      padding: 8px 20px;
      background-color: #d8f8f1;
      color: #333;
      border: none;
      border-radius: 6px;
      font-size: 14px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .admin-answer-box button:hover {
      background-color: #bcebe1;
    }
    
    table tr:first-child th,
table tr:first-child td {
  border-top: 1px solid #eee;
}
  </style>
</head>
<body>

<c:if test="${not empty alertMsg}">
  <script>
    alert("${fn:escapeXml(alertMsg)}");
  </script>
</c:if>

<div class="qna-box">
  <h2>📔 Q&A 상세보기</h2>

  <table>
    <tr>
      <th>작성자</th>
      <td>${dto.user_login_id}</td>
    </tr>
    <tr>
      <th>작성일</th>
      <td>${dto.qna_date}</td>
    </tr>
    <tr>
      <th>제목</th>
      <td>${dto.qna_title}</td>
    </tr>
    <tr>
      <th>내용</th>
      <td class="qna-content">${dto.qna_content}</td>
    </tr>
    <tr>
      <th>상태</th>
      <td>${dto.qna_status}</td>
    </tr>
  </table>   


<!-- ✅ 답변이 있으면 모두에게 보여주기 -->
<c:if test="${not empty dto.qna_answer}">
  <div style="margin-top: 40px; padding: 20px;  border: 1px solid #f4c6d2; border-radius: 10px;">
    <h3 style="color: #d66b7d; font-size: 18px; margin-bottom: 10px;">
      <img src="./image/${dto._image}" style="width: 20px; vertical-align: middle; margin-right: 5px;">
      관리자 답변
    </h3>
    <div style="white-space: pre-wrap; line-height: 1.6; font-size: 14px; color: #444;">
      ${dto.qna_answer}
    </div>
  </div>
</c:if>


<c:if test="${sessionScope.user_role eq 'admin'}">
  <div class="admin-answer-box">
    <!-- 답변 작성 폼 -->
    <h3 style="color: #f48aa5; font-size: 17px; margin-bottom: 10px;">
      <img src="./image/default.png" style="width: 18px; vertical-align: middle; margin-right: 5px;">
      관리자 답변 작성
    </h3>
    <form action="updateAnswer" method="post">
      <input type="hidden" name="qna_id" value="${dto.qna_id}" />

      <label for="qna_answer">답변 내용</label>
      <textarea name="qna_answer" id="qna_answer" rows="5">${dto.qna_answer}</textarea>

      <label for="qna_status">문의 상태</label>
      <select name="qna_status" id="qna_status">
        <option value="처리중" ${dto.qna_status eq '처리중' ? 'selected' : ''}>처리중</option>
        <option value="완료" ${dto.qna_status eq '완료' ? 'selected' : ''}>완료</option>
      </select>

      <button type="submit">답변 등록</button>
    </form>
  </div>
</c:if>

<div class="btn-wrap">

  <c:if test="${sessionScope.user_id == dto.user_id}">
  <c:choose>
    <c:when test="${dto.qna_status eq '완료'}">
      <button onclick="alert('답변이 달린 글은 수정할 수 없습니다.'); return false;">✏️ 수정</button>
    </c:when>
    <c:otherwise>
      <button onclick="location.href='${pageContext.request.contextPath}/qna/edit/${dto.qna_id}'">✏️ 수정</button>
    </c:otherwise>
  </c:choose>
</c:if>

  <c:choose>
  <c:when test="${dto.qna_status eq '완료'}">
    <button onclick="alert('답변이 달린 글은 삭제할 수 없습니다.'); return false;">🗑 삭제</button>
  </c:when>
  <c:otherwise>
    <button onclick="if(confirm('삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/qna/delete/${dto.qna_id}'">🗑 삭제</button>
  </c:otherwise>
</c:choose>

    <button onclick="location.href='qnalist'">목록으로 돌아가기</button>
  </div>


</body>
</html>