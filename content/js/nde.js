var allowed = ['https://developer.preprod.niketech.com','https://developer.niketech.com','http://localhost:3000'];
var temp;

function receiveMessage (event)
{
  for (i = 0; i < allowed.length; i++) {
    if (event.origin === allowed[i]){
      processMessage (event);
      break;
    }
  }
}
function processMessage (event) {
  if(event.data) {
    temp = JSON.parse(event.data);
    location.assign(temp.path);
  }
}
function sendMessage (message, origin, recipient){
    recipient.postMessage(message, origin, false);
}
window.addEventListener('message', receiveMessage, false);
if(parent)
    parent.postMessage(location.href,'*');