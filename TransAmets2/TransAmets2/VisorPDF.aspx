<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VisorPDF.aspx.vb" Inherits="TransAmets2.VisorPDF" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="-1"/>
    <meta http-equiv="cache-control" content="no-store"/>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="AMETS- Operador de Transportes" />
    <link rel="icon" href="favicon1.ico" />
    <title>:: AMETS :: Impresión documentos</title>
    <!--fonts-->
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="Scripts/jquery-ui-1.11.4/jquery-ui.min.css" rel="stylesheet" />
    <link href="css/bootstrap-dialog.min.css" rel="stylesheet" />

    <!-- Custom styles for this template -->
    <link href="css/login.css" rel="stylesheet" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrapValidator.min.css" rel="stylesheet" />
    <script type="text/javascript" src="Scripts/jquery-1.12.1.min.js"></script>
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
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" EnablePartialRendering="true" EnableViewState="true" AsyncPostBackTimeout="999999" >
        </asp:ScriptManager>
    <div style="width:100%; height:100%; overflow:visible;">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" SizeToReportContent="true" ZoomMode="FullPage" ShowExportControls="true" ShowPrintButton="true" ShowZoomControl="true" AsyncRendering="false" Width="100%" Height="100%"></rsweb:ReportViewer>
    </div>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" ></asp:ObjectDataSource>
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
        <input name="hdnTipoErrors" id="hndTipoError" runat="server" type="hidden" />
        <input name="hdnTitulo" id="hdnTitulo" runat="server" type="hidden" />
        <input name="hdnRedirect" id="hdnRedirect" runat="server" type="hidden" />
        <input name="hdnReload" id="hdnReload" runat="server" type="hidden" />

        <input name="hdnFilePDF" id="hdnFilePDF" runat="server" type="hidden" />
    </form>
    <script type="text/javascript">
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
            CompruebaErrores();

            debugger;
            if ($("#hdnFilePDF").val() != "") {
                var carpetaraiz = '<%=Session("UrlRaizAplicacion")%>';
                var filepdf = carpetaraiz + $("#hdnFilePDF").val();
                //window.open(filepdf, "_blank");
            }
        });
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
        debugger;
    </script>
</body>
</html>
