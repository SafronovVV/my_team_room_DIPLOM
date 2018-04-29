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
//= require jquery_ujs
//= require ckeditor/init
//= require twitter/bootstrap
//= require vue
//= require_tree .

$(document).ready(() => {
  activeLink();
  displayChat(localStorage.getItem('displayChat'));
});

function activeLink(){
  const current_path = window.location.pathname;
  $(`a[href='${current_path}']`).parent().addClass('current');
}

function toggleChat() {
  localStorage.setItem('displayChat', localStorage.getItem('displayChat') == "true" ? false : true);
  displayChat(localStorage.getItem('displayChat'));
}

function displayChat(value){
    let display = value == 'true';
    $('.chat-block').css('display', display ? '' : 'none');
    $('.issues-block').addClass(display ? 'col-md-8' : 'col-md-12').removeClass(display ? 'col-md-12' : 'col-md-8');
}
