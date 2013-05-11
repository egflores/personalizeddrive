$().ns('DreiApp.Views');


$(document).ready(function () {

    DreiApp.Views.MainView = Backbone.View.extend({
        transition: "fade"
    });


    DreiApp.Views.DriveHistory = DreiApp.Views.MainView.extend({

        template:_.template($('#DriveHistoryTemplate').html()),

        render:function (eventName) {
            $(this.el).html(this.template());
            return this;
        }
    });

    DreiApp.Views.Track = DreiApp.Views.MainView.extend({

        template:_.template($('#TrackTemplate').html()),

        render:function (eventName) {
            $(this.el).html(this.template());
            return this;
        }
    });

    DreiApp.Views.ActiveTracking = DreiApp.Views.MainView.extend({

        transition: "slideup",

        template:_.template($('#ActiveTrackingTemplate').html()),

        render:function (eventName) {
            $(this.el).html(this.template());
            return this;
        }
    });

    DreiApp.Views.Onboarding = DreiApp.Views.MainView.extend({

        transition: "slideup",

        template:_.template($('#OnboardingTemplate').html()),

        render:function (eventName) {
            $(this.el).html(this.template());
            return this;
        }
    });

    DreiApp.Views.Settings = DreiApp.Views.MainView.extend({

        template:_.template($('#SettingsTemplate').html()),

        events: {
            "click .logout": "logout"
        },

        logout: function(e) {
            DreiApp.Callbacks.drei_logout(function() {
                window.location.hash = "track";
            }, function() {});
            e.stopPropagation();
            e.preventDefault();
        },
        
        render:function (eventName) {
            $(this.el).html(this.template());
            return this;
        }
    });
});
