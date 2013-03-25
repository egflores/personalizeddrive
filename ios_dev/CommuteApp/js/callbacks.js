$().ns('DreiApp.Callbacks');

$(document).ready(function () {
    var cb = DreiApp.Callbacks;
    cb.proxy = {};
    _.extend(cb.proxy , Backbone.Events);

    drei_callback_debug = function(context, content) {
        DreiApp.app.log({
            context: context,
            content: content
        });
    };

    drei_callback_dataEntry = function(carData) {
        DreiApp.app.lastCarData = carData;
        cb.proxy.trigger('dataEntry', carData);
    };

    drei_callback_connection = function() {
        DreiApp.app.set('isConnectedToCar', message=="connected");
    };

/* TODO: they might use this to do using a headunit
    drei_callback_carlogging = function(message) {
        DreiApp.app.set('isTrackingCommute', message=="logOn");
    };
*/
});