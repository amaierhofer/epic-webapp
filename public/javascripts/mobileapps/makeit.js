
jQuery(document).ready(function() {

    myCallback = function(msg) {
        console.log('got message' + msg);
        //clear the list
        jQuery('#action-list').children().each(function(i,e){jQuery(e).remove()});
        //parse the message
        jQuery(msg).children().children().each(
                //for each entry in the message append a entry to the list
                function(i,e){
                    package = jQuery(e).children('package').text();
                    class = jQuery(e).children('class').text();
                    action = jQuery(e).children('action').text();

                    newelement = "<li> Action: " + action ;
                    if((package)&&(class)){
                        newelement = newelement + " implemented by class " + class + " in package "+ package;
                    }
                    newelement = newelement + "</li>";
                    jQuery('#action-list').append(newelement);
                });
    };

    jQuery("#epicactionsbutton").click(function() {
        data = jQuery('<data>').attr('type', "map").append(jQuery('<start>').attr('type', 'int').append('0')).append(jQuery('<size>').attr('type', 'int').append('10'));
        //iterate over all connected peers and send them a message
        for (var peer in app.xmpp('state').peers) {
            if (peer) {
                app.xmpp('sendEpicIntent', peer, 'org.epic.action.ListActions', data, myCallback);
            }
        }


    });


});
