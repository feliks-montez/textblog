$(document).ready(function() {
  init();
});

function init() {
  $('#menu-toggle').click(toggleMenuVisibility);
}

function toggleMenuVisibility() {
  var menu = $('#nav-main');
  if (menu.css('max-height') == '0px') {
    menu.css({
      'max-height': '1000px'});
  } else {
    menu.css({'max-height': '0px'});
  }
}
