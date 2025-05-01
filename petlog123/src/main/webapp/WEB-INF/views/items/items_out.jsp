<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>

<style type="text/css">

body {
  font-family: Arial, sans-serif;
  background: #f0f8ff; /* 아주 연한 하늘색 */
  text-align: center;
  padding: 30px;
}

h2 {
  color: #4a6fa5; /* 차분한 블루 */
}

form {
  display: inline-block;
  text-align: left;
}

.dotted-rounded-table {
  border: 2px dotted #8ab6d6;
  border-radius: 16px;
  background: #ffffff;
  margin: auto;
  box-shadow: 2px 2px 10px rgba(0,0,0,0.05);
  border-collapse: separate;
  overflow: hidden;
}

.dotted-rounded-table th,
.dotted-rounded-table td {
  border: 1px dotted #bcdff1;
  padding: 12px 16px;
  font-size: 14px;
}

input[type="text"],
input[type="number"],
input[type="file"],
textarea {
  width: 100%;
  padding: 5px;
  border: 1px solid #cce6f7;
  border-radius: 6px;
  box-sizing: border-box;
  background-color: #f6fbff;
  margin-bottom: 12px;
}

textarea {
  resize: vertical;
}

button,
input[type="submit"],
input[type="reset"] {
  background: #a8d0f0;     /* 파스텔 블루 */
  color: #2e5c8a;           /* 진한 블루 텍스트 */
  border: none;
  border-radius: 24px;
  padding: 10px 22px;
  margin: 12px 6px;
  font-size: 15px;
  font-weight: bold;
  cursor: pointer;
  transition: 0.3s ease;
  box-shadow: 2px 2px 5px rgba(50, 100, 160, 0.2);
}

button:hover,
input[type="submit"]:hover,
input[type="reset"]:hover {
  background: #d3ebff;     /* 더 연한 블루 */
  transform: scale(1.05);
}

button:active,
input[type="submit"]:active,
input[type="reset"]:active {
  transform: scale(0.95);
}
</style>


<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<header><h1>🎁 Item SHOP 🎁</h1></header>

<table class="dotted-rounded-table">
<tr>
	<th>No.</th> <th>아이템명</th> <th>포도알</th> <th>카테고리</th> <th>아이템</th> <th>아이템 구매</th>
</tr>

<c:forEach items="${list}" var="it" >

<tr>
<td> ${it.item_id} </td>
<td> ${it.item_name} </td>
<td> ${it.item_cost} </td>
<td> ${it.item_category} </td>
<td><img src="./image/${it.item_image}" width="150px"></td>
<td><a href="items_detail?num=${it.item_id }">🛒</a> </td>
</tr>

</c:forEach>
</table>

<!-- 페이징 숫자 출력 1 2 3... -->
<br><br>
<div class="pagination">
  <c:forEach var="i" begin="1" end="${page_count}">
    <a href="items_out?page=${i}" 
       class="${i == page ? 'current' : ''}">
       ${i}
    </a>
  </c:forEach>
</div>
      
</body>
</html>