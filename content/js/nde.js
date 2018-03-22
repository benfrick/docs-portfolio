var allowed = ['https://developer.preprod.niketech.com','https://developer.niketech.com'];

function receiveMessage(event)
{
  console.log('received event from origin ' + event.origin);
  console.log('received data ' + event.data);
  for (i = 0; i < allowed.length; i++) {
      if (event.origin === allowed[i]){
        processMessage (event);
        break;
      }
  }
  console.log('done receiving message');
}

function processMessage (event) {
  console.log('allowing origin ' + event.origin);

  //send receipt message to sender
  sendMessage('received message', event.origin, event.source);

  //load requested url
  //e.g./doc/commerce/checkout/api_checkout.html
  location.assign(event.data);

  console.log('done processing message');

}

function sendMessage (message,origin,recipient){
    recipient.postMessage(message, origin, false);
    console.log('done sending message to ' + origin);
}
window.addEventListener('message', receiveMessage, false);
console.log('added event listener');