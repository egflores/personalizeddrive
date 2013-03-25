$(document).ready(function () {
    var threeDRouter = backboneResponsiveCSS3Transitions.extend({
        routes: {
            "*default": "loadView",
        },
        loadView: function (viewFragment) {
            if (!viewFragment) return;
            if (viewFragment.match(/tracking/)) {
                if(DreiApp.app.currentView) DreiApp.app.currentView.destroy();
                DreiApp.app.currentView = new DreiApp.Views.Tracking();
                DreiApp.app.currentView.render();
                //this.triggerTransition(DreiApp.Views.Tracking, {"direction": "default"})
            } else if (viewFragment.match(/logging/)) {
                if(DreiApp.app.currentView) DreiApp.app.currentView.destroy();
                DreiApp.app.currentView = new DreiApp.Views.Logging();
                DreiApp.app.currentView.render();
                //this.triggerTransition(DreiApp.Views.Logging, {"direction": "default"})
            } else {
                if(DreiApp.app.currentView) DreiApp.app.currentView.destroy();
                DreiApp.app.currentView = new DreiApp.Views.Home();
                DreiApp.app.currentView.render();
                //this.triggerTransition(DreiApp.Views.Home, {"direction": "default"});
            }
        
        },
        wrapElement: ".my-container",
    });

    var myRouter = new threeDRouter({"wrapElement": ".my-container",});

    Backbone.history.start();
});