OMAR.models.MenuModel = Backbone.Model.extend(
{

}
);

OMAR.views.SearchMenuView = Backbone.View.extend({
    el:"#federatedSearchMenuId",
    initialize: function(params)
    {
        
    },
    events: {
        "click #ExportKmlQueryId": "exportKmlQuery",
        "click #ExportKmlQueryFloatBboxId": "exportKmlQueryFloatBbox",
        "click #ExportKmlId": "exportKml",
        "click #ExportGeoJsonId": "exportGeoJson",
        "click #ExportGml2Id": "exportGml2",
        "click #ExportCsvId": "exportCsv",
        "click #TimeLapseId": "exportTimeLapse",
        "click #ExportGeoCellId": "exportGeoCell",
        "click #DownloadId": "downloadFiles",
        "click #CreateProductId": "createProduct"
    },
    exportKmlQuery:function() {
        //OMAR.federatedRasterSearch.setupExports("kmlQuery");
        this.trigger("onKmlQueryClicked");
    },
    exportKmlQueryFloatBbox:function() {
        this.trigger("onKmlQueryFloatBboxClicked");
    },
    exportKml:function() {
        //OMAR.federatedRasterSearch.setupExports("kmlQuery");
        this.trigger("onKmlClicked");
    },
    exportGeoJson:function() {
        this.trigger("onGeoJsonClicked")
    },
    exportGml2:function() {
        this.trigger("onGml2Clicked")
    },
    exportCsv:function() {
        this.trigger("onCsvClicked")
    },
    exportTimeLapse:function(){
        this.trigger("onTimeLapseClicked")
    },
    exportGeoCell:function(){
        this.trigger("onGeoCellClicked")
    },
    downloadFiles:function(){
        this.trigger("onDownloadFilesClicked")
    },
    createProduct:function(){
        this.trigger("onCreateProductClicked")
    },
    render:function()
    {
        $("#federatedSearchMenuId").jMenu({
            openClick: false,
            ulWidth: 100,
            effects: {
                effectSpeedOpen: 0,
                effectSpeedClose: 0,
                effectTypeOpen: 'slide',
                effectTypeClose: 'hide',
                effectOpen: 'linear',
                effectClose: 'linear'
            },
            TimeBeforeOpening: 0,
            TimeBeforeClosing: 0,
            animatedText: true,
            paddingLeft: 10
        });
    }
});