$(document).ready(function () {


});

//Page inside a pop up
function RenderIframeModalDialog(dataModal, headerTitle)
{
    //HTML for the modal pop up
    var dialogHTML = '<div id="' + dataModal + '" class="md-modal colored-header md-effect-1">' +
                      '<div class="md-content">' +
                        '<div class="modal-header">' +
                          '<button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close" id="closeIframeModalDialog"><i class="icon s7-close"></i></button>' +
                           '<h4 class="modal-title">' + headerTitle + '</h4>' +
                         '</div>' +
                       '<div class="modal-body">' +
                      '</div>' +
                     '</div>' +
                    '</div>';

    //HTML for the modal pop up to be declared in the page
    var _dialogHTML = dialogHTML;
    $(dialogHTML).appendTo('body');

}


function DisplayIframeModalDialog(dataModal, dataToggle, url, iHeight, iWidth, IframeScroll) {

    //Button action called from a given page
    $('[data-toggle="' + dataToggle + '"]').click(function (e) {
        e.preventDefault();
        var _url = url;
        var _height = iHeight, _width = iWidth;
        $("#" + dataModal + " .modal-body").html('<iframe width="100%" height="' + iHeight + '" frameBorder="0"  scrolling="' + IframeScroll + '"' +
            'allowtransparency="true" src="' + _url + '" style="border:0;"></iframe>');
        $("#" + dataModal + " .md-content").css("width", iWidth);
        $(".modal-header").css("background-color", $(".top-wrapper").css("background-color"));
    
        //In case it's a modal inside a modal we use the parent of the parent
        $(".modal-header").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));
        //$('.btn-am-default').css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));     

     
    });
}


function DisplayIframeModalDialogSignature(dataModal, dataToggle, url, iHeight, iWidth, IframeScroll) {

    //Button action called from a given page
    $('[data-toggle="' + dataToggle + '"]').click(function (e) {
        e.preventDefault();
        var _url = url;
        var _height = iHeight, _width = iWidth;
        $("#" + dataModal + " .modal-body").html('<iframe width="100%" height="' + iHeight + '" frameBorder="0" name="ifrModal" scrolling="' + IframeScroll + '"' +
            'allowtransparency="true" src="' + _url + '" style="border:0;"></iframe>');
        $("#" + dataModal + " .md-content").css("width", iWidth);
        $(".modal-header").css("background-color", $(".top-wrapper").css("background-color"));

        //In case it's a modal inside a modal we use the parent of the parent
        $(".modal-header").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));
        //$('.btn-am-default').css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));  

        $("iframe[name=ifrModal]").load(function () {
            var iframe_body = window.ifrModal.document.getElementsByTagName("#page-indicator")[0];
            $(iframe_body).animate({ scrollTop: 600 }, 2000);
        });

     
    });
}


function DisplayIframeModalDialogNoButtom(dataModal, url, iHeight, iWidth, IframeScroll) {

    var _url = url;
    var _height = iHeight, _width = iWidth;
    $("#" + dataModal + " .modal-body").html('<iframe width="100%" height="' + iHeight + '" frameBorder="0" scrolling="' + IframeScroll + '"' +
        'allowtransparency="true" src="' + _url + '" style="border:0;"></iframe>');    
    $("#" + dataModal + " .md-content").css("width", iWidth);
    $(".modal-header").css("background-color", $(".top-wrapper").css("background-color"));

}


//Confirm pop up with accept and cancel buttons
function RenderConfimModalDialog(dataModal, confirmTitle, confirmMsg, idCloseButton, idAcceptButton)
{
    var dialogHTML = '<div id="' + dataModal + '" class="md-modal colored-header md-effect-1">' +
                 '<div class="md-content">' +
                   '<div class="modal-header">' +
                     '<button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><i class="icon s7-close"></i></button>' +
                      '<h4 class="modal-title robotobold">' + confirmTitle + '</h4>' +
                    '</div>' +
                  '<div class="modal-body">' +
                   '<div class="text-center">' +
                    '<p>' + confirmMsg + '</p>' +
                   '</div>' +
                 '</div>' +
                 '<div class="modal-footer">' +
                   '<button type="button" data-dismiss="modal" class="am-btn btn-am-white md-close" id="' + idCloseButton + '">Cancel</button>' +
                   '<button type="button" data-dismiss="modal" class="am-btn btn-am-default md-close" id="' + idAcceptButton + '">Accept</button>' +
                 '</div>' +
                '</div>' +
               '</div>';

    //HTML for the modal pop up to be declared in the page
    var _dialogHTML = dialogHTML;
    $(dialogHTML).appendTo('body');
   
}

//Confirm pop up with accept and cancel buttons
function RenderConfimModalDialogTextButton(dataModal, confirmTitle, confirmMsg, idCloseButton, idAcceptButton,cancelText,AcceptText) {
    var dialogHTML = '<div id="' + dataModal + '" class="md-modal colored-header md-effect-1">' +
                 '<div class="md-content">' +
                   '<div class="modal-header">' +
                     '<button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><i class="icon s7-close"></i></button>' +
                      '<h4 class="modal-title robotobold">' + confirmTitle + '</h4>' +
                    '</div>' +
                  '<div class="modal-body">' +
                   '<div class="text-center">' +
                    '<p>' + confirmMsg + '</p>' +
                   '</div>' +
                 '</div>' +
                 '<div class="modal-footer">' +
                   '<button type="button" data-dismiss="modal" class="am-btn btn-am-white md-close" id="' + idCloseButton + '"> '+ cancelText +' </button>' +
                   '<button type="button" data-dismiss="modal" class="am-btn btn-am-default md-close" id="' + idAcceptButton + '">' + AcceptText + '</button>' +
                 '</div>' +
                '</div>' +
               '</div>';

    //HTML for the modal pop up to be declared in the page
    var _dialogHTML = dialogHTML;
    $(dialogHTML).appendTo('body');

}


function DisplayConfimModalDialogTextButton(dataModal, modalHeight, modalWidth,cancelWidth, acceptWidth) {

    //Button action called from a given page
    $('[data-modal="' + dataModal + '"]').click(function (e) {
        e.preventDefault();

        //modal header to match branded color
        $("#" + dataModal + " .modal-header").css("background-color", $(".top-wrapper").css("background-color"));
        //In case it's a modal inside a modal we use the parent of the parent
        $(".modal-header").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

        $("#" + dataModal + " .modal-body").css("height", modalHeight);
        $("#" + dataModal + " .md-content").css("width", modalWidth);
        $("#" + dataModal + " .md-modal").css("top", "20");


        //Button to match branded color
        $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper").css("background-color"));
        //In case it's a modal inside a modal we use the parent of the parent
        $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

        //Button to match branded color
        $("#" + dataModal + " .btn-am-default").css("border-color", $(".top-wrapper").css("background-color"));
        //In case it's a modal inside a modal we use the parent of the parent
        $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

        //Color of the font
        $("#" + dataModal + " .btn-am-default").css("color", "#fff");

        //margin between cancel and accept buttons
        $("#" + dataModal + " .btn-am-default").css("margin-left", "10px");


        //margin between cancel and accept buttons
        $("#" + dataModal + " .am-btn").css("min-width", acceptWidth);
        $("#" + dataModal + " .am-btn").css("width", acceptWidth);

    });
}


function DisplayConfirmModalDialog(dataModal, modalHeight, modalWidth) {

    //Button action called from a given page
    $('[data-modal="' + dataModal + '"]').click(function (e) {
        e.preventDefault();

        //modal header to match branded color
        $("#" + dataModal + " .modal-header").css("background-color", $(".top-wrapper").css("background-color")); 
        //In case it's a modal inside a modal we use the parent of the parent
        $(".modal-header").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));
       
        $("#" + dataModal + " .modal-body").css("height", modalHeight);
        $("#" + dataModal + " .md-content").css("width", modalWidth);
        $("#" + dataModal + " .md-modal").css("top", "20");


        //Button to match branded color
        $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper").css("background-color"));
        //In case it's a modal inside a modal we use the parent of the parent
        $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

        //Button to match branded color
        $("#" + dataModal + " .btn-am-default").css("border-color", $(".top-wrapper").css("background-color"));
        //In case it's a modal inside a modal we use the parent of the parent
        $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

        //Color of the font
        $("#" + dataModal + " .btn-am-default").css("color", "#fff");

        //margin between cancel and accept buttons
        $("#" + dataModal + " .btn-am-default").css("margin-left", "10px");
    });
}


function DisplayConfirmModalDialogNoButton(dataModal, modalHeight, modalWidth) {

        //modal header to match branded color
        $("#" + dataModal + " .modal-header").css("background-color", $(".top-wrapper").css("background-color"));
        //In case it's a modal inside a modal we use the parent of the parent
        $(".modal-header").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

        $("#" + dataModal + " .modal-body").css("height", modalHeight);
        $("#" + dataModal + " .md-content").css("width", modalWidth);
        $("#" + dataModal + " .md-modal").css("top", "20");


        //Button to match branded color
        $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper").css("background-color"));
        //In case it's a modal inside a modal we use the parent of the parent
        $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

        //Button to match branded color
        $("#" + dataModal + " .btn-am-default").css("border-color", $(".top-wrapper").css("background-color"));
        //In case it's a modal inside a modal we use the parent of the parent
        $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

        //Color of the font
        $("#" + dataModal + " .btn-am-default").css("color", "#fff");

        //margin between cancel and accept buttons
        $("#" + dataModal + " .btn-am-default").css("margin-left", "10px");

}


//Alert pop up with no buttons
function RenderAlertModalDialog(dataModal, confirmTitle, confirmMsg) {
    var dialogHTML = '<div id="' + dataModal + '" class="md-modal colored-header md-effect-1">' +
                  '<div class="md-content">' +
                    '<div class="modal-header">' +
                      '<button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><i class="icon s7-close"></i></button>' +
                       '<h4 class="modal-title robotobold">' + confirmTitle + '</h4>' +
                     '</div>' +
                   '<div class="modal-body">' +
                    '<div class="text-center">' +
                     '<p>' + confirmMsg + '</p>' +
                    '</div>' +
                  '</div>' +
                  '<div class="modal-footer">' +                   
                  '</div>' +
                 '</div>' +
                '</div>';

    //HTML for the modal pop up to be declared in the page
    var _dialogHTML = dialogHTML;
    $(dialogHTML).appendTo('body');


}


function DisplayAlertModalDialogNoButton(dataModal, modalHeight, modalWidth) {


    //modal header to match branded color
    $("#" + dataModal + " .modal-header").css("background-color", $(".top-wrapper").css("background-color"));
    //In case it's a modal inside a modal we use the parent of the parent
    $(".modal-header").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

    $("#" + dataModal + " .modal-body").css("height", modalHeight);
    $("#" + dataModal + " .md-content").css("width", modalWidth);
    $("#" + dataModal + " .md-modal").css("top", "20");


    //Button to match branded color
    $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper").css("background-color"));
    //In case it's a modal inside a modal we use the parent of the parent
    $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

    //Button to match branded color
    $("#" + dataModal + " .btn-am-default").css("border-color", $(".top-wrapper").css("background-color"));
    //In case it's a modal inside a modal we use the parent of the parent
    $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

    //Color of the font
    $("#" + dataModal + " .btn-am-default").css("color", "#fff");

    //margin between cancel and accept buttons
    $("#" + dataModal + " .btn-am-default").css("margin-left", "10px");


}


//Confirm pop up with accept button
function RenderAcceptModalDialog(dataModal, confirmTitle, confirmMsg, idAcceptButton) {
    var dialogHTML = '<div id="' + dataModal + '" class="md-modal colored-header md-effect-1">' +
                 '<div class="md-content">' +
                   '<div class="modal-header">' +
                     '<button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><i class="icon s7-close"></i></button>' +
                      '<h4 class="modal-title robotobold">' + confirmTitle + '</h4>' +
                    '</div>' +
                  '<div class="modal-body">' +
                   '<div class="text-center">' +
                    '<p>' + confirmMsg + '</p>' +
                   '</div>' +
                 '</div>' +
                 '<div class="modal-footer text-center">' +              
                   '<button type="button" data-dismiss="modal" class="am-btn btn-am-default md-close" id="' + idAcceptButton + '">Accept</button>' +
                 '</div>' +
                '</div>' +
               '</div>';

    //HTML for the modal pop up to be declared in the page
    var _dialogHTML = dialogHTML;
    $(dialogHTML).appendTo('body');

}


function DisplayAcceptModalDialog(dataModal, modalHeight, modalWidth) {

    //Button action called from a given page
    $('[data-modal="' + dataModal + '"]').click(function (e) {
        e.preventDefault();

        //modal header to match branded color
        $("#" + dataModal + " .modal-header").css("background-color", $(".top-wrapper").css("background-color"));
        //In case it's a modal inside a modal we use the parent of the parent
        $(".modal-header").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

        $("#" + dataModal + " .modal-body").css("height", modalHeight);
        $("#" + dataModal + " .md-content").css("width", modalWidth);
        $("#" + dataModal + " .md-modal").css("top", "20");

        //Button to match branded color
        $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper").css("background-color"));
        //In case it's a modal inside a modal we use the parent of the parent
        $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

        //Button to match branded color
        $("#" + dataModal + " .btn-am-default").css("border-color", $(".top-wrapper").css("background-color"));
        //In case it's a modal inside a modal we use the parent of the parent
        $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

        //Color of the font
        $("#" + dataModal + " .btn-am-default").css("color", "#fff");

        //margin between cancel and accept buttons
        $("#" + dataModal + " .btn-am-default").css("margin-left", "10px");
    });
}


function DisplayAcceptModalDialogNoButton(dataModal,modalHeight, modalWidth) {

    //modal header to match branded color
    $("#" + dataModal + " .modal-header").css("background-color", $(".top-wrapper").css("background-color"));
    //In case it's a modal inside a modal we use the parent of the parent
    $(".modal-header").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

    $("#" + dataModal + " .modal-body").css("height", modalHeight);
    $("#" + dataModal + " .md-content").css("width", modalWidth);
    $("#" + dataModal + " .md-modal").css("top", "20");

  
    //Button to match branded color
    $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper").css("background-color"));
    //In case it's a modal inside a modal we use the parent of the parent
    $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

    //Button to match branded color
    $("#" + dataModal + " .btn-am-default").css("border-color", $(".top-wrapper").css("background-color"));
    //In case it's a modal inside a modal we use the parent of the parent
    $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

    //Color of the font
    $("#" + dataModal + " .btn-am-default").css("color", "#fff");

    //margin between cancel and accept buttons
    $("#" + dataModal + " .btn-am-default").css("margin-left", "10px");

}


function RenderProposalValidationModalDialog(dataModal)
{
    //HTML for the modal pop up
    var dialogHTML = '<div id="' + dataModal + '" class="md-modal colored-header md-effect-1">' +
                      '<div class="md-content">' +
                        '<div class="modal-header">' +
                          '<button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close" id="closeIframeModalDialog"><i class="icon s7-close"></i></button>' +
                           '<h4 class="modal-title">Mandatory Fields</h4>' +
                         '</div>' +
                       '<div class="modal-body">' +
                            '<ul class="unstyled list-striped" id="ulValidation">' +                           
                            '</ul>' +
                       '</div>' +
                         '<div class="modal-footer">' +                      
                           '<button type="button" data-dismiss="modal" class="am-btn btn-am-default md-close">Accept</button>' +
                         '</div>' +
                     '</div>' +
                    '</div>';

    //HTML for the modal pop up to be declared in the page
    var _dialogHTML = dialogHTML;
    $(dialogHTML).appendTo('body');
}

function DisplayProposalValidationModalDialogNoButton(dataModal, iHeight, iWidth) {

    var _height = iHeight, _width = iWidth;
    //$("#" + dataModal + " .modal-body").html('');
    $("#" + dataModal + " .md-content").css("width", iWidth);
    $(".modal-header").css("background-color", $(".top-wrapper").css("background-color"));

    $("#" + dataModal + " .md-content > div").css("font-size", '1em');

    //In case it's a modal inside a modal we use the parent of the parent
    $(".modal-header").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));
    //$('.btn-am-default').css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

    //Button to match branded color
    $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper").css("background-color"));
    //In case it's a modal inside a modal we use the parent of the parent
    $("#" + dataModal + " .btn-am-default").css("background-color", $(".top-wrapper", window.parent.parent.document).css("background-color"));

    //Color of the font
    $("#" + dataModal + " .btn-am-default").css("color", "#fff");

}



//For this to work the control validation must have the 
//attribute "data-val-modal" with a value to be displayed on the modal
function GetValFieldsFromValidator(bootstrapValidator)
{
    var valControl = bootstrapValidator;
    var resultFields = [];

    //look for invalid fields in the array
    if (valControl.$invalidFields.length > 0)
    {
        //loop through each invalid field
        for (var i = 0; i < valControl.$invalidFields.length; i++) {

            //get the field attribute which contains the name to be displayed
            var attrValName = $(valControl.$invalidFields[i].outerHTML).attr('data-val-modal');

            if (attrValName != undefined || attrValName != null)
            {
                resultFields.push(attrValName);
            }            
        }
    }

    //return the array with the fields names
    return resultFields;
}

function SetHTMLValidationFields(dataModal,fields)
{
    //clean the body of ul element of any child elements
    $("#" + dataModal + " .modal-body > ul").html('');

    //add each element from the json object to the select list
    $.each(fields, function (key, value) {
        $.each(this, function (k, v) {
            $('#' + dataModal + ' > div > div.modal-body > ul').append($('<li class="text-no-wrap"><i class="fa fa-times text-danger"></i><strong> ' + v + ' <strong></li>'));
        });
    });

}


//Close any modal pop up currently displayed on screen
function closeModal(dataModal) {
    $("#" + dataModal).removeClass('md-show');
}

function updateIframeModalDialogTitle(dataModal, title) {
    $('#' + dataModal + ' > div > div.modal-header > h4').html(title);
}

function removeIframeDialogClose(dataModal)
{
    $('#' + dataModal + ' > div > div.modal-header > button').hide();
}


//*****
function RenderConfimModalDialogAcceptButton(dataModal, confirmTitle, confirmMsg, idAcceptButton) {
    var dialogHTML = '<div id="' + dataModal + '" class="md-modal colored-header md-effect-1">' +
                 '<div class="md-content">' +
                   '<div class="modal-header">' +
                     '<button type="button" data-dismiss="modal" aria-hidden="true" class="close md-close"><i class="icon s7-close"></i></button>' +
                      '<h4 class="modal-title robotobold">' + confirmTitle + '</h4>' +
                    '</div>' +
                  '<div class="modal-body">' +
                   '<div class="text-center">' +
                    '<p>' + confirmMsg + '</p>' +
                   '</div>' +
                 '</div>' +
                 '<div class="modal-footer">' +
                   '<button type="button" data-dismiss="modal" class="am-btn btn-am-default md-close" id="' + idAcceptButton + '">Accept</button>' +
                 '</div>' +
                '</div>' +
               '</div>';

    //HTML for the modal pop up to be declared in the page
    var _dialogHTML = dialogHTML;
    $(dialogHTML).appendTo('body');

}
