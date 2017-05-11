// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets

var like = false;
var avatars = false;


function likeIt() {
    if (like){
        $("#likeImg").attr('src', '/images/like1.png');
        like = false;
    } else {
        $("#likeImg").attr('src', '/images/like2.png');
        like = true;
    }
}

function showAvatars() {
    if (avatars){
        $("#avatars1").attr('style', 'display:none');
        $("#avatars2").attr('style', 'display:none');
        avatars = false;
    } else {
        $("#avatars1").attr('style', 'display:visible');
        $("#avatars2").attr('style', 'display:visible');
        avatars = true;
    }
}

function beFriends() {
    $('prueba').prop('disabled', false);
}