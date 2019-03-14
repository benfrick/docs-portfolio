/*
TOC Builder for .pdfs
loops through each H2 in the HTML document, using the text as anchor text and id as anchor link.
appends links to the #toc <div> as an <li>
*/
var hs = document.getElementsByTagName('h2');

if (hs && hs.length > 2){
var toc = document.getElementById('toc');
var title = document.getElementsByTagName('h1')[0].innerHTML;
var text, link, li,id, div;
/* generates toc title from h1 */
if(title){
    div = document.createElement('div');
    div.setAttribute('style','font-weight:bold;font-size:2.3em;margin-bottom:25px;');
    text = document.createTextNode(title.replace("<br>",""));
    div.appendChild(text);
    toc.appendChild(div);
}
/* generates Table of Contents static title */
div = document.createElement('div');
div.setAttribute('style','font-weight:bold;font-size:2.1em;margin-bottom:15px;');
text = document.createTextNode('Table of Contents');
div.appendChild(text);
toc.appendChild(div);

for(var i=0; i<hs.length; i++)
{
    text = document.createTextNode(getText(hs[i]));
    hs[i].setAttribute('id', 'sec'+i);
	link = document.createElement('a');
	link.setAttribute('href', '#sec'+i);
	link.appendChild(text);
    li = document.createElement('li');
    li.appendChild(link);
    toc.appendChild(li);
}

/* gets the h2 text */
function getText(e)
{
    var text = "";

    for (var x = e.firstChild; x != null; x = x.nextSibling)
    {
	    if (x.nodeType == x.TEXT_NODE)
	    {
	        text += x.data;
	    }
	    else if (x.nodeType == x.ELEMENT_NODE)
	    {
	        text += getText(x);
	    }
    }

    return text;
}
}