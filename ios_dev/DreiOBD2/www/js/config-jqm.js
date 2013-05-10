/* FILE: config-jqm.js
 * -------------------
 * Configuration settings for jquery mobile to work with backbone
 *
 * Done according to this document: 
 * http://jquerymobile.com/demos/1.3.0-rc.1/docs/pages/backbone-require.html
 *
 * You MUST include this script before you include jquery mobile for this to 
 * work. This is because jquery mobile will fire the mobileinit event right
 * after it is loaded
 */

$(document).bind("mobileinit", function () {
    //$.mobile.ajaxEnabled = false;
    $.mobile.linkBindingEnabled = false;
    $.mobile.hashListeningEnabled = false;
    //$.mobile.pushStateEnabled = false;
});

/*
// Remove page from DOM when it's being replaced
$('div[data-role="page"]').on('pagehide', function (event, ui) {
    $(event.currentTarget).remove();
});
*/

