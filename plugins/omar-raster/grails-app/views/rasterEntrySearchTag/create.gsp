
<%@ page import="org.ossim.omar.RasterEntrySearchTag" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'rasterEntrySearchTag.label', default: 'RasterEntrySearchTag')}" />
        <title>Create RasterEntrySearchTag</title>
    </head>
    <body>
    <content tag="content">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">OMAR Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">List Search Tags</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${rasterEntrySearchTagInstance}">
            <div class="errors">
                <g:renderErrors bean="${rasterEntrySearchTagInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="rasterEntrySearchTag.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: rasterEntrySearchTagInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${rasterEntrySearchTagInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="rasterEntrySearchTag.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: rasterEntrySearchTagInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${rasterEntrySearchTagInstance?.description}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
      </content>
    </body>
</html>
