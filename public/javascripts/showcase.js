(function($) {

  var icons = {
    prev: "M21.871,9.814 15.684,16.001 21.871,22.188 18.335,25.725 8.612,16.001 18.335,6.276z",
    next: "M10.129,22.186 16.316,15.999 10.129,9.812 13.665,6.276 23.389,15.999 13.665,25.725z"
  };

  var images = ["lol1.jpg", "lol2.jpg", "lol3.jpg"];


  window.icons = icons;



  $(function() {

  });


  $(function() {
    _.each(icons, function(v,k) {
      var r = Raphael(k, 40,40);
      r.path(v).attr({fill: "#000", stroke: "none"});  
      $(r.canvas).click(function() {
        console.log('foobar');
      });
      window.r = r;
    });
    
  });
})(jQuery);
