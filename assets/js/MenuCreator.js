function chop(){
    console.log("hello My Dear. this is JS!");
}

function createMenuItem(tabView, tabTitle, tabLink){
    var isRepeat = false;
    var index=0;
    for(var i=0; i< tabView.count;i++){
        var currentTitle = tabView.getTab(i).title
        if(currentTitle === tabTitle){
            isRepeat = true;
            index = i;
        }
    }
    if(!isRepeat){
        var component = Qt.createComponent(tabLink);
        tabView.addTab(tabTitle, component);
        tabView.currentIndex = tabView.count - 1
    }else{
        tabView.currentIndex = index
    }
}
