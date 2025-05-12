<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<style>
  body {
    background-color: #fefefe;
    margin: 0;
    padding: 0;
    color: #333;
    text-align: center;
  }
  
  .table-wrapper {
  width: 90%;
  max-width: 1000px;
  margin: 40px auto;
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
    max-width: 70px;
    height: auto;
  }

  td a {
    color: #333;
    text-decoration: none;
    font-weight: 500;
  }

  td a:hover {
    color: #db7093;
    text-decoration: underline;
  }

  .btn {
    margin-top: 30px;
    background-color: #ffe1e1;
    color: #444;
    border: none;
    padding: 10px 24px;
    border-radius: 24px;
    font-weight: bold;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
  }

  .btn:hover {
    background-color: #ffd2d2;
  }

  .pagination {
    margin-top: 30px;
    text-align: center;
  }

  .pagination a {
    display: inline-block;
    margin: 0 5px;
    padding: 8px 14px;
    background-color: #f2e9ff;
    color: #5e478e;
    border-radius: 10px;
    text-decoration: none;
    font-weight: bold;
    transition: background-color 0.2s;
  }

  .pagination a:hover {
    background-color: #e0d2f7;
  }

  .pagination a.current {
    background-color: #d7c9f3;
    color: white;
  }

  .no-diary {
    color: #c0392b;
    font-weight: bold;
    padding: 20px 0;
  }

</style>
<meta charset="UTF-8">
<title></title>
</head>
<body>

<div class="table-wrapper">
  <header><h2>🗓 내 일정</h2></header>

  <div style="margin-bottom: 20px;">
    <input type="reset" value="⬅ 뒤로가기" onclick="history.back()" 
           style="background-color: #f8d7da; color: #a94442; border: 1px solid #f5c6cb;
                  padding: 6px 14px; font-size: 13px; border-radius: 16px;
                  font-weight: bold; cursor: pointer;">
  </div>

  <table class="dotted-rounded-table">
    <tr>
      <th>반려동물 이름</th> <th>제목</th> <th>날짜</th> <th>내용</th> <th>수정</th> <th>삭제</th>
    </tr>
    <tr>
      <td>${cdto.pet_name}</td>
      <td>${cdto.cal_title}</td>
      <td>${cdto.cal_date.substring(0, 10)}</td>
      <td>${cdto.cal_content}</td>
      <td><a href="calendar_update?cal_id=${cdto.cal_id}&year=${current_year}&month=${current_month}&pet_id=${cdto.pet_id}">✏️</a></td>
      <td><a href="calendar_delete?cal_id=${cdto.cal_id}&year=${current_year}&month=${current_month}&pet_id=${cdto.pet_id}"
             onclick="return confirm('일정을 삭제합니다 😥');">🗑️</a></td>
    </tr>
  </table>
</div>

</body>
</html>
