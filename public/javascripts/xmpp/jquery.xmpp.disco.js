(function($,Strophe) {

  var disco = {
    init: function(conn) {
      this._conn = conn;
    }

  };

  Strophe.addConnectionPlugin('disco', disco);


})(jQuery, Strophe);
