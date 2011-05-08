(function($) {
  $(function() {
    window.epic = $('body').app();
    window.epic.bind('xmpp.transition', function(ev,peers) {
      if(peers.length === 0) { return; }
      var op = _.first(_.values(peers.peers)) == 'available' ? 'enable' : 'disable';
      $('a[data-role]="button"').each(function() {
        $(this).button().button(op);
      });
    });
  });
})(jQuery);
