var OMAR={};

OMAR.models = {}
OMAR.views  = {}
OMAR.pages  = {}

OMAR.ddRegExp=/^(\-?\d{1,2})(\.\d+)?\,?\s?(\-?\d{1,3})(\.\d+)?$/;
OMAR.dmsRegExp=/^(\d{1,2})\°?\s?(\d{1,2})\'?\s?(\d{1,2})\s?(\.\d+)?\"?\s?([NnSs])?\,?\s?(\d{1,3})\°?\s?(\d{1,2})\'?\s?(\d{1,2})\s?(\.\d+)?\"?\s?([EeWw])?$/;
OMAR.mgrsRegExp=/^(\d{1,2})\s?([C-X])\s?([A-Z])\s?([A-Z])\s?(\d{1,5})\s?(\d{1,5})?/;

OMAR.regexp = {}

OMAR.regexp.float= /[-+]?[0-9]*\.?[0-9]*/;
OMAR.regexp.integer= /[-+]?[0-9]*/;
OMAR.regexp.isoDate= /^([\+-]?\d{4}(?!\d{2}\b))((-?)((0[1-9]|1[0-2])(\3([12]\d|0[1-9]|3[01]))?|W([0-4]\d|5[0-2])(-?[1-7])?|(00[1-9]|0[1-9]\d|[12]\d{2}|3([0-5]\d|6[1-6])))([T\s]((([01]\d|2[0-3])((:?)[0-5]\d)?|24\:?00)([\.,]\d+(?!:))?)?(\17[0-5]\d([\.,]\d+)?)?([zZ]|([\+-])([01]\d|2[0-3]):?([0-5]\d)?)?)?)?$/
OMAR.regexp.isoPeriod=/^P(?:\d+Y|Y)?(?:\d+M|M)?(?:\d+D|D)?(?:T(?:\d+H|H)?(?:\d+M|M)?(?:\d+(?:\.\d{1,2})?S|S)?)?$/



/****
 * If you want a higher precision in OpenLayers inches per unit for meters then
 * add this line in your code that uses open layers.
 *
 * OpenLayers.INCHES_PER_UNIT['m'] = 39.3700787;
 *
 * The OMAR.measure.units are OpenLayers units that we interface into
 */
OMAR.measure = {}
OMAR.measure.units = { labels:["kilometers", "meters", "feet", "yards", "miles", "nautical miles"],
    openlayersMapping:{"kilometers":"Kilometer", "meters":"Meter", "feet":"Foot", "yards":"Yard", "miles": "Mile", "nautical miles":"NautM"},
    extensionMapping:{"kilometers":"km", "meters":"m", "feet":"ft", "yards":"yd", "miles": "mi", "nautical miles":"nmi" },
    unitMapping:{"km":"kilometers", "m":"meters", "ft":"feet", "yd":"yards",  "mi":"miles", "nmi":"nautical miles" },
    precisionMapping:{"kilometers":10000,"meters":1000,"feet":100,"yards":100, "miles":10000, "nautical miles":10000},
    active:"meters"
};
