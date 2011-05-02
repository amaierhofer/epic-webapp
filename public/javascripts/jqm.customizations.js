$(document).bind('mobileinit', function() {

  // workaround first link having focus
  $('div').live('pagebeforeshow',function(event, ui){
    $('a:first').hide();
  });

  $.extend($.mobile, {
    defaultTransition: 'none',
    loadingMessage: 'loading .. '
  });
});

