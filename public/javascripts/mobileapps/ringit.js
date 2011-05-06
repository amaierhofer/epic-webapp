
$(function() {
  $("#ring").click(function() {
    var peers = app.xmpp('state').peers;
    if(_.isEmpty(peers)) { $.nmk.log('no peers'); }
    _.each(peers, function(peer) {
      $.nmk.log('peer: ' + peer);
      app.xmpp('sendEpicIntent', peer, 'org.epic.action.RingPhone', null, null);
    });
  });
});
