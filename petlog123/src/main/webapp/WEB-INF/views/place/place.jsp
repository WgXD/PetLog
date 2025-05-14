<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', sans-serif; }
    body { background-color: #fff6f6; padding: 40px; }
    .place-container { max-width: 1000px; margin: auto; background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }

    .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .place-grid { display: flex; flex-wrap: wrap; gap: 20px; }

    .place-card {
      width: 300px;
      background: #fffafc;
      border-radius: 12px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      padding: 16px;
      display: flex;
      flex-direction: column;
      align-items: center;
      cursor: pointer;
      transition: 0.3s;

    }
    .place-card:hover { background: #fff0f5; }

    .place-thumbnail {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 8px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .place-thumbnail:hover {
      transform: scale(1.05);
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    }

    .place-info { width: 100%; text-align: left; margin-top: 10px; }
    .place-info h3 { font-size: 18px; margin-bottom: 5px; }
    .place-info p { font-size: 14px; color: #666; }

    .place-map { width: 100%; height: 200px; margin-top: 10px; border-radius: 8px; display: none; }

    .sort-btn {
      background-color: #ffcce0;
      color: #fff;
      border: none;
      border-radius: 20px;
      padding: 8px 16px;
      font-size: 14px;
      cursor: pointer;
      box-shadow: 0 2px 6px rgba(255, 182, 193, 0.6);
      transition: all 0.2s ease;
    }
    .sort-btn:hover { background-color: #ffb6c1; }
  </style>
  
</head>
<body>
<div class="place-container">
  <div class="header">
    <h2>
      🐶 동반 가능 
      <c:choose>
        <c:when test="${category == 'cafe'}">카페</c:when>
        <c:when test="${category == 'restaurant'}">식당</c:when>
        <c:when test="${category == 'park'}">공원</c:when>
        <c:when test="${category == 'playground'}">놀이터</c:when>
        <c:when test="${category == 'camping'}">캠핑장</c:when>
        <c:when test="${category == 'accommodation'}">숙소</c:when>
        <c:otherwise>핫플레이스</c:otherwise>
      </c:choose>
    </h2>
    <div style="display: flex; gap: 10px;">
      <a href="/pet/place/sort?sort=rate&category=${category }" class="sort-btn">인기순</a>
      <a href="/pet/place/sort?sort=createdat&category=${category }" class="sort-btn">최신순</a>
    </div>
  </div>

  <div class="place-grid">
    <c:forEach var="place" items="${place}">

      <div class="place-card" onclick='showDetailMap("${place.place_id}", ${place.place_latitude}, ${place.place_longitude})'>
        <img class="place-thumbnail" src="${place.thumbnail}" alt="썸네일" />
        <div class="place-info">
          <h3>
            ${place.place_name}
            <%--c:if test="${place.newBadge}"><span style="color:red; font-size:14px;">NEW</span></c:if--%>
          </h3>
          <p>🏠 ${place.place_address}</p>
          <p>☎️ ${place.place_phone}</p>
          <p>
            <c:choose>
              <c:when test="${place.category == 'cafe'}">☕</c:when>
              <c:when test="${place.category == 'restaurant'}">🍽️</c:when>
              <c:when test="${place.category == 'park'}">🌳</c:when>
              <c:when test="${place.category == 'playground'}">🎠</c:when>
              <c:when test="${place.category == 'camping'}">⛺</c:when>
              <c:when test="${place.category == 'accommodation'}">🛏️</c:when>
              <c:otherwise>📍</c:otherwise>
            </c:choose>
            ${place.category}
          </p>
          <p>
  			<c:forEach begin="1" end="${place.rate}" varStatus="loop">
   			 <span style="color: gold;">⭐</span>
  			</c:forEach>
  		<c:forEach begin="${place.rate + 1}" end="5" varStatus="loop">
    		<span style="color: lightgray;">☆</span>
  		</c:forEach>
  		(${place.rate})
		</p>
        </div>
        <div id="map-${place.place_id}" class="place-map"></div>
      </div>
    </c:forEach>
  </div>
</div>

<div id="map-test" style="width:100%; height:300px;"></div>

<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=833cfb526e2103d0ecde06f402b47205"></script>

<script type="text/javascript">

function showDetailMap(placeId, lat, lng) {
  const mapid = "map-" + placeId;
  const mapContainer = document.getElementById(mapid);

  if (mapContainer.style.display === "none") {
    mapContainer.style.display = "block";
    const mapOption = { center: new kakao.maps.LatLng(lat, lng), level: 3 };
    const map = new kakao.maps.Map(mapContainer, mapOption);
    new kakao.maps.Marker({ position: new kakao.maps.LatLng(lat, lng), map: map });
  } else {
    mapContainer.style.display = "none";
  }
}
</script>
</html>