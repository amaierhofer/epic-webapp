
function qrcode(url){
	  return '<img src ="http://qrcode.kaywa.com/img.php?s=5&d='+url+'">';
	}
   
jQuery(document).ready(function() {

	var theqrcode = qrcode(app.xmpp('getUsername') + ':' + app.xmpp('getPassword') + '@' + app.xmpp('getServer'));
	jQuery('#qrcode').append(theqrcode);
	

    jQuery("#ringitbutton").click(function() {
	//iterate over all connected peers and send them a message
	for (var peer in app.xmpp('state').peers) {
		if(peer){
		        app.xmpp('sendEpicIntent', peer, 'org.epic.action.RingPhone', null);
		}
      	}
	
	
	
    });
});
