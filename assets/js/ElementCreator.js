function chop(){
    console.log("hello worldsdsdsds");
}

function createTable(listName, parentName, tableName, modelName){
    var mModel = modelName(listName, parentName);
    tableName.model = mModel;
    //mTable.height = mTable.height - mLabel.height
}

function createCombo(items, index, parentName, comboBox){
    var mModel = createModel(items, parentName);
    comboBox.model = mModel;
    comboBox.currentIndex = index;
}

function appendTwoModel(mTable, model){
    for (var i = 0; i < model.length; i++) {
        var firstRole, secondRole = "";
        for (var j = 0; j < model[i].length; j++) {
            var node = model[i][j];
            switch(j) {
            case 0:
                firstRole = node;
                break;
            case 1:
                secondRole = node;
                break;
            }
        }
        mTable.model.append({
                                "firstRole": firstRole,
                                "secondRole": secondRole
                            });
    }
}

function toogleGif(gif, gifVal, el, elVal){
    el.opacity = elVal;
    gif.visible = gifVal;
}

function createProxyModel(sourceModel, proxyModel, mTable){
    var roles = '';
    for (var i = 0; i< mTable.columnCount; i++){
        roles += mTable.getColumn(i).role + " ";
    }
    proxyModel.filterRole = sourceModel.count > 0
            ? roles: ""
    proxyModel.source = sourceModel.count > 0
            ? sourceModel : null
    proxyModel.sortRole = sourceModel.count > 0
            ? mTable.getColumn(mTable.sortIndicatorColumn).role : ""
    return proxyModel;
}

function createModel(items, parentName){
    var model = Qt.createQmlObject('import QtQuick 2.4; ListModel {}', parentName);

    for (var i = 0; i < items.length; i++) {
        var node = items[i];
        model.append({
                         "firstRole": node
                     });
    }
    return model;
}

function createTwoModel(listName, parentName){
    var model = Qt.createQmlObject('import QtQuick 2.4; ListModel {}', parentName);

    for (var i = 0; i < listName.length; i++) {
        var firstRole, secondRole = "";
        for (var j = 0; j < listName[i].length; j++) {
            var node = listName[i][j];
            switch(j) {
            case 0:
                firstRole = node;
                break;
            case 1:
                secondRole = node;
                break;
            }
        }
        model.append({
                         "firstRole": firstRole,
                         "secondRole": secondRole
                     });
    }
    return model;
}

function createThreeModel(listName, parentName){
    var model = Qt.createQmlObject('import QtQuick 2.4; ListModel {}', parentName);

    for (var i = 0; i < listName.length; i++) {
        var firstRole, secondRole, thirdRole = "";
        for (var j = 0; j < listName[i].length; j++) {
            var node = listName[i][j];
            switch(j) {
            case 0:
                firstRole = node;
                break;
            case 1:
                secondRole = node;
                break;
            case 2:
                thirdRole = node;
                break;
            }
        }
        model.append({
                         "firstRole": firstRole,
                         "secondRole":JSON.stringify(secondRole),
                         "thirdRole": thirdRole
                     });
    }
    return model;
}

function createSixModel(listName, parentName){
    var model = Qt.createQmlObject('import QtQuick 2.4; ListModel {}', parentName);

    for (var i = 0; i < listName.length; i++) {
        var firstRole, secondRole, thirdRole, forthRole, fifthRole, sixthRole = "";
        for (var j = 0; j < listName[i].length; j++) {
            var node = listName[i][j];
            switch(j) {
            case 0:
                firstRole = node;
                break;
            case 1:
                secondRole = node;
                break;
            case 2:
                thirdRole = node;
                break;
            case 3:
                forthRole = node;
                break;
            case 4:
                fifthRole = node;
                break;
            case 5:
                sixthRole = node;
                break;
            }
        }
        model.append({
                         "firstRole": firstRole,
                         "secondRole": secondRole,
                         "thirdRole": thirdRole,
                         "forthRole": forthRole,
                         "fifthRole": fifthRole,
                         "sixthRole": sixthRole
                     });
    }
    return model;
}

