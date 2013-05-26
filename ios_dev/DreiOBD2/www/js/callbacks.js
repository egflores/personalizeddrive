$().ns('DreiApp.Callbacks');

$(document).ready(function () {
    var cb = DreiApp.Callbacks;
    cb.proxy = {};
    _.extend(cb.proxy , Backbone.Events);

    drei_callback_debug = function(context, content) {
    };
    drei_callback_connectionStatus = function(status) {
      
        // alert(status);
        // $("#status").html(status);
        // $("#track_status").html(status);
    }
                  
    drei_callback_dataEntry = function(carData) {
                  if (!carData) {
                    return;
                  }
                  $("#speed").html(carData.vehicle_speed * 0.621371);
                  $("#rpm").html(carData.rpm);
                  $("#instant_mpg").html(carData.instant_mpg);
                  $("#gps_lat").html(carData.gps_latitude);
                  $("#gps_long").html(carData.gps_longitude);
                  //TESTING OBDII
                  //END TESTING OBDII
                  //cb.proxy.trigger('dataEntry', DreiApp.app.lastCarData);
                  };
                  
    drei_callback_driveLog = function(carData) {
        if (carData === "on") {
            window.location.href="#activetracking";
        }
    };

    /*
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
    };*/

    var firstTime = true;
    var start = new Date();
    cb.drei_start = function(callback, errorCallback) {
        cordova.exec(callback, function() {
                                   errorCallback();
                                   console.log("Error in startDriveLog");
                               }, "DreiConnect", "startDriveLog", []);
        if(firstTime) {
          var end = new Date();
          var secondsOpen = Math.floor((end - start) / 1000);
          mixpanel.track("Time Since Start", {"seconds": secondsOpen}); 
          firstTime = false;
        }
    };
    
    cb.drei_stop = function(callback, errorCallback) {
            cordova.exec(callback, function() {
                                       errorCallback();
                                       console.log("Error in stopDriveLog");
                                    }, "DreiConnect", "stopDriveLog", []);
    };

    cb.drei_logout = function(callback, errorCallback) {
        cordova.exec(callback, function() {
                                   errorCallback();
                                   console.log("Error in startDriveLog");
                               }, "DreiConnect", "logout", []);
    };

    cb.drei_get_drive_logs = function(callback, errorCallback) {
        cordova.exec(callback, function() {
                           errorCallback();
                           console.log("Error in startDriveLog");
                       }, "DreiConnect", "getDriveLogs", []);
    };
                  
    cb.drei_init = function() {
                  cordova.exec(function() {}, function() {}, "DreiConnect", "init", []);
    };
    cb.drei_send_feedback = function(callback, errorCallback, feedback) {
        cordova.exec(callback, function() {
                   errorCallback();
                   console.log("Error in sendFeedback");
                   }, "DreiConnect", "sendFeedback", [feedback]);
    };
    /* Not implemented
        cb.drei_upload = function(callback, errorCallback) {
              cordova.exec(callback, function() {
                                           errorCallback();
                                           console.log("Error in uploadDriveLog");
                                    }, "DreiConnect", "uploadDriveLog", []);
        };
    */
/* TODO: they might use this to do using a headunit
    drei_callback_carlogging = function(message) {
        DreiApp.app.set('isTrackingCommute', message=="logOn");
    };
*/
});