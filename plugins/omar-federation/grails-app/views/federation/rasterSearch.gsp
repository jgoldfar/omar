<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <r:require modules = "federationRasterSearch"/>
    <title>OMAR <g:meta name="app.version"/>: Federated Search</title>
    <r:layoutResources/>
</head>
<body>
    <div class="outer-center" id="rasterSearchPageId">

        <div class="ui-layout-north">
            <omar:securityClassificationBanner/>
            <g:render plugin="omar-common-ui" template="/templates/federatedSearchMenu"/>
        </div>

        <div class="middle-center">

            <div class="inner-west">
                <p><center>Show Coordinates in <g:select name="displayUnit" from="${['DD', 'DMS', 'MGRS']}"/></center></p>

                <p><g:render plugin="omar-common-ui" template="/templates/boundBoxTemplate"/></p>

                <p><g:render plugin="omar-common-ui" template="/templates/pointRadiusTemplate"/></p>

                <p><g:render plugin="omar-common-ui" template="/templates/dateTimeTemplate"/></p>

                <center><button name="SearchRasterId" id="SearchRasterId">Search OMAR™</button></center>
            </div>

            <div class="inner-center">
                <g:render plugin="omar-federation" template="/templates/searchTabView"/>
            </div>

            <div class="ui-layout-south">
                <div id="omarServerCollectionId"></div>
            </div>
        </div>


        <div class="ui-layout-south">
            <omar:securityClassificationBanner/></div>
        </div>

<script>
    //  OpenLayers.ImgPath = "${resource(plugin:'openlayers', dir:'js/img')}/";
    // alert("${resource(plugin:'openlayers', dir:'js/theme/default')}/");

</script>
<r:layoutResources/>
<script type="text/html" id="omar-server-template">
    <div class="omar-server-container" id="${'<%=id%>'}">
        <div class="omar-server-info">
            <div id="omar-server-count-container">
                <div id="omar-server-enabled"><input id="omar-server-enabled-checkbox" type="checkbox" checked=${'<%=enabled%>'}></input></div>
                <div id="omar-server-count" class="omar-server-count">${'<%=count%>'}</div>
            </div>
            <img style="padding-top:24px" src="${resource(dir:'images', file:'server.gif')}"/>
        </div>
        <a href="${'<%=url%>'}" id="omar-server-url">${'<%=name%>'}</a>
    </div>
</script>

<script type="text/javascript">
    function init(){
        var wmsConfig = ${wmsBaseLayers}
            // application specific initialize that will need access to grails models
            //
                OpenLayers.ImgPath = "${resource(plugin:'openlayers', dir:'js/img')}/";
        var params = {
            map:{theme:"${resource(plugin:'openlayers', dir:'js/theme/default', file:'style.css')}",
                baseLayers:wmsConfig.base.layers
            }
        };
        var searchPageController = new OMAR.pages.FederatedRasterSearch(jQuery, params);
        searchPageController.render();
        $( "#tabView" ).tabs(
            {
                "show": $.proxy(searchPageController.showTab, searchPageController)
            });

    }
</script>

</body>
</html>