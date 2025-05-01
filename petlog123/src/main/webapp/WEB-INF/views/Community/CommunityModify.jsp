<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
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
</style>
</head>
<body>
<form action="PostModifySave" method="post" enctype="multipart/form-data" onsubmit="return beforeSubmit()">
  <!-- 글 번호 hidden -->
  <input type="hidden" name="mnum" value="${dto.post_id}">
  <input type="hidden" name="himage" value="${dto.post_image}">
  <input type="hidden" name="mid" value="${dto.user_id}">
<table>
<caption>${dto.user_login_id}님의 수정 자료를 확인하세요.</caption>
<tr>
  <th>제목</th>
  <td><input type="text" name="post_title" value="${dto.post_title}" required style="width:95%;"></td>
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

<tr>
  <th>사진</th>
  <td>
    <c:if test="${dto.post_image ne null and not empty dto.post_image and dto.post_image ne 'noimage.png'}">
      <img src="./image/${dto.post_image}" width="200px" height="200px"><br>
    </c:if>
    <input type="file" id="post_image" name="post_image" accept="image/*" onchange="insertImage()" multiple>
  </td>
</tr>

<tr>
  <td colspan="2" style="text-align:center;">
    <input type="submit" value="수정">
    <input type="reset" value="취소" onclick="history.back()">
  </td> 
</tr>
</table>
</form>
<script>
// 폼 전송 전에 div 내용을 hidden input에 복사
function beforeSubmit() {
    document.getElementById('hiddenContent').value = document.getElementById('contentDiv').innerHTML;
    return true;
}
// 파일 선택 시 이미지 삽입
function insertImage() {
    const files = document.getElementById('post_image').files;
    const contentDiv = document.getElementById('contentDiv');
    for (let i = 0; i < files.length; i++) {
        if (files[i].name) { // 파일이 있으면
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