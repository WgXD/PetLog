<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>아이템 구매</title>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
  body {
    font-family: "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
    background-color: #fefefe;
    margin: 0;
    padding: 0;
    color: #333;
    text-align: center;
  }

  .table-wrapper {
    width: 90%;
    max-width: 800px;
    margin: 40px auto 80px auto;
    background-color: #fff;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    padding: 30px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
  }

  caption {
    font-size: 1.8em;
    font-weight: bold;
    color: #db7093;
    margin-bottom: 20px;
  }

  th, td {
    padding: 14px 12px;
    font-size: 1em;
    border-bottom: 1px solid #eee;
    text-align: center;
  }

  th {
    background-color: #fff0f4;
    color: #555;
    font-weight: 600;
  }

  td img {
    max-width: 100px;
    height: auto;
  }

  .btn {
    background-color: #ffe1e1;
    color: #444;
    border: none;
    padding: 10px 22px;
    margin: 12px 6px;
    border-radius: 24px;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.15s ease;
    box-shadow: 2px 2px 5px rgba(100, 80, 160, 0.1);
  }

  .btn:hover {
    background-color: #ffd2d2;
    transform: scale(1.05);
  }

  .btn:active {
    transform: scale(0.95);
  }
</style>

<script>
function buyItem(itemId) {
  $.ajax({
    type: "POST",
    url: "${pageContext.request.contextPath}/items/buy_items",
    data: { item_id: itemId },
    success: function(response) {
      response = response.trim();

      if (response === "already_owned") {
        alert("이미 보유한 아이템입니다.");
      } else if (response === "not_enough_grapes") {
        alert("포도알이 부족합니다!");
      } else if (response === "success") {
        alert("구매 성공!");
        location.reload();
      } else {
        alert("예상치 못한 응답: " + response);
      }
    },
    error: function() {
      alert("요청 실패");
    }
  });
}
</script>

</head>
<body>

<div class="table-wrapper">
  <caption>🎁 아이템 구매</caption>

  <table>
    <tr>
      <th>No.</th>
      <th>아이템명</th>
      <th>포도알</th>
      <th>카테고리</th>
      <th>아이템</th>
    </tr>
    <tr>
      <td>${dto.item_id}</td>
      <td>${dto.item_name}</td>
      <td>${dto.item_cost}</td>
      <td>${dto.item_category}</td>
      <td><img src="./image/${dto.item_image}" alt="아이템 이미지"></td>
    </tr>
    <tr>
      <td colspan="5" style="text-align: center; border-bottom: none;">
        <button type="button" class="btn" onclick="buyItem(${dto.item_id})">💰 구매하기</button>
        <button type="button" class="btn" onclick="history.back()">❌ 취소하기</button>
      </td>
    </tr>
  </table>
</div>

</body>
</html>