<%--
  Created by IntelliJ IDEA.
  User: sbortman
  Date: 1/30/12
  Time: 10:16 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title><g:layoutTitle default="Grails"/></title>
  <piwik:trackPageview />
  <g:layoutHead/>
</head>

<body class="${pageProperty(name: 'body.class')}" onload="${pageProperty(name: 'body.onload')}">

<div id="top1">
  <omar:securityClassificationBanner/>
  <g:pageProperty name="page.top"/>
</div>

<div id="center1">
    <g:pageProperty name="page.center"/>
</div>

<div id="bottom1">
  <omar:securityClassificationBanner/>
  <g:pageProperty name="page.bottom"/>
</div>

<%--
<div id="left1">
  <g:pageProperty name="page.left"/>
</div>

<div id="right1">
  <g:pageProperty name="page.right"/>
</div>
--%>


<g:layoutBody/>
</body>
</html>
