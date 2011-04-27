
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
                    visits = jQuery(e).children('visits').text();
                    date = jQuery(e).children('date').text();

                    newelement = "<li>";
                    if(title==url){
                        newelement = newelement + '<a href="'+url+'">' + url + '</a>';
                    } else {
                        newelement = newelement + title + ': <a href="'+url+'">' + url + '</a>';
                    }
                    if((date)&&(visits)){
                        newelement = newelement + ' (' + visits + ' times accessed - last on: '+date+')';
                    }
                    newelement = newelement + '</li>'

                    jQuery('#page-list').append(newelement);
                });
    };

    jQuery("#mostrecentbutton").click(function() {
        data = jQuery('<data>').attr('type', "map").append(jQuery('<start>').attr('type', 'int').append('0')).append(jQuery('<size>').attr('type', 'int').append('10'));
        //iterate over all connected peers and send them a message
        for (var peer in app.xmpp('state').peers) {
            if (peer) {
                app.xmpp('sendEpicIntent', peer, 'org.epic.action.ListBrowserHistory', data, myCallback);
            }
        }


    });

    jQuery("#mostvisitedbutton").click(function() {
        data = jQuery('<data>').attr('type', "map").append(jQuery('<order>').attr('type', 'string').append('visits')).append(jQuery('<start>').attr('type', 'int').append('0')).append(jQuery('<size>').attr('type', 'int').append('10'));
        //iterate over all connected peers and send them a message
        for (var peer in app.xmpp('state').peers) {
            if (peer) {
                app.xmpp('sendEpicIntent', peer, 'org.epic.action.ListBrowserHistory', data, myCallback);
            }
        }


    });
});
