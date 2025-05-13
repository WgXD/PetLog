<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시물 상세보기</title>
<style>
  body {
    font-family: "Pretendard", sans-serif;
    background-color: #fff6f6;
    margin: 0;
    padding: 0;
    color: #333;
  }
  .table-wrapper {
    background-color: white;
    width: 100%;
    max-width: 1000px;
    margin: 40px auto 80px auto;
    border-radius: 12px;
    box-shadow: none;
    padding: 30px;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
    background-color: #fff;
    border-radius: 8px;
    overflow: hidden;
  }
  caption {
    caption-side: top;
    text-align: center;
    font-size: 1.6em;
    font-weight: normal;
    color: #f48aa5;
    margin-bottom: 20px;
  }
  th, td {
    padding: 14px 12px;
    font-size: 1em;
    border-bottom: none;
    text-align: center;
  }
  th {
    background-color: #fff0f4;
    color: #555;
    font-weight: bold;
  }
  td img {
    max-width: 70px;
    height: auto;
  }
  #contentDiv {
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
    min-height: 150px;
    background-color: #fff;
    text-align: left;
  }

  /* 버튼 공통 스타일 */
  .btn-section {
    text-align: right;
    margin-top: 30px;
  }

  .btn-section button,
  .btn-section input[type="button"] {
    padding: 8px 16px;
    font-size: 14px;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    margin-left: 8px;
    transition: background-color 0.3s;
  }

  .btn-section .btn-back {
    background-color: #ffe1e1;
    color: #333;
  }

  .btn-section .btn-back:hover {
    background-color: #ffd2d2;
  }

  .btn-section .btn-edit {
    background-color: #f8c8dc;
    color: #fff;
  }

  .btn-section .btn-edit:hover {
    background-color: #f4aac9;
  }

  .btn-section .btn-delete {
    background-color: #f8c8dc;
    color: #333;
  }

  .btn-section .btn-delete:hover {
    background-color: #f6a5b4;
  }
</style>
</head>
<body>

<form action="PostDetail" method="post" enctype="multipart/form-data">
<input type="hidden" name="mnum" value="${dto.post_id}" readonly>
<div class="table-wrapper">

  <h2 style="color: #f48aa5; text-align: center;">${dto.user_login_id}님의 게시물</h2>

  <table>
    <tr>
      <td colspan="2" style="text-align: right; padding: 5px 10px; border-bottom: none;">
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
	    <div style="white-space: pre-line;">
	      ${dto.post_content}
	    </div>
	  </td>
	</tr>
	  </table>

  <!-- 버튼 영역 -->
  <div class="btn-section">
    <button type="button" class="btn-back" onclick="location.href='NoticeBoard'">목록으로 돌아가기</button>

    <c:if test="${fn:trim(dto.post_type) == 'notice' and fn:trim(sessionScope.user_role) == 'admin'}">
      <input type="button" value="수정" onclick="location.href='PostModify?mnum=${dto.post_id}'" class="btn-edit">
      <input type="button" value="삭제" onclick="confirmDelete('${dto.post_id}')" class="btn-delete">
    </c:if>
  </div>

</div>
</form>

<script>
function beforeSubmit() {
    document.getElementById('hiddenContent').value = document.getElementById('contentDiv').innerHTML;
}
function confirmDelete(postId) {
  if (confirm("정말 삭제하시겠습니까?")) {
    window.location.href = 'PostDelete?dnum=' + postId;
  }
}
</script>
</body>
</html>
