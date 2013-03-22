$(document).ready(function () {
    var threeDRouter = backboneResponsiveCSS3Transitions.extend({
        routes: {
            "*default": "loadView",
        },
        loadView: function (viewFragment) {
            if (viewFragment.match(/tracking/)) {
                this.triggerTransition(DreiApp.Views.Tracking, {"direction": "default"})
            } else if (viewFragment.match(/logging/)) {
                this.triggerTransition(DreiApp.Views.Logging, {"direction": "default"})
            } else {
                this.triggerTransition(DreiApp.Views.Home, {"direction": "default"});
            }
        
        },
        wrapElement: ".my-container",
    });

    var myRouter = new threeDRouter({"wrapElement": ".my-container",});

    Backbone.history.start();
});