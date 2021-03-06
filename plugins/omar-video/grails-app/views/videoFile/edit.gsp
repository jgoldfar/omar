<%@ page import="org.ossim.omar.video.VideoDataSet; org.ossim.omar.video.VideoDataSet" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="generatedViews"/>
  <title>OMAR: Edit Video File ${fieldValue(bean: videoFile, field: 'id')}</title>
</head>
<body>
<content tag="content">
  <div class="nav">
      <ul>
          <li class="menuButton"><g:link class="home" uri="/">OMAR™ Home</g:link></li>
          <li class="menuButton"><g:link class="list" action="list">Video File List</g:link></li>
          <li class="menuButton"><g:link class="create" action="create">Create Video File</g:link></li>
      </ul>
  </div>
  <div class="body">
    <h1>OMAR: Edit Video File ${fieldValue(bean: videoFile, field: 'id')}</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${videoFile}">
      <div class="errors">
        <g:renderErrors bean="${videoFile}" as="list"/>
      </div>
    </g:hasErrors>
    <g:form method="post">
      <input type="hidden" name="id" value="${videoFile?.id}"/>
      <div class="dialog">
        <table>
          <tbody>
          <tr class="prop">
            <td valign="top" class="name">
              <label for="name">Name:</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: videoFile, field: 'name', 'errors')}">
              <input type="text" id="name" name="name" value="${fieldValue(bean: videoFile, field: 'name')}"/>
            </td>
          </tr>
          <tr class="prop">
            <td valign="top" class="name">
              <label for="type">Type:</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: videoFile, field: 'type', 'errors')}">
              <input type="text" id="type" name="type" value="${fieldValue(bean: videoFile, field: 'type')}"/>
            </td>
          </tr>
          <tr class="prop">
            <td valign="top" class="name">
              <label for="videoDataSet">Video Data Set:</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: videoFile, field: 'videoDataSet', 'errors')}">
              <g:select optionKey="id" from="${org.ossim.omar.video.VideoDataSet.list()}" name="videoDataSet.id" value="${videoFile?.videoDataSet?.id}"></g:select>
            </td>
          </tr>
          </tbody>
        </table>
      </div>
      <div class="buttons">
        <span class="button"><g:actionSubmit class="save" value="Update"/></span>
        <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete"/></span>
      </div>
    </g:form>
  </div>
</content>
</body>
</html>