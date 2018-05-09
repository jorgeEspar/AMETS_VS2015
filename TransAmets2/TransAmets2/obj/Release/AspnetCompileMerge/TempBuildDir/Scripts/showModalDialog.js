(function () {

    window.showModalDialog2 = window.showModalDialog || function (url, arg, opt) {
        url = url || ''; //URL of a dialog
        arg = arg || null; //arguments to a dialog
        opt = opt || 'dialogWidth:300px;dialogHeight:200px'; //options: dialogTop;dialogLeft;dialogWidth;dialogHeight or CSS styles
        var caller = showModalDialog2.caller.toString();

        var tmpDialog;
        tmpDialog = top.document.body.appendChild(top.document.createElement('dialog'));
        tmpDialog.setAttribute('style', opt.replace(/dialog/gi, ''));
        var dialog_id = 'dialog';
        if (window.top != null) {
            if (window.top.own_dialog_flag != null) {
                dialog_id = 'dialog-2';
            }
        }

        tmpDialog.innerHTML = '<a href="#" id="' + dialog_id + '-close" style="display:none; position: absolute; top: 0; right: 4px; font-size: 20px; color: #000; text-decoration: none; outline: none;">&times;</a><iframe id="' + dialog_id + '-body" src="' + url + '" style="border: 0; width: 100%; height: 100%;"></iframe>';
        top.document.getElementById(dialog_id + '-body').contentWindow.dialogArguments = arg;
        top.document.getElementById(dialog_id + '-close').addEventListener('click', function (e) {
            e.preventDefault();
            tmpDialog.close();
        });
        tmpDialog.showModal();

        var isNext = false;
        var nextStmts = caller.split('\n').filter(function (stmt) {
            if (isNext || stmt.indexOf('showModalDialog2(') >= 0)
                return isNext = true;
            return false;
        });
        tmpDialog.addEventListener('close', function () {
            if (window.top.own_dialog_flag != null) {
                dialog_id = 'dialog-2';
            }
            else {
                dialog_id = 'dialog';
            }
            var returnValue = top.document.getElementById(dialog_id + '-body').contentWindow.returnValue;
            top.document.body.removeChild(tmpDialog);
            nextStmts[0] = nextStmts[0].replace(/(window\.)?showModalDialog2\(.*\)/g, JSON.stringify(returnValue));
            eval('{\n' + nextStmts.join('\n'));
        });

        pushDialog(tmpDialog);

    };
    
    window.showModalDialog = window.showModalDialog || function (url, arg, opt) {
        url = url || ''; //URL of a dialog
        arg = arg || null; //arguments to a dialog
        opt = opt || 'dialogWidth:300px;dialogHeight:200px'; //options: dialogTop;dialogLeft;dialogWidth;dialogHeight or CSS styles
        var caller = showModalDialog.caller.toString();

        var tmpDialog;
        tmpDialog = top.document.body.appendChild(top.document.createElement('dialog'));
        tmpDialog.setAttribute('style', opt.replace(/dialog/gi, ''));
        var dialog_id = 'dialog';
        if (window.top != null) {
            if (window.top.own_dialog_flag != null) {
                dialog_id = 'dialog-2';
            }
        }
        
        tmpDialog.innerHTML = '<a href="#" id="' + dialog_id + '-close" style="display:none; position: absolute; top: 0; right: 4px; font-size: 20px; color: #000; text-decoration: none; outline: none;">&times;</a><iframe id="' + dialog_id  + '-body" src="' + url + '" style="border: 0; width: 100%; height: 100%;"></iframe>';
        top.document.getElementById(dialog_id + '-body').contentWindow.dialogArguments = arg;
        top.document.getElementById(dialog_id + '-close').addEventListener('click', function (e) {
            e.preventDefault();
            tmpDialog.close();
        });
        tmpDialog.showModal();

        var isNext = false;
        var nextStmts = caller.split('\n').filter(function (stmt) {
            if (isNext || stmt.indexOf('showModalDialog(') >= 0)
                return isNext = true;
            return false;
        });
        tmpDialog.addEventListener('close', function () {
            if (window.top.own_dialog_flag != null) {
                dialog_id = 'dialog-2';
            }
            else {
                dialog_id = 'dialog';
            }
            var returnValue = top.document.getElementById(dialog_id + '-body').contentWindow.returnValue;
            top.document.body.removeChild(tmpDialog);
            nextStmts[0] = nextStmts[0].replace(/(window\.)?showModalDialog\(.*\)/g, JSON.stringify(returnValue));
            eval('{\n' + nextStmts.join('\n'));
        });
        
        pushDialog(tmpDialog);
        throw 'Execution stopped until showModalDialog is closed';
    };

})();

function pushDialog(obj) {
    if (window.top.own_dialog_flag != null) {
        window.top.dialog_own = obj;
    }
    else {
        window.top.dialog = obj;
    }
}

function popDialog() {
    // Sacar el ultimo y borrarlo del array            
    var aux;
    if (window.top.own_dialog_flag != null) {
        aux = window.top.dialog_own;
        window.top.own_dialog_flag = null;
    }
    else {
        aux = window.top.dialog;
    }
    
    if (aux) {
       
        aux.close();
    }
    window.top.dialog = null;
}