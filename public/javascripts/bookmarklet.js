(function() {
	var href = window.location.href;
	var jid = '$jid', url = '$url';
	function createXMLHttpRequest() {
		try { return new XMLHttpRequest(); } catch(e) {}
		try { return new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) {}
		alert("XMLHttpRequest not supported");
		return null;
	}
  var xhReq = createXMLHttpRequest();
	url += '?jid=' + jid + '&url=' + href;
	xhReq.open('GET',url,true);
	xhReq.onreadystatechange = function() {
		if (xhReq.readystate !== 4) { return ; } 
		if (xhReq.status !== 200) { alert('error'); }
	};
	xhReq.send(null);
})();
