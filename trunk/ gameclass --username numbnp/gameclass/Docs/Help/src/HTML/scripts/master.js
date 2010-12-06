function doSection (secNum){
//display the section if it's not displayed; hide it if it is displayed
if (secNum.style.display=="none"){secNum.style.display=""}
else{secNum.style.display="none"}
}

function noSection (secNum){
//remove the section when user clicks in the opened DIV
if (secNum.style.display==""){secNum.style.display="none"}
}
