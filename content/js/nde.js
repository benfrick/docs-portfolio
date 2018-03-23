var allowed = ['https://developer.preprod.niketech.com','https://developer.niketech.com','http://localhost:3000','*'];
var temp;

function receiveMessage(event)
{
  console.log('received event from origin ' + event.origin);
  for (i = 0; i < allowed.length; i++) {
    console.log('comparing event.origin '+ event.origin + ' to allowed ' + allowed[i]);
    if (event.origin === allowed[i]){
      processMessage (event);
      break;
    }
  }
  processMessage (event);
  console.log('done receiving message');
}
function processMessage (event) {
  console.log('allowing origin ' + event.origin);

  if(event.data) {
    temp = JSON.parse(event.data);
    location.assign(temp.path);
    console.log('done processing message ' + temp.path);
  }
}
function sendMessage (message, origin, recipient){
    recipient.postMessage(message, origin, false);
    console.log('done sending message ' + message + ' to ' + origin);
}
window.addEventListener('message', receiveMessage, false);
console.log('added event listener');
if(parent)
    parent.postMessage(location.href,location.origin);
console.log('notified parent ready to listen');