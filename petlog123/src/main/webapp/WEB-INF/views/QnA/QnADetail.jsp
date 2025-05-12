<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>QnA 상세 보기</title>
  <style>
    body {
      font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
      background-color: #f9f9f9;
      margin: 0;
      padding: 0;
    }

    .qna-box {
      width: 60%;
      margin: 0 auto;
      background-color: #fff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #333;
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
      background-color: #f0d7dc;
      color: #333;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .btn-wrap button:hover {
      background-color: #e0bfc7;
    }

    /* 관리자 답변 작성 영역 */
    .admin-answer-box {
      margin-top: 40px;
      padding: 25px;
      background-color: #fff8fb; /* 연한 파스텔 핑크 */
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
      background-color: #d8f8f1; /* ✨ 눈에 편한 민트톤 */
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
  </style>
</head>
<body>

<div class="qna-box">
  <h2>문의 상세 보기</h2>

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
      <td id="qna-content">${dto.qna_content}</td>
    </tr>
    <tr>
      <th>상태</th>
      <td>${dto.qna_status}</td>
    </tr>

    <c:if test="${not empty dto.qna_answer}">
      <tr>
        <th>관리자 답변</th>
        <td class="qna-content">${dto.qna_answer}</td>
      </tr>
    </c:if>
  </table>

  <c:if test="${sessionScope.user_role eq 'admin'}">
    <div class="admin-answer-box">
      <h3>📬 <span style="margin-left: 5px;">관리자 답변 작성</span></h3>
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
    <button onclick="location.href='qnalist'">목록으로 돌아가기</button>
  </div>
</div>

</body>
</html>
