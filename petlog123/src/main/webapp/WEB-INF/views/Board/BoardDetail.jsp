<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시물 상세보기</title>
<style>
  body {
    font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
    background-color: #f9f9f9;
    margin: 0;
    padding: 0;
  }
  table {
    width: 60%;
    margin: 50px auto;
    border-collapse: collapse;
    background-color: transparent; /* 배경 제거 */
    border: none;
    box-shadow: none; /* 박스 그림자 제거 */
  }
  caption {
    caption-side: top;
    text-align: center;
    font-size: 1.4em;
    font-weight: bold;
    padding: 20px 10px;
    background-color: transparent; /* 배경 제거 */
    color: #222;
    text-align: left;
  }
  th, td {
    padding: 16px 10px;
    border-bottom: 1px solid #ddd;
    text-align: left;
    background-color: transparent; /* 셀 배경 제거 */
    color: #333;
  }
  th {
    width: 20%;
    font-weight: 600;
    color: #444;
    background-color: transparent;
  }
  td textarea {
    width: 100%;
    height: 150px;
    padding: 10px;
    font-size: 1em;
    resize: none;
    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 4px;
  }
  td img {
    margin-top: 10px;
    border-radius: 4px;
    box-shadow: none; /* 이미지도 그림자 제거 가능 */
    max-width: 100%;
  }
.btn-group {
  width: 60%;
  margin: 20px auto;
  display: flex;
  justify-content: flex-end; /* 오른쪽 정렬 */
  gap: 8px; /* 버튼 간 간격 */
}
.btn-group input[type="button"] {
  padding: 4px 10px;
  font-size: 13px;
  background-color: #666;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.2s;
}
.btn-group input[type="button"]:hover {
  background-color: #444;
}
.btn-group input[value="수정"] {
  background-color: #f8c8dc;  
  color: #fff;
}
.btn-group input[value="수정"]:hover {
  background-color: #f4aac9; 
}
.btn-group input[value="삭제"] {
  background-color: #f8c8dc;
}
.btn-group input[value="삭제"]:hover {
  background-color: #f6a5b4;
}
.btn-group input[value="목록"] {
  background-color: #dcdcdc;
}
.btn-group input[value="목록"]:hover {
  background-color: #aaa;
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
<form action="PostDetail" method="post" enctype="multipart/form-data">
<input type="hidden" name="mnum" value="${dto.post_id}" readonly>
<div class="table-wrapper">
<table>
<caption>${dto.user_login_id}님의 게시물</caption>
  <tr>
  <td colspan="2" style="text-align: right; padding: 5px 10px;">
    <span style="font-size: 15px; color: #8B8386;">👁 ${dto.post_readcnt}</span>
  </td>     
  </tr>
    <tr>
      <th>제목</th>
      <td><input type="text" name="post_title" value="${dto.post_title}" style="width:100%; padding:8px;" readonly></td>
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
  <td colspan="2" class="btn-group">
    <input type="button" value="목록" onclick="location.href='BoardView'">
 <c:choose>
  <c:when test="${fn:trim(dto.post_type) == 'notice' and fn:trim(sessionScope.user_role) == 'admin'}">
    <input type="button" value="수정" onclick="location.href='PostModify?mnum=${dto.post_id}'">
    <input type="button" value="삭제" onclick="confirmDelete('${dto.post_id}')">
  </c:when>
</c:choose>
  </td>
</tr>
</table>
</div>
</form>
<script>
<!-- form 전송할 때 div 내용 복사해서 숨은 input에 넣기 -->
function beforeSubmit() {
    document.getElementById('hiddenContent').value = document.getElementById('contentDiv').innerHTML;
}
</script>

<script>
function confirmDelete(postId) {
  if (confirm("정말 삭제하시겠습니까?")) {
    window.location.href = 'PostDelete?dnum=' + postId;
  }
}
</script>
</body>
</html>