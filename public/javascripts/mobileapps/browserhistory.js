
jQuery(document).ready(function() {

    myCallback = function(msg) {
        console.log(msg);

        jQuery(msg).children().children().each(
                function(i,e){
                    title = jQuery(e).children('title').text();
                    url = jQuery(e).children('url').text();
                    jQuery('#page-list').append('<li> <a href="'+url+'">' + title + ':  '+ url + '</a></li>');
                });
    };

    jQuery("#browserhistorybutton").click(function() {
        //iterate over all connected peers and send them a message
        for (var peer in app.xmpp('state').peers) {
            if (peer) {
                app.xmpp('sendEpicIntent', peer, 'org.epic.action.ListBrowserHistory', myCallback);
            }
        }


    });
});
