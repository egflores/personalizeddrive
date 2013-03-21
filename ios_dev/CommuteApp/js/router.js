$().ns('DreiCommuteApp.Router');

$(document).ready(function () {
    DreiCommuteApp.Router = Backbone.Router.extend({
        routes: {
            "": 'noop',
        },

        noop: function() {
        },
    }());
};