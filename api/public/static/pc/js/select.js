

window.onload=function(){
    var tabs = document.getElementsByName('tab');
    var contents = document.getElementsByName('divcontent');
    console.log(tabs,contents);
    for(var i=0;i<tabs.length;i++){
        tabs[i].index=i;
        tabs[i].onclick=function(){
            for(var j=0;j<tabs.length;j++){
               contents[j].className="hide";
            }
            contents[this.index].className="show"
        }
    }
}
