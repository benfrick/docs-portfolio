var allowed = ['//developer.preprod.niketech.com','//developer.niketech.com','//localhost'];

var clickmessage = {

    receiveMessage: function(event) {
        if(event.type != 'message'){
            return;
        }
        if (clickmessage.allowMessage(event.origin) && event.data) {
            var data = JSON.parse(event.data)
            location.assign(data.path + data.hash);
        }
    },

    allowMessage: function(messageorigin) {
        for (i = 0; i < allowed.length; i++) {
            if (messageorigin.includes(allowed[i])) {
                return true;
            }
        }
    return false;
    },

    getClosest: function (elem, selector) {
        for ( ; elem && elem !== document; elem = elem.parentNode ) {
		    if ( elem.matches( selector ) ) return elem.href;
	    }
	    return null;
    }

};

window.addEventListener('message', clickmessage.receiveMessage, false);
parent.postMessage(location.href,'*');

window.onclick = function(event) {
  let path = clickmessage.getClosest(event.target,'a');
  if (!path) return;
  parent.postMessage(JSON.stringify({ path }), '*');
};