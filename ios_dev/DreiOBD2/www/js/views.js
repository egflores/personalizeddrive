$().ns('DreiApp.Views');


$(document).ready(function () {


    DreiApp.Views.DriveHistory = Backbone.View.extend({

        template:_.template($('#DriveHistoryTemplate').html()),

        render:function (eventName) {
            $(this.el).html(this.template());
            return this;
        }
    });

    DreiApp.Views.Track = Backbone.View.extend({

        template:_.template($('#TrackTemplate').html()),

        render:function (eventName) {
            $(this.el).html(this.template());
            return this;
        }
    });

    DreiApp.Views.Settings = Backbone.View.extend({

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
