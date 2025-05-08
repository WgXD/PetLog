<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이템 구매</title>

<!-- jQuery CDN (Ajax용) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
  body {
    font-family: 'Arial', sans-serif;
    background-color: #fff8f0;
    text-align: center;
    padding: 30px;
  }
  h2 {
    color: #5e478e;
  }
  .dotted-rounded-table {
    border-collapse: separate;
    border: 2px dotted #aaa;
    border-radius: 16px;
    overflow: hidden;
    background-color: #fff;
    margin: 0 auto;
    box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
  }
  .dotted-rounded-table td,
  .dotted-rounded-table th {
    border: 1px dotted #ccc;
    padding: 12px 16px;
    font-size: 14px;
  }
  button {
    background-color: #d7c9f3;
    border: none;
    color: #5e478e;
    padding: 10px 22px;
    margin: 12px 6px;
    border-radius: 24px;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.15s ease;
    box-shadow: 2px 2px 5px rgba(100, 80, 160, 0.2);
  }
  button:hover {
    background-color: #e8defc;
    transform: scale(1.05);
  }
  button:active {
    transform: scale(0.95);
  }
</style>

<script type="text/javascript">
function buyItem(itemId) {
  $.ajax({
    type: "POST",
    url: "${pageContext.request.contextPath}/items/buy_items",
    data: { item_id: itemId },
    success: function(response) {
      response = response.trim();// 공백 제거

      if (response === "already_owned") {
        alert("이미 보유한 아이템입니다.");
      } else if (response === "success") {
        alert("구매 성공!");
        location.reload(); // 새로고침
      } else {
        alert("예상치 못한 응답: " + response);
      }
    },
    error: function() {
      alert("요청 실패 ㅠㅠ");
    }
  });
}
</script>


</head>

<body>
<header></header>

<table class="dotted-rounded-table">
  <tr>
    <th>No.</th> <th>아이템명</th> <th>포도알</th> <th>카테고리</th> <th>아이템</th>
  </tr>

  <tr>
    <td>${dto.item_id}</td>
    <td>${dto.item_name}</td>
    <td>${dto.item_cost}</td>
    <td>${dto.item_category}</td>
    <td><img src="./image/${dto.item_image}" width="100px"></td>
  </tr>

  <tr>
    <td colspan="5" style="text-align: center">
      <button type="button" onclick="buyItem(${dto.item_id})">구매하기</button>
      <button type="button" onclick="history.back()">취소하기</button>
    </td>
  </tr>
</table>

</body>
</html>
