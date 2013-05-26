$(document).ready(function () {
    DreiApp.Views.Setup1 = DreiApp.Views.MainView.extend({

        transition: "slideup",

        template:_.template($('#SetupTemplate1').html()),

        render: function(eventName) {
            mixpanel.track("Viewed Setup Screen 1");
            $(this.el).html(this.template());
            return this;
        }
    });

    DreiApp.Views.Setup2 = DreiApp.Views.MainView.extend({

        transition: "slide",

        template:_.template($('#SetupTemplate2').html()),

        render: function(eventName) {
            mixpanel.track("Viewed Setup Screen 2");
            $(this.el).html(this.template());
            return this;
        }
    });

    DreiApp.Views.Setup3 = DreiApp.Views.MainView.extend({

        transition: "slide",

        template:_.template($('#SetupTemplate3').html()),

        render: function(eventName) {
            mixpanel.track("Viewed Setup Screen 3");
            $(this.el).html(this.template());
            return this;
        }
    });

    DreiApp.Views.Setup4 = DreiApp.Views.MainView.extend({
        transition: "slide",

        template:_.template($('#SetupTemplate4').html()),

        render: function(eventName) {
            mixpanel.track("Viewed Setup Screen 4");
            $(this.el).html(this.template());
            return this;
        }
    });
});