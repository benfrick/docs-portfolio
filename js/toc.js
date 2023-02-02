/*
TOC Builder for .pdfs
- loops through each H2 in the HTML document, using text as toc text and id as anchor link
- appends links to the #toc <div> as <li> at beginning of pdf
- builds fully qualified links from relative links so they work
*/

var h2s = document.getElementsByTagName('h2');
var relLinks = document.querySelectorAll('a[href^="/doc"]');

if (h2s && h2s.length > 2){
  var toc = document.getElementById('toc');
  var title = document.getElementsByTagName('h1')[0].innerHTML;
  var text, link, li,id, div;

  /* page break after toc */
  toc.setAttribute('style','break-after: page');

  /* generate toc title from h1 */
  if(title){
    div = document.createElement('div');
    div = document.createElement('h1');
    text = document.createTextNode(title.toUpperCase().replace("<br>",""));
    div.appendChild(text);
    toc.appendChild(div);
  }
  /* generate Table of Contents static title */
  div = document.createElement('div');
  div = document.createElement('h3');
  text = document.createTextNode('TABLE OF CONTENTS');
  div.appendChild(text);
  toc.appendChild(div);

  /* generate toc from h2s */
  for (var i=0; i<h2s.length; i++)
  {
    text = document.createTextNode(getText(h2s[i]));
	link = document.createElement('a');
	link.setAttribute('href', '#'+h2s[i].getAttribute('id'));
	link.appendChild(text);
    li = document.createElement('li');
    li.appendChild(link);
    toc.appendChild(li);
  }

/* get h2 text */
function getText(e)
{
  var text = "";

  for (var x = e.firstChild; x != null; x = x.nextSibling) {
    if (x.nodeType == x.TEXT_NODE) {
      text += x.data;
    }
    else if (x.nodeType == x.ELEMENT_NODE) {
	        text += getText(x);
	  }
    }
    return text;
  }
}
  /* build fully qualified links from relative links */
  if (relLinks && relLinks.length > 0){
    for(var step=0; step<relLinks.length; step++) {
      relLinks[step].href = "https://nde-devportal-docs.niketech.com" + relLinks[step].href.replace('file:///', '/');
    }
  }