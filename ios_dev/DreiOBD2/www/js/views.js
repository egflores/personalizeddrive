$().ns('DreiApp.Views');


$(document).ready(function () {
    var Navigation = Backbone.View.extend({

        template:_.template($('#navigation-template').html()),

        initialize: function() {
            this.activePage = 1;
        },

        events: {
            "click #nav-drivehistory": "changeDriveHistory",
            "click #nav-track": "changeTrack",
            "click #nav-settings": "settings"
        },

        changeDriveHistory: function() {
            this.activePage = 0;
            window.location.hash="drivehistory";
        },

        changeTrack: function() {
            this.activePage = 1;
            window.location.hash="track";
        },

        changeSettings: function() {
            this.activePage = 2;
            window.location.hash="settings";
        },

        render:function (eventName) {
            $(this.el).html(this.template({"activePage": this.activePage}));
            return this;
        }
    });

    var nav = new Navigation();

    DreiApp.Views.DriveHistory = Backbone.View.extend({

        template:_.template($('#DriveHistoryTemplate').html()),

        render:function (eventName) {
            $(this.el).html(this.template());
            $(".ui-page").append(nav.render().el);
            return this;
        }
    });

    DreiApp.Views.Track = Backbone.View.extend({

        template:_.template($('#TrackTemplate').html()),

        render:function (eventName) {
            $(this.el).html(this.template());
            $(".ui-page").append(nav.render().el);
            return this;
        }
    });

    DreiApp.Views.Settings = Backbone.View.extend({

        template:_.template($('#SettingsTemplate').html()),

        render:function (eventName) {
            $(this.el).html(this.template());
            $(".ui-page").append(nav.render().el);
            return this;
        }
    });
});
