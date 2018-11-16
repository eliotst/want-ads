// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require turbolinks
//= require materialize-sprockets
//= require_tree .

var handleTaskClick = function(evt) {
    var $button = $(evt.currentTarget);
    var $icon = $button.find("i");
    var checked = $icon.text() == "check_box";
    var actionPath = checked ? $button.data("uncomplete-path") : $button.data("complete-path");
    evt.preventDefault();
    $.ajax({
        url: actionPath,
        data: {
            authenticity_token: window._token
        },
        dataType: "json",
        method: "POST"
    }).then(function() {
        if (checked) {
            $icon.text("check_box_outline_blank");
        } else {
            $icon.text("check_box");
        }
    }).fail(function(error) {
    });
};

var formsInit = function() {
    $('select').material_select();
    $('.task-checkbox-btn').on("click", handleTaskClick);
};
$(document).on('turbolinks:load', formsInit);
$(document).on('page:load', formsInit) //adaptation to turbolinks
