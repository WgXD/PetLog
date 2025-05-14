<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <style>
    body {
      background-color: #fff6f6;
      margin: 0;
      padding: 0;
      color: #333;
    }

    .container {
      max-width: 1000px;
      margin: 40px auto 100px auto;
      background: #fff;
      padding: 60px 80px;
      border-radius: 16px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    }

    h2 {
      text-align: center;
      font-size: 26px;
      color: #f48aa5;
      font-weight: normal;
      margin-top: 0;
      margin-bottom: 30px;
    }

    .form-group {
      display: flex;
      align-items: center;
      margin-bottom: 20px;
    }

    .form-group label {
      flex: 0 0 140px;
      font-weight: bold;
      font-size: 15px;
      color: #555;
    }

    .form-group input[type="text"],
    .form-group input[type="number"],
    .form-group input[type="file"],
    .form-group select {
      flex: 1;
      padding: 12px 16px;
      font-size: 15px;
      border: 1px solid #ddd;
      border-radius: 8px;
      background-color: #fffdfd;
      font-family: 'Pretendard', sans-serif;
      transition: all 0.2s ease-in-out;
      box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.05);
    }

    .form-group input:focus,
    .form-group select:focus {
      border-color: #f48aa5;
      box-shadow: 0 0 0 3px rgba(244, 138, 165, 0.2);
      outline: none;
    }

    .radio-group {
      display: flex;
      gap: 20px;
      align-items: center;
    }

    .radio-group label {
      font-weight: normal;
      font-size: 14px;
    }

    .form-actions {
      text-align: center;
      margin-top: 40px;
    }

    input[type="submit"],
    input[type="reset"] {
      background-color: #f48aa5;
      color: white;
      border: none;
      padding: 12px 30px;
      border-radius: 10px;
      font-size: 15px;
      font-weight: normal;
      margin: 0 10px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover,
    input[type="reset"]:hover {
      background-color: #db7093;
    }

    @media screen and (max-width: 768px) {
      .form-group {
        flex-direction: column;
        align-items: flex-start;
      }

      .form-group label {
        margin-bottom: 8px;
      }

      .container {
        padding: 40px 24px;
      }
    }
  </style>
</head>
<body>

<%
  String role = (String) session.getAttribute("user_role");
  if (role == null || !role.equals("admin")) {
%>
<script>
  alert("관리자만 접근 가능합니다.");
  history.back();
</script>
<%
  return;
}
%>

<div class="container">
  <h2 style="color: #f48aa5">🎈 아이템 수정하기</h2>

  <form action="modify_save" method="post" enctype="multipart/form-data" onsubmit="return confirm('정말 수정하시겠습니까? 😊')">
  <input type="hidden" name="himage" value="${dto.item_image}">
  
    <div class="form-group">
      <label for="item_id">No.</label>
      <input type="text" id="item_id" name="item_id" value="${dto.item_id}" readonly>
    </div>

    <div class="form-group">
      <label for="item_name">아이템명</label>
      <input type="text" id="item_name" name="item_name" value="${dto.item_name}" required>
    </div>

    <div class="form-group">
      <label for="item_cost">포도알</label>
      <input type="number" id="item_cost" name="item_cost" value="${dto.item_cost}" required>
    </div>

	<div class="form-group">
	  <label>카테고리</label>
	  <div class="radio-group">
		<label>
		  <input type="radio" name="item_category" value="프레임"
		    <c:if test="${dto.item_category eq '프레임'}">checked</c:if> required> 프레임
		</label>
		<label>
		  <input type="radio" name="item_category" value="스티커"
		    <c:if test="${dto.item_category eq '스티커'}">checked</c:if> required> 스티커
		</label>
	  </div>
	</div>

    <div class="form-group">
      <label for="item_image">아이템 이미지</label>
      <img src="${pageContext.request.contextPath}/image/${dto.item_image}" width="100px"  style="margin-right: 12px;"><br>
      <input type="file" id="item_image" name="item_image">
    </div>

    <div class="form-actions">
      <input type="submit" value="💾 저장하기">
      <input type="reset" value="❌ 취소하기" onclick="history.back()">
    </div>

  </form>
</div>

</body>
</html>