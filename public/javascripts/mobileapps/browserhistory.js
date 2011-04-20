
jQuery(document).ready(function() {

    var myCallback = function(msg){
        alert(msg);
    }

	jQuery("#browserhistorybutton").click(function() {
	//iterate over all connected peers and send them a message
	for (var peer in app.xmpp('state').peers) {
		if(peer){
		    app.xmpp('sendEpicIntent', peer, 'org.epic.action.ListBrowserHistory', myCallback);
		}
     }
	
	
	
    });
});
