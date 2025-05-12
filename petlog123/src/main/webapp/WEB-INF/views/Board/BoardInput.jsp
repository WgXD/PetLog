<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
<style>
  body {
    font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
    background-color: #ffffff; /* 흰색 배경 유지 */
    margin: 0;
    padding: 0;
  }
  form {
    width: 70%;
    margin: 0 auto;
    background: none;
    padding: 20px 0;
  }
  h2 {
    text-align: center;
    margin-bottom: 30px;
    color: #333;
    font-size: 1.8em;
  }
  table {
    width: 100%;
    border-collapse: collapse;
  }
  th {
    text-align: left;
    padding: 10px 15px;
    font-size: 1em;
    color: #555;
    background-color: #f9f9f9;
    border-top: 1px solid #ddd;
    border-bottom: 1px solid #ddd;
    width: 20%;
  }
  td {
    padding: 10px 15px;
    border-bottom: 1px solid #eee;
  }
  input[type="text"], textarea {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 1em;
    background-color: #fff;
    box-sizing: border-box;
  }
  textarea {
    resize: vertical;
    min-height: 250px;
  }
  input[type="file"] {
    font-size: 0.9em;
  }
  .btn-area {
    text-align: center;
    margin-top: 30px;
  }
  .btn {
    display: inline-block;
    padding: 10px 25px;
    font-size: 1em;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s;
    margin: 0 8px;
  }
  .btn-submit {
    background-color: #f5d7d7; /* 부드러운 연핑크 */
    color: #333;
  }
  .btn-submit:hover {
    background-color: #f0caca; /* 호버 시 조금 진한 연핑크 */
  }
  .btn-cancel {
    background-color: #f0e5d8; /* 연베이지/살구색 */
    color: #333;
  }
  .btn-cancel:hover {
    background-color: #e9dbcd; /* 호버 시 살짝 더 진한 살구 */
  }
  .table-wrapper {
  background-color: white;
  width: 100%;
  max-width: 5000px;
  margin: 20px auto;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  padding: 30px;
}
</style>
</head>
<body>

<form action="CommunitySave" method="post" enctype="multipart/form-data">
  <h2>공지사항 작성</h2>
 <div class="table-wrapper">
  <table>
    <!-- 관리자만 공지사항 작성 가능 -->
    <c:if test="${sessionScope.user_role eq 'admin'}">
      <tr>
        <th>글 종류</th>
        <td>
          <label><input type="radio" name="post_type" value="notice" checked> 공지사항</label>
          <label style="margin-left:20px;"><input type="radio" name="post_type" value="normal"> 일반글</label>
        </td>
      </tr>
    </c:if>

    <!-- 일반 유저는 hidden으로 일반글 선택 -->
    <c:if test="${sessionScope.user_role ne 'admin'}">
      <input type="hidden" name="post_type" value="normal" />
    </c:if>

    <tr>
      <th>제목</th>
      <td><input type="text" name="post_title" required placeholder="제목을 입력하세요"></td>
    </tr>
    <tr>
      <th>내용</th>
      <td><textarea name="post_content" required placeholder="내용을 입력하세요"></textarea></td>
    </tr>
    <tr>
      <th>사진 첨부</th>
      <td><input type="file" name="post_image"></td>
    </tr>
  </table>
</div>

  <div class="btn-area">
    <input type="submit" class="btn btn-submit" value="저장">
    <input type="button" class="btn btn-cancel" value="취소" onclick="location.href='./main'">
  </div>
</form>

</body>
</html>
