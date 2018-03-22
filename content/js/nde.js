var allowed = ['https://developer.preprod.niketech.com','https://developer.niketech.com'];
var parent = window.opener;

function receiveMessage(event)
{
  console.log('received event from origin ' + event.origin);
  console.log('received data ' + event.data);
  for (i = 0; i < allowed.length; i++) {
    console.log('comparing event.origin '+ event.origin + ' to allowed ' + allowed[i]);
      if (event.origin === allowed[i]){
        processMessage (event);
        break;
      }
  }
  console.log('done receiving message');
}
function processMessage (event) {
  console.log('allowing origin ' + event.origin);

  location.assign(event.data);

  console.log('done processing message ' + event.data);

}
function sendMessage (message, origin, recipient){
    recipient.postMessage(message, origin, false);
    console.log('done sending message ' + message + ' to ' + origin);
}
window.addEventListener('message', receiveMessage, false);
console.log('added event listener');
if(parent)
    parent.sendMessage(location.href,location.origin);
console.log('notified parent ready to listen');