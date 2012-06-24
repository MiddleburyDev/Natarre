// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

	$('#fb-login-button').click(function() {
		FB.login(function(response) {
			if (response.authResponse) {

				FB.api('/me', function(response) {
					console.log(response);
					$('#name').val(response.name);
					$('#email').val(response.email);
					$('#fb_id').val(response.fb_id);
					$('#password').val(response.password);
					$('#fb-image').css('height','50px');
					$('#fb-image').css('width','50px');
					$('#fb-image').css('margin','10px auto 0 auto');					
					$('#fb-image').css('background','url(http://graph.facebook.com/'+response.id+"/picture)");
				});
			} else {
				console.log('User cancelled login or did not fully authorize.');
			}
		}, {scope: 'email'});
	});

	window.fbAsyncInit = function() {
		FB.init({
			appId: '372966559424569',
			channelUrl: 'http://localhost:3000/channel.html',
			status: true,
			cookie: true
		});

		// Additional initialization code here
	};

	// Load the SDK Asynchronously
	(function(d) {
		var js, id = 'facebook-jssdk',
			ref = d.getElementsByTagName('script')[0];
		if (d.getElementById(id)) {
			return;
		}
		js = d.createElement('script');
		js.id = id;
		js.async = true;
		js.src = "//connect.facebook.net/en_US/all.js";
		ref.parentNode.insertBefore(js, ref);
	}(document));

});