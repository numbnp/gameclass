function startTime()
{
    var tm=new Date();
    var h=tm.getHours();
    var m=tm.getMinutes();
    var s=tm.getSeconds();
    
    m=checkTime(m);
    s=checkTime(s);
    document.getElementById('time').innerHTML=h+":"+m+":"+s;
    t=setTimeout('startTime()',500);
}
function checkTime(i)
{
    if (i<10)
    {
        i="0" + i;
    }
    return i;
}


function cssmenuhover()
{
        if(!document.getElementById("cssmenu"))
                return;
	var lis = document.getElementById("cssmenu").getElementsByTagName("LI");
        for (var i=0;i<lis.length;i++)
        {
                lis[i].onmouseover=function()
{this.className+=" iehover";}
                lis[i].onmouseout=function()
{this.className=this.className.replace(new RegExp(" iehover\\b"), "");}
        }
}
if (window.attachEvent)
        window.attachEvent("onload", cssmenuhover);

if (window.Event) 
  	document.captureEvents(Event.MOUSEUP); 

function nocontextmenu() { 
	event.cancelBubble = true, event.returnValue = false; 
   	return false; 
} 

function norightclick(e) { 
	if (window.Event) { 
		if (e.which == 2 || e.which == 3) return false; 
	} 
   	else if (event.button == 2 || event.button == 3) { 
   		event.cancelBubble = true, event.returnValue = false; 
		return false; 
	} 
} 
if (document.layers) 
	document.captureEvents(Event.MOUSEDOWN); 

document.oncontextmenu = nocontextmenu; 
document.onmousedown = norightclick; 
document.onmouseup = norightclick; 
