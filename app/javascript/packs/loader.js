$('input[type="submit"]').on('click', () => {
  $('#all-window').css('display', 'block');
	$('.ui.dimmer').toggleClass('active');
});
