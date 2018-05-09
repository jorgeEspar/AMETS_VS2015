<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="TransAmets2.Login" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="-1" />
    <meta http-equiv="cache-control" content="no-store" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="AMETS- Operador de Transportes" />
    <link rel="icon" href="favicon1.ico" />
    <title>:: AMETS :: Login usuario</title>
    <!--fonts-->
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="Scripts/jquery-ui-1.11.4/jquery-ui.min.css" rel="stylesheet" />
    <link href="css/bootstrap-dialog.min.css" rel="stylesheet" />

    <!-- Custom styles for this template -->
    <link href="css/login.css" rel="stylesheet" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrapValidator.min.css" rel="stylesheet" />
    <script type="text/javascript" src="Scripts/jquery-1.12.1.min.js"></script>
    <!--<script type="text/javascript" src="Scripts/Notify.js"></script>   -->
    <script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
    
    <style type="text/css">
        html, body, form {height: 100%;margin: 0; padding: 0;}
        #CapaProgress
        {
            position:fixed;
            top:0px;
            bottom:0px;
            left:0px;
            right:0px;
            overflow:hidden;
            padding:0;
            margin:0;
	        background-color:#F0F0F0;
	        filter:alpha(opacity=80); 
	        opacity:0.8;
            z-index:100000;
        }
        #Progress {
            position:fixed;
            top:40%;
            left:40%;
            /*height:20%;
            width:20%;*/
            z-index:100001;
            background-color:#FFFFFF;
            border: 1px solid Gray;
            /*background-image: url('../../images/procesando.gif');*/
            background-repeat:no-repeat;
            background-position: center;
            text-align:center;
            vertical-align:middle;
        }
        .login .btn {
            margin-top: 0px !important;
        }
    </style>
    <script type="text/javascript">
        
    </script>
</head>
<body class="login">
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" EnablePageMethods="true" EnablePartialRendering="true" EnableViewState="true" AsyncPostBackTimeout="999999" >
            
        </asp:ScriptManager>

        <!-- Page Content login -->
        <div id="Table1" class="container login" style="margin-top:15px;">
            <div class="row">
                <div class="col-md-2 col-sm-2">
                    <div class="col-xs-6">
                        <div style="background-color:White; opacity:1; border:1px solid Gray; width:240px;margin:0px; padding:0px;text-shadow: 2px 2px 4px #ffffff;">
                            <img src="./images/amets_trans.png" alt="" width="240"/>
                        </div>
                    </div>
                </div>
                <div class="col-md-10 col-sm-10 text-center">
                    <label style="font-family:Tahoma, Verdana; font-size: 35px; color: #ffffff; font-weight:bold;text-shadow: 2px 2px 4px #299826;">AMETS - Operador de Transportes</label>
                </div>
            </div>

            <div class="col-md-5 col-sm-9 redondear" style="margin-top:80px;padding-left:60px;">
                <div class="form-group">
                    <label for="username">Usuario:</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="ico-user"></i>
                        </span>
                        <input name="txtUser" id="txtUser" runat="server" class="form-control" placeholder="Usuario" type="text" value="amets" />
                    </div>
                    <span class="help-block"></span>
                </div>


                <div class="form-group">
                    <label for="username2">Contraseña:</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <i class="ico-candado"></i>
                        </span>
                        <input type="password" name="txtPassword" id="txtPassword" runat="server" class="form-control" placeholder="Contraseña" value="amets" />
                    </div>
                    <span class="help-block"></span>
                </div>

                <asp:Button ID="btnLogin" CssClass="btn btn-default btn-block active" runat="server" Text="Aceptar" />

                <label id="ErrorMessage" class="ErrorMessage"></label>
            </div>

            <span class="help-block"></span>
        </div>
        
        <div id="divWarning"></div>
        
        <div id="CapaMensajes" class="modal fade">
            <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Error</h4>
                </div>
                <div class="modal-body" style="display:;width:100%; max-height:600px; overflow-y : auto;">
                    <p>
                        <label id="lblErrores"></label>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Aceptar</button>
                    <input type="hidden" id="hndEndSession" runat="server" />
                </div>
            </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <asp:UpdatePanel ID="UpdateProgress1" runat="server">
        <ContentTemplate>
            <div id="CapaProgress"></div>
            <div id="Progress">
                <table style="width: 250px; height:70px;">
                <tr style="height:50%;">
                    <td><h6><p style="text-align:center"><b>Procesando... <br /></b>
                        <h6></h6>
                        <h6></h6>
                        <h6></h6>
                        <h6></h6>
                        </h6></td>
                </tr>
                <tr style="height:50%;">
                    <td><img src="./images/procesando.gif" /></td>
                </tr>
                </table>
            </div>    
        </ContentTemplate>
        </asp:UpdatePanel>

        <input name="hdnControlErrors" id="hdnControlJS" runat="server" type="hidden" />
        <input name="hdnTipoErrors" id="hndTipoError" runat="server" type="hidden">
        <input name="hdnTitulo" id="hdnTitulo" runat="server" type="hidden">
        <input name="hdnRedirect" id="hdnRedirect" runat="server" type="hidden">
        <input name="hdnReload" id="hdnReload" runat="server" type="hidden">
    </form>
    <script type="text/javascript">
        //curruserid = "";
        $(document).keypress(function (e) {
            if (e.keyCode === 13) {
                $("#<%= btnLogin.ClientID%>")[0].click();
            }
        });
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_initializeRequest(InitializeRequest);
        prm.add_endRequest(EndRequest);
        var postBackElement;
        function InitializeRequest(sender, args) {
            if (prm.get_isInAsyncPostBack()) {
                args.set_cancel(true);
            }
            postBackElement = args.get_postBackElement();
            //$("#<%= UpdateProgress1.ClientID%>").style.display = "block";
            //$("#<%= UpdateProgress1.ClientID%>").show();
            $("#<%= UpdateProgress1.ClientID%>").css("display", "block");
        }
        function EndRequest(sender, args) {
            $("#<%= UpdateProgress1.ClientID%>").hide();
        }
        function AbortPostBack() {
            $("#<%= UpdateProgress1.ClientID%>").hide();
            if (prm.get_isInAsyncPostBack()) {
                prm.abortPostBack();
            }
        }
        function setCookie(key, value, path) {
            if (path == '') { path = '/'; }
            var expires = new Date();
            expires.setTime(expires.getTime() + 31536000000); //1 year
            document.cookie = key + '=' + value + ';expires=' + expires.toUTCString() + ';path=' + path;
        }
        function getCookie(key) {
            var keyValue = document.cookie.match('(^|;) ?' + key + '=([^;]*)(;|$)');
            return keyValue ? keyValue[2] : null;
        }
        function CapaProcesando() {
            waitingDialog.show('Processing');
        }
        var waitingDialog = waitingDialog || (function ($) {
            'use strict';

            // Creating modal dialog's DOM
            var $dialog = $(
                '<div class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true" style="padding-top:15%; overflow-y:visible;">' +
                '<div class="modal-dialog modal-m">' +
                '<div class="modal-content">' +
                    '<div class="modal-header"><h3 style="margin:0;"></h3></div>' +
                    '<div class="modal-body">' +
                        '<div class="progress progress-striped active" style="margin-bottom:0;"><div class="progress-bar" style="width: 100%"></div></div>' +
                    '</div>' +
                '</div></div></div>');

            return {
                /**
                 * Opens our dialog
                 * @param message Custom message
                 * @param options Custom options:
                 * 				  options.dialogSize - bootstrap postfix for dialog size, e.g. "sm", "m";
                 * 				  options.progressType - bootstrap postfix for progress bar type, e.g. "success", "warning".
                 */
                show: function (message, options) {
                    // Assigning defaults
                    if (typeof options === 'undefined') {
                        options = {};
                    }
                    if (typeof message === 'undefined') {
                        message = 'Loading';
                    }
                    var settings = $.extend({
                        dialogSize: 'm',
                        progressType: '',
                        onHide: null // This callback runs after the dialog was hidden
                    }, options);

                    // Configuring dialog
                    $dialog.find('.modal-dialog').attr('class', 'modal-dialog').addClass('modal-' + settings.dialogSize);
                    $dialog.find('.progress-bar').attr('class', 'progress-bar');
                    if (settings.progressType) {
                        $dialog.find('.progress-bar').addClass('progress-bar-' + settings.progressType);
                    }
                    $dialog.find('h3').text(message);
                    // Adding callbacks
                    if (typeof settings.onHide === 'function') {
                        $dialog.off('hidden.bs.modal').on('hidden.bs.modal', function (e) {
                            settings.onHide.call($dialog);
                        });
                    }
                    // Opening dialog
                    $dialog.modal();
                },
                /**
                 * Closes dialog
                 */
                hide: function () {
                    $dialog.modal('hide');
                }
            };

        })(jQuery);

        function EndRequestHandler(sender, args) {
            $("#<%= UpdateProgress1.ClientID%>").hide();

            CompruebaErrores();
        }
        $(document).ready(function () {
            $(function () {
                
            });

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

            $("#<%= UpdateProgress1.ClientID%>").hide();          
            
            $("#txtUser").keydown(function (event) {
                //if (event.shiftKey) { event.preventDefault(); }
                if (event.keyCode == 13) {
                    $("#<%= btnLogin.ClientID%>")[0].click();
                }
            });
            $("#txtPassword").keydown(function (event) {
                //if (event.shiftKey) { event.preventDefault(); }
                if (event.keyCode == 13) {
                    $("#<%= btnLogin.ClientID%>")[0].click();
                }
            });
            
            $("#txtUser").focus();

            CompruebaErrores();
            setTimeout(autologin, 100);
        });
        function autologin() {
            var user = $("#txtUser").val();
            var pwd = $("#txtPassword").val();          
            pwd = $("#txtPassword", $("#form1")).val();
            var pwd2 = document.getElementById("txtPassword").value;
            if (pwd2 != "") { pwd = pwd2;}
            if (user != "" && pwd != "") {
                $("#<%= btnLogin.ClientID%>")[0].click();
            }
        }
        function CompruebaErrores() {
            var EndSession = $('#hndEndSession').val();
            if (EndSession == "S") {
                $('#lblErrores').html("Su sesión ha terminado</br>Por favor, identifíquese.");
            } else {
                var errores = $('#hdnControlJS').val();
                if (errores != '') {
                    errores = errores.replace(/\\n/gi, "<br/>");
                    $('#lblErrores').html(errores);

                    var modal = $('#CapaMensajes');
                    var tipomsg = $('#hndTipoError').val();
                    var titulomsg = $('#hdnTitulo').val();
                    if (titulomsg == '') { titulomsg = 'MENSAJE'; }
                    modal.find('.modal-title').text(titulomsg);

                    switch (tipomsg) {
                        case 'AVISO':
                            modal.find('.modal-header').css({
                                "background-color": "#F0AD4E",
                                "color": "#fff"
                            });
                            break;
                        case "ERROR":
                            modal.find('.modal-header').css({
                                "background-color": "#D9534F",
                                "color": "#fff"
                            });
                            break;
                        case "OK":
                            modal.find('.modal-header').css({
                                "background-color": "#5CB85C",
                                "color": "#fff"
                            });
                            break;
                        default:
                            modal.find('.modal-header').css({
                                "background-color": "#428BCA",
                                "color": "#fff"
                            });
                    }
                    $('#CapaMensajes').modal('show');
                    setTimeout(function () { $('#btn_Mensajes_Aceptar').focus(); }, 1000);
                }
            }
        }

        function MuestraError(msg, tipo, titulo) {
            $('#hdnControlJS').val(msg);
            $('#hndTipoError').val(tipo);
            $('#hdnTitulo').val(titulo);
            if (msg != '') {
                CompruebaErrores();
            }
        }
        $('#CapaMensajes').on('hide.bs.modal', function (event) {
            $('#hdnControlJS').val('');
            var EndSession = $('#hndEndSession').val();
            if (EndSession == "S") {
                //document.location.href = '';
            }
        });
        $('#CapaMensajes').on('click', '#btnCapaMensajesAceptar', function (e) {
            var hdnRedirect = $("#hdnRedirect").val();
            var hdnReload = $("#hdnReload").val();
            if (hdnRedirect != "") {
                //document.location.href = hdnRedirect;
            } else {
                if (hdnReload != "") {
                    location.reload();
                }
            }
        });
    </script>
</body>
</html>
