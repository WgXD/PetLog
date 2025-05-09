<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><tiles:getAsString name="title"/></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>

<!-- top 영역 -->
<tiles:insertAttribute name="top" />

<!-- body 영역 -->
<tiles:insertAttribute name="body" />

<!-- footer 영역 -->
<tiles:insertAttribute name="footer" />

</body>
</html>