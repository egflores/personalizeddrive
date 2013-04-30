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
        DreiApp.app.lastCarData = JSON.parse(carData);
        cb.proxy.trigger('dataEntry', DreiApp.app.lastCarData);
    };

    drei_callback_connection = function(message) {
        DreiApp.app.set('isConnectedToCar', message=="connected");
    };

    drei_callback_carlogging = function(message) {
        DreiApp.app.set('isTrackingCommute', message=="logOn");
    };

    drei_callback_debug = function(component, message, isJson) {
        if(isJson) {
            //TODO: message = pretty print json
        }
        DreiApp.app.log({context: component, content: message})
    };

    cb.drei_start = function(callback, errorCallback) {
        cordova.exec(callback, function() {
                                   errorCallback();
                                   console.log("Error in startDriveLog");
                               }, "DreiConnect", "startDriveLog", []);
    };
    
    cb.drei_stop = function(callback, errorCallback) {
            cordova.exec(callback, function() {
                                       errorCallback();
                                       console.log("Error in stopDriveLog");
                                    }, "DreiConnect", "stopDriveLog", []);
    };
    
    cb.drei_upload = function(callback, errorCallback) {
          cordova.exec(callback, function() {
                                       errorCallback();
                                       console.log("Error in uploadDriveLog");
                                }, "DreiConnect", "uploadDriveLog", []);
    };

/* TODO: they might use this to do using a headunit
    drei_callback_carlogging = function(message) {
        DreiApp.app.set('isTrackingCommute', message=="logOn");
    };
*/
});