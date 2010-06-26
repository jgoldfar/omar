<%--
  Created by IntelliJ IDEA.
  User: sbortman
  Date: Jun 25, 2010
  Time: 8:21:58 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>CSTARS Footprint Viewer</title>
  <meta name="layout" content="main"/>
  <link rel="stylesheet" href="style.css" type="text/css"/>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}"/>

  <style type="text/css">
  input, select, textarea {
    font: 0.9em Verdana, Arial, sans-serif;
  }

  #leftcol {
    position: absolute;
    top: 0;
    left: 1em;
    padding: 0;
    width: 517px;
  }

  #map {
    width: 512px;
    height: 225px;
    border: 1px solid #ccc;
  }

  #input {
    width: 512px;
  }

  #text {
    font-size: 0.85em;
    margin: 1em 0 1em 0;
    width: 100%;
    height: 10em;
  }

  #info {
    position: relative;
    padding: 2em 0;
    margin-left: 540px;
  }

  #output {
    font-size: 0.8em;
    width: 100%;
    height: 512px;
    border: 0;
  }

  p {
    margin: 0;
    padding: 0.75em 0 0.75em 0;
  }
  </style>

  <%--
  <script src="../lib/Firebug/firebug.js"></script>
  --%>

  <openlayers:loadTheme/>
  <openlayers:loadJavascript/>

  <script type="text/javascript">
    var map, vectors, formats;
    function updateFormats()
    {
      var in_options = {
        'internalProjection': map.baseLayer.projection,
        'externalProjection': new OpenLayers.Projection( OpenLayers.Util.getElement( "inproj" ).value )
      };
      var out_options = {
        'internalProjection': map.baseLayer.projection,
        'externalProjection': new OpenLayers.Projection( OpenLayers.Util.getElement( "outproj" ).value )
      };
      var gmlOptions = {
        featureType: "feature",
        featureNS: "http://example.com/feature"
      };
      var gmlOptionsIn = OpenLayers.Util.extend(
          OpenLayers.Util.extend( {}, gmlOptions ),
          in_options
          );
      var gmlOptionsOut = OpenLayers.Util.extend(
          OpenLayers.Util.extend( {}, gmlOptions ),
          out_options
          );
      var kmlOptionsIn = OpenLayers.Util.extend(
      {extractStyles: true}, in_options );
      formats = {
        'in': {
          wkt: new OpenLayers.Format.WKT( in_options ),
          geojson: new OpenLayers.Format.GeoJSON( in_options ),
          georss: new OpenLayers.Format.GeoRSS( in_options ),
          gml2: new OpenLayers.Format.GML.v2( gmlOptionsIn ),
          gml3: new OpenLayers.Format.GML.v3( gmlOptionsIn ),
          kml: new OpenLayers.Format.KML( kmlOptionsIn ),
          atom: new OpenLayers.Format.Atom( in_options )
        },
        'out': {
          wkt: new OpenLayers.Format.WKT( out_options ),
          geojson: new OpenLayers.Format.GeoJSON( out_options ),
          georss: new OpenLayers.Format.GeoRSS( out_options ),
          gml2: new OpenLayers.Format.GML.v2( gmlOptionsOut ),
          gml3: new OpenLayers.Format.GML.v3( gmlOptionsOut ),
          kml: new OpenLayers.Format.KML( out_options ),
          atom: new OpenLayers.Format.Atom( out_options )
        }
      };
    }
    function init()
    {
      map = new OpenLayers.Map( 'map' );
      var wms = new OpenLayers.Layer.WMS( "OpenLayers WMS",
          "http://labs.metacarta.com/wms/vmap0?", {layers: 'basic'} );

      vectors = new OpenLayers.Layer.Vector( "Vector Layer" );

      map.addLayers( [wms, vectors] );
      map.addControl( new OpenLayers.Control.MousePosition() );
      map.addControl( new OpenLayers.Control.EditingToolbar( vectors ) );

      var options = {
        hover: true,
        onSelect: serialize
      };
      var select = new OpenLayers.Control.SelectFeature( vectors, options );
      map.addControl( select );
      select.activate();

      updateFormats();

      initializeFootprints();

      //map.setCenter( new OpenLayers.LonLat( 0, 0 ), 1 );
    }

    function initializeFootprints()
    {
      var url = '${createLink( action:"footprints" )}';

      var responseObj = new OpenLayers.Ajax.Request( url,
      {
        method: 'get',

        //        onSuccess: function( transport )
        //        {
        //          alert( 'Successful Connection' );
        //        },

        onComplete: function( transport )
        {
          var jsonReader = new OpenLayers.Format.JSON();
          var wktReader = new OpenLayers.Format.WKT();
          var json = jsonReader.read( transport.responseText );

          if ( json && json.constructor != Array )
          {
            var bounds;

            for ( x in json )
            {              
              var features = json[x];

              if ( features )
              {
                if ( features.constructor != Array )
                {
                  features = [features];
                }

                alert( x + ': ' + features.length );

                for ( var i = 0; i < features.length; ++i )
                {
                  var wkt = wktReader.read(features[i]);

                  if ( !bounds )
                  {
                    bounds = wkt.geometry.getBounds();
                  }
                  else
                  {
                    bounds.extend( wkt.geometry.getBounds() );
                  }
                }

                vectors.addFeatures( [wkt] );
              }
            }

            map.zoomToExtent( bounds );
          }
        }
      } );
    }

    function serialize( feature )
    {
      var type = document.getElementById( "formatType" ).value;
      // second argument for pretty printing (geojson only)
      var pretty = document.getElementById( "prettyPrint" ).checked;
      var str = formats['out'][type].write( feature, pretty );
      // not a good idea in general, just for this demo
      str = str.replace( /,/g, ', ' );
      document.getElementById( 'output' ).value = str;
    }

    function deserialize()
    {
      var element = document.getElementById( 'text' );
      var type = document.getElementById( "formatType" ).value;
      var features = formats['in'][type].read( element.value );
      var bounds;
      if ( features )
      {
        if ( features.constructor != Array )
        {
          features = [features];
        }
        for ( var i = 0; i < features.length; ++i )
        {
          if ( !bounds )
          {
            bounds = features[i].geometry.getBounds();
          }
          else
          {
            bounds.extend( features[i].geometry.getBounds() );
          }

        }
        vectors.addFeatures( features );
        map.zoomToExtent( bounds );
        var plural = (features.length > 1) ? 's' : '';
        element.value = features.length + ' feature' + plural + ' added';
      }
      else
      {
        element.value = 'Bad input ' + type;
      }
    }

    // preload images
    (function()
    {
      var roots = ["draw_point", "draw_line", "draw_polygon", "pan"];
      var onImages = [];
      var offImages = [];
      for ( var i = 0; i < roots.length; ++i )
      {
        onImages[i] = new Image();
        onImages[i].src = "../theme/default/img/" + roots[i] + "_on.png";
        offImages[i] = new Image();
        offImages[i].src = "../theme/default/img/" + roots[i] + "_on.png";
      }
    })();

  </script>

</head>
<body onload="init()">
<div class="nav">
  <span class="menuButton"><g:link class="home" uri="/">Home</g:link></span>
</div>
<div class="body">
  <div id="leftcol_">
    <h1 id="title">Vector Formats Example</h1>

    <div id="tags">
    </div>

    <p id="shortdesc">
      Shows the wide variety of vector formats that open layers supports.
    </p>

    <div id="map" class="smallmap"></div>
    <div id="input">
      <p>Use the drop-down below to select the input/output format
      for vector features.  New features can be added by using the drawing
      tools above or by pasting their text representation below.</p>
      <label for="formatType">Format</label>
      <select name="formatType" id="formatType">

        <option value="geojson" selected="selected">GeoJSON</option>
        <option value="atom">Atom</option>
        <option value="kml">KML</option>
        <option value="georss">GeoRSS</option>
        <option value="gml2">GML (v2)</option>
        <option value="gml3">GML (v3)</option>

        <option value="wkt">Well-Known Text (WKT)</option>
      </select>
      &nbsp;
      <label for="prettyPrint">Pretty print</label>
      <input id="prettyPrint" type="checkbox"
          name="prettyPrint" value="1"/>
      <br/>
      Input Projection: <select id="inproj" onchange='updateFormats()'>

      <option value="EPSG:4326" selected="selected">EPSG:4326</option>
      <option value="EPSG:900913">Spherical Mercator</option>
    </select> <br/>
      Output Projection: <select id="outproj" onchange='updateFormats()'>
      <option value="EPSG:4326" selected="selected">EPSG:4326</option>
      <option value="EPSG:900913">Spherical Mercator</option>

    </select>
      <br/>
      <textarea id="text">paste text here...</textarea>
      <br/>
      <input type="button" value="add feature" onclick="deserialize();"/>
    </div>

    <div id="docs">
    </div>

  </div>
  <div id="info_">
    <p>Use the tools to the left to draw new polygons, lines, and points.
    After drawing some new features, hover over a feature to see the
    serialized version below.</p>
    <textarea id="output"></textarea>
  </div>
</div>
</body>
</html>