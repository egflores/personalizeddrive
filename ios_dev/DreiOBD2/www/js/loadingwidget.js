/* loadingwidget.js
 * -----------------
 * The jquery loading message doesn't disable the UI. This is wrapper
 * code to do that for you. 
 * Ripped off of stack overflow - 
 * http://stackoverflow.com/questions/8475559/jquerymobile-how-to-freeze-screen
 */

 $().ns('DreiApp.LoadingWidget');

 $(document).ready(function () {
	DreiApp.LoadingWidget.showPageLoadingMsg = function(theme, text) {
		$("body").append('<div class="modal-overlay"/>');
		$(".modal-overlay").animate({opacity: .7}, 500, function(){})
		$.mobile.showPageLoadingMsg(theme, text);
	}

	DreiApp.LoadingWidget.hidePageLoadingMsg = function(theme, text) {
		$(".modal-overlay").remove();
		$.mobile.hidePageLoadingMsg();
	}
 });