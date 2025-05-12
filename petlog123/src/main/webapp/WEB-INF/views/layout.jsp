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

<div class="wrapper">  <%-- 전체 감싸는 래퍼 --%>

    <div class="content" style="margin-top: 30px;">  <%-- top + body --%>
        <tiles:insertAttribute name="top" />
        <tiles:insertAttribute name="body" />
    </div>

    <footer class="footer">
        <tiles:insertAttribute name="footer" />
    </footer>

</div>

</body>
</html>