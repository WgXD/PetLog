<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<style>
  body {
    font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
    background-color: #ffffff; /* 흰색 배경 유지 */
    margin: 0;
    padding: 30px 0;
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
</style>
</head>
<body>
<form action="CommunitySave" method="post" enctype="multipart/form-data" onsubmit="return beforeSubmit()">
<table>
  <caption>게시글 작성</caption>
  <c:if test="${sessionScope.user_role eq 'admin'}">
    <tr>
      <th>구분</th>
      <td>
        <label><input type="radio" name="post_type" value="notice"> 공지사항</label>
        <label><input type="radio" name="post_type" value="normal" checked> 일반글</label>
      </td>
    </tr>
  </c:if>
  <c:if test="${sessionScope.user_role ne 'admin'}">
    <input type="hidden" name="post_type" value="normal" />
  </c:if>
  <tr>
    <th>제목</th>
    <td><input type="text" name="post_title" required style="width: 95%;"></td>
  </tr>
  <tr>
    <th>내용</th>
    <td>
      <div id="contentDiv" contenteditable="true"></div>
      <input type="hidden" name="post_content" id="hiddenContent">
    </td>
  </tr>
  <tr>
    <th>사진 추가</th>
    <td>
      <input type="file" id="post_image" accept="image/*" onchange="insertImage()" multiple>
    </td>
  </tr>
  <tr>
    <td colspan="2" style="text-align:center;">
      <input type="submit" value="저장">
      <input type="button" value="취소" onclick="location.href='./main'">
    </td>
  </tr>
</table>
</form>
<script>
// 폼 전송 시 div 내용을 숨겨진 input에 넣기
function beforeSubmit() {
    document.getElementById('hiddenContent').value = document.getElementById('contentDiv').innerHTML;
    return true;
}
// 파일 선택 시 이미지 삽입
function insertImage() {
    const files = document.getElementById('post_image').files;
    const contentDiv = document.getElementById('contentDiv');

    for (let i = 0; i < files.length; i++) {
        if (files[i].name) {  // 파일 이름이 있을 때만
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.style.maxWidth = '80%';
                img.style.height = 'auto';
                img.style.display = 'block';
                img.style.marginTop = '10px';
                img.style.marginLeft = 'auto';
                img.style.marginRight = 'auto';
                contentDiv.appendChild(img);
            }
            reader.readAsDataURL(files[i]);
        }
    }
}
</script>
</body>
</html>