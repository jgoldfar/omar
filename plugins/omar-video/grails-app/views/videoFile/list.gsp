<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main5"/>
  <title>VideoFile List</title>
</head>
<body>
<div class="nav">
  <span class="menuButton">
	<g:link class="home" controller="home">Home</g:link>
  </span>
  <g:ifAllGranted role="ROLE_ADMIN">
    <span class="menuButton"><g:link class="create" action="create">New VideoFile</g:link></span>
  </g:ifAllGranted>
</div>
<div class="body">
  <h1>VideoFile List</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="list">
    <table>
      <thead>
        <tr>

          <g:sortableColumn property="id" title="Id" params="${[videoDataSetId:params.videoDataSetId]}"/>

          <g:sortableColumn property="name" title="Name" params="${[videoDataSetId:params.videoDataSetId]}"/>

          <g:sortableColumn property="type" title="Type" params="${[videoDataSetId:params.videoDataSetId]}"/>

          <th>Video Data Set</th>

        </tr>
      </thead>
      <tbody>
        <g:each in="${videoFileList}" status="i" var="videoFile">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

            <td><g:link action="show" id="${videoFile.id}">${fieldValue(bean: videoFile, field: 'id')}</g:link></td>

            <td>${fieldValue(bean: videoFile, field: 'name')}</td>

            <td>${fieldValue(bean: videoFile, field: 'type')}</td>

            <td>${fieldValue(bean: videoFile, field: 'videoDataSet')}</td>

          </tr>
        </g:each>
      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate total="${videoFileList.totalCount}" params="${[videoDataSetId:params.videoDataSetId]}"/>
  </div>
</div>
</body>
</html>
