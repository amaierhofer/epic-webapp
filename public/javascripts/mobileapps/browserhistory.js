
jQuery(document).ready(function() {

    myCallback = function(msg) {
        console.log(msg);
        //clear the list
        jQuery('#page-list').children().each(function(i,e){jQuery(e).remove()});
        //parse the message
        jQuery(msg).children().children().each(
                //for each entry in the message append a entry to the list
                function(i,e){
                    title = jQuery(e).children('title').text();
                    url = jQuery(e).children('url').text();

                    newelement = "";
                    if(title==url){
                        newelement = '<li> <a href="'+url+'">' + url + '</a></li>';
                    } else {
                        newelement = '<li>' + title + ': <a href="'+url+'">' + url + '</a></li>';
                    }
                    jQuery('#page-list').append(newelement);
                });
    };

    jQuery("#browserhistorybutton").click(function() {
        data = jQuery('<data>').attr('type', "map").append(jQuery('<start>').attr('type', 'int').append('5')).append(jQuery('<size>').attr('type', 'int').append('5'));
        //iterate over all connected peers and send them a message
        for (var peer in app.xmpp('state').peers) {
            if (peer) {

                app.xmpp('sendEpicIntent', peer, 'org.epic.action.ListBrowserHistory', data, myCallback);
            }
        }


    });
});
