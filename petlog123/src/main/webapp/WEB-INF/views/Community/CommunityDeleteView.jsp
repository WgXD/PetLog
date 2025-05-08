<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 삭제 확인</title>
<style>
  body {
    font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 20px;
  }
  table {
    width: 80%;
    margin: 0 auto;
    border-collapse: collapse;
    background-color: #fff;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    border-radius: 10px;
    overflow: hidden;
  }
  caption {
    caption-side: top;
    font-size: 1.4em;
    font-weight: bold;
    padding: 20px;
    background-color: #f1f1f1;
    color: #333;
  }
  th, td {
    padding: 14px 12px;
    border-bottom: 1px solid #ddd;
    text-align: center;
    font-size: 0.95em;
  }
  th {
    background-color: #f5f5f5;
    color: #555;
  }
  #contentDiv {
    width: 100%;
    min-height: 300px;
    border: 1px solid #ccc;
    padding: 10px;
    background: #fff;
    text-align: left;
  }
  #contentDiv img {
    max-width: 200px;
    height: auto;
    display: block;
    margin: 10px auto 0 auto;
}
</style>
</head>

<body>
<form action="DetailSave" method="post" enctype="multipart/form-data">
  <input type="hidden" name="post_id" value="${dto.post_id}">
  <input type="hidden" name="dfimage" value="${dto.post_image}">
    <input type="hidden" name="dlogin_id" value="${dto.user_id}">
<table border="1" width="60%" align="center">
<caption>${post.user_login_id}님의 삭제 자료를 확인하세요.</caption>

<tr>
  <th>제목</th>
  <td><input type="text" name="post_title" value="${dto.post_title}" readonly></td>
</tr>

<tr>
  <th>작성일자</th>
  <td><input type="text" name="post_date" value="${dto.post_date}" readonly></td>
</tr>

<tr>
  <th>내용</th>
  <td>
    <div id="contentDiv" contenteditable="true">
      ${dto.post_content}
    </div>
    <input type="hidden" name="post_content" id="hiddenContent">
  </td>
</tr>

<tr style="text-align: center;">
  <td colspan="2">
    <input type="button" value="삭제" onclick="confirmDelete('${dto.post_id}')">
    <input type="reset" value="취소" onclick="history.back()">
  </td> 
</tr>
</table>
</form>

<script>
// 삭제 버튼 클릭 시 확인창 띄우기
function confirmDelete(postId) {
    const dfimage = document.querySelector('input[name="dfimage"]').value;
    if (confirm('정말 삭제하시겠습니까?')) {
        window.location.href = 'PostDeleteSave?dnum=' + postId + '&dfimage=' + encodeURIComponent(dfimage);
    }
}
</script>
</body>
</html>
