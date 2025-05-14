<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<style>
  body {
    background-color: #fff6f6;
    margin: 0;
    padding: 0;
    font-family: 'Pretendard', sans-serif;
    color: #333;
  }

  .table-wrapper {
    background-color: white;
    width: 100%;
    max-width: 1000px;
    margin: 40px auto 0 auto;
    border-radius: 12px;
    box-shadow: none;
    padding: 30px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
    background-color: #fff;
    box-shadow: none;
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
    border-bottom: 1px solid #eee;
  }

  table tr:last-child td {
    border-bottom: none;
  }

  th {
    width: 17%;
    background-color: #fff0f4;
    color: #555;
    font-weight: bold;
    text-align: center;
  }

  td img {
    max-width: 70px;
    height: auto;
  }

  .btn-group {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 10px;
  }

  .btn-group input[type="button"] {
    background-color: #ffe1e1;
    color: #333;
    border: none;
    padding: 8px 20px;
    border-radius: 10px;
    font-weight: normal;
    cursor: pointer;
    transition: background-color 0.3s;
  }

  .btn-group input[type="button"]:hover {
    background-color: #ffd2d2;
  }

  .profile-img {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    object-fit: cover;
    vertical-align: middle;
    margin-right: 6px;
  }

  .reply-btn {
    font-size: 14px;
    padding: 2px 10px;
    background-color: #f8c8dc;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.2s;
    position: absolute;
    top: 15px;
    right: 10px;
  }

  .reply-btn:hover {
    background-color: #f4aac9;
  }

  .comment-box {
    margin-top: 5px;
    background-color: #fff;
    border-radius: 12px;
    padding: 30px;
    box-shadow: none;
  }

  .comment-form textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 8px;
    resize: none;
    font-size: 14px;
  }

  .comment-form button {
    margin-top: 10px;
    background-color: #ffe1e1;
    color: #333;
    border: none;
    border-radius: 10px;
    padding: 8px 16px;
    cursor: pointer;
  }

  .comment-form {
    text-align: right;
  }
</style>
</head>
<body>
<div class="table-wrapper">
<table>
<caption>
  <img src="${pageContext.request.contextPath}/image/${profileimg}" class="profile-img" />
  ${dto.user_login_id}님의 간식 레시피 🦴
</caption>

<tr>
  <td colspan="2" style="text-align: right; padding: 5px 10px; border-bottom: none;">
    <span style="font-size: 15px; color: #8B8386;">👁 ${dto.snack_readcnt}</span>
    <span style="font-size: 15px; color: #e74c3c;">❤️ ${likeCount}</span>
    &nbsp;&nbsp;
    <span style="font-size: 15px; color: #8B8386;">💬 ${fn:length(comments)}</span>
  </td>     
</tr>
<tr>
  <td colspan="2" style="height: 1px; border-bottom: 1px solid #eee;"></td>
</tr>
<tr>
  <th>레시피명</th>
  <td>${dto.snack_title}</td>
</tr>
<tr>
  <th>레시피 내용</th>
	  <td>
	    <div style="white-space: pre-line;">
	      ${dto.snack_recipe}
	    </div>
	  </td>
</tr>
<tr>
  <th>이미지</th>
  <td><img src="./image/${dto.snack_image}" width="300px"/></td>
</tr>
<tr>
  <th>작성자</th>
  <td>${dto.user_login_id}</td>
</tr>
<tr>
  <th>게시일</th>
  <td>${dto.snack_date.substring(0, 10)}</td>
</tr>

<!-- 목록 버튼 -->
<tr>
  <td colspan="2" style="border-bottom: none;">
    <div class="btn-group" style="margin-bottom: 6px;">
      <input type="button" value="목록" onclick="location.href='snack_out'">
      <c:if test="${sessionScope.user_id == dto.user_id or sessionScope.user_role == 'admin'}">
        <input type="button" value="수정" onclick="location.href='snack_update?update=${dto.snack_id}&dfimage=${dto.snack_image}'">
        <input type="button" value="삭제" onclick="confirmDelete('${dto.snack_id}')">
      </c:if>
    </div>
  </td>
</tr>

<!-- 좋아요 버튼 -->
<tr>
  <td colspan="2" style="text-align: center; padding: 5px 0 0 0;">
    <form action="like_s" method="post" style="display: inline;">
      <input type="hidden" name="snack_id" value="${dto.snack_id}">
      <c:choose>
        <c:when test="${userLiked}">
          <button type="submit" style="color:red; font-size: 20px; border: none; background: none;">❤️ (${likeCount})</button>
        </c:when>
        <c:otherwise>
          <button type="submit" style="font-size: 20px; border: none; background: none;">🤍 (${likeCount})</button>
        </c:otherwise>
      </c:choose>
    </form>
  </td>
</tr>
</table>

<!-- 댓글 박스는 반드시 테이블 밖에 -->
<div class="comment-box">
  <div style="font-size: 20px; font-weight: bold; margin-bottom: 10px; text-align: left;">
    <span style="font-size: 22px; margin-right: 5px;">💬</span>댓글
  </div>

  <!-- 댓글 작성 -->
  <div class="comment-form">
    <form action="comment_insert" method="post">
      <input type="hidden" name="snack_id" value="${dto.snack_id}">
      <textarea name="com_com" rows="3" placeholder="댓글을 입력하세요" required></textarea>
      <button type="submit">댓글 작성</button>
    </form>
  </div>

  <!-- 댓글 목록 -->
  <c:forEach items="${comments}" var="com">
    <c:set var="margin" value="${com.depth * 20}" />
    <div style="margin: 20px 0 0 calc(${margin}px); border-bottom: 1px solid #eee; padding: 10px 0; position: relative;">
      <div style="font-weight: bold; margin-bottom: 5px;">
        <img src="${pageContext.request.contextPath}/image/${profileimg}" class="profile-img" />
        ${com.user_login_id}
      </div>
      <div style="margin-bottom: 10px;">💬 ${com.com_com}</div>

      <!-- 대댓글 버튼 -->
      <button type="button" class="reply-btn" onclick="toggleReplyForm(${com.com_id})">답글</button>

      <!-- 대댓글 입력 -->
      <div id="replyForm${com.com_id}" style="display: none; margin-top: 10px;">
        <form action="comment_insert" method="post">
          <input type="hidden" name="snack_id" value="${dto.snack_id}">
          <input type="hidden" name="parent_id" value="${com.com_id}">
          <input type="hidden" name="depth" value="${com.depth + 1}">
          <textarea name="com_com" rows="2" placeholder="답글을 입력하세요" required style="width: 100%; padding: 8px; border-radius: 6px;"></textarea>
          <button type="submit" style="margin-top: 5px; padding: 6px 12px; background-color: #e0e0e0; border: 1px solid #bbb; border-radius: 4px; font-size: 13px;">작성</button>
        </form>
      </div>
    </div>
  </c:forEach>
</div>
</div>

<script>
  function confirmDelete(snackId) {
    if (confirm("정말 삭제하시겠습니까?")) {
      window.location.href = 'snack_delete?delete=' + snackId + '&dfimage=${dto.snack_image}';
    }
  }

  function toggleReplyForm(id) {
    const form = document.getElementById('replyForm' + id);
    form.style.display = (form.style.display === 'none') ? 'block' : 'none';
  }
</script>
</body>
</html>