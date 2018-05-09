<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FacturasX.aspx.vb" Inherits="TransAmets2.FacturasX" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Factura Nueva</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=9;IE=11;IE=edge" />

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrapValidator.min.css" rel="stylesheet" />
    <link href="css/daterangepicker.css" rel="stylesheet" />
    <link href="css/bootstrap-select.css" rel="stylesheet" />
    <link href="Scripts/jquery-ui-1.11.4/jquery-ui.min.css" rel="stylesheet" />
    <link href="css/bootstrap-dialog.min.css" rel="stylesheet" />
    <link href="css/font-awesome/font-awesome.min.css" rel="stylesheet" />
    <link href="css/styles_main.css" rel="stylesheet" />
    <link href="css/hover-min.css" rel="stylesheet" media="all">
    <!--[if gte IE 9]>
     <link href="css/i9_btn_fix.css" rel="stylesheet" type="text/css"  />
    <![endif]-->
    <script type="text/javascript" src="Scripts/jquery-1.12.1.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery-ui-1.11.4/jquery-ui.min.js"></script> 
    <script type="text/javascript" src="Scripts/json2.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="Scripts/popper.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="Scripts/moment-with-locales.js"></script>
    <script type="text/javascript" src="Scripts/daterangepicker.js"></script>
    <!--<script type="text/javascript" src="Scripts/respond.min.js"></script>-->
    <script type="text/javascript" src="Scripts/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap-dialog.min.js"></script>
    <script type="text/javascript" src="Scripts/master.js"></script>
    <script type="text/javascript" src="Scripts/gridviewScroll.min.js"></script>
    <style type="text/css">
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
        
        #grSelPortesCopy {margin: 0px !important; padding: 0px !important;height: 30px !important;}
        #grSelPortes{margin: 0px !important; padding: 0px !important;}
        #grSelPortesPagerBottom {margin-top:10px;}
        #grSelPortesHeaderCopy{ text-align: center;}
        #grSelPortes{
            font-size: 10px !important;
        }
        /*grSelPortesVerticalRail{top:30px !important;}
        #grSelPortesVertical_BIMG{top:485px !important;}
        #grSelPortesHorizontalRail{top:485px !important;}
        #grSelPortesHorizontalBar{top:485px !important;}
        #grSelPortesHorizontal_LIMG{top:485px !important;}
        #grSelPortesHorizontal_RIMG{top:485px !important;}*/
            
        @media screen and (min-width: 768px) {
	        #CapaMensajes .modal-dialog  {width:700px;}
        }
    </style>
    <script type="text/javascript" language="javascript">
		var prm;
		var postBackElement;
		$(document).ready(function () {
		    prm = Sys.WebForms.PageRequestManager.getInstance();
		    prm.add_initializeRequest(InitializeRequest);
		    prm.add_endRequest(EndRequest);

		    recarga_eventos_jquery();

		    $('#UpdateProgress1').hide();
		    CompruebaErrores();
		});
        function pageLoad() {
		    recarga_eventos_jquery();
		}
		function recarga_eventos_jquery() {
		    var gridWidth = $("#UPanelPortesSel").width();// $(window).width();
		    var gridHeight = $(window).height() - 124;
		    //var headerHeight1 = $("#ctl00_MainContent_UP_Filtros_Portes").height();
		    //var headerHeight2 = $("divAddPortes .panel-body").height();
		    //gridHeight = $("#cajaGridSelPortes").height()-200;// headerHeight2 - headerHeight1;
		    //alert("headerHeight=" + headerHeight);
		    //debugger;
		    var tGrid = '<%=grSelPortes.ClientID%>';
		    $objGrid = $("#<%=grSelPortes.ClientID%>");
		    if ($objGrid) {
		        $objGrid.gridviewScroll({
		            width: gridWidth,
		            height: 300,
		            arrowsize: 30,
		            varrowtopimg: "images/arrowvt.png",
		            varrowbottomimg: "images/arrowvb.png",
		            harrowleftimg: "images/arrowhl.png",
		            harrowrightimg: "images/arrowhr.png",
		            wheelstep: 50,
                    startVertical: $objGrid.val(), 
                    startHorizontal: $objGrid.val(), 
                    onScrollVertical: function (delta) { 
                        $objGrid.val(delta); 
                    }, 
                    onScrollHorizontal: function (delta) { 
                        $objGrid.val(delta); 
                    }
		        });
                /*var gridViewScroll = new GridViewScroll({
		            elementID: tGrid, // Target element id
		            width: 1080, // Integer or String(Percentage)
		            height: 550, // Integer or String(Percentage)
		            freezesize: 2,
		            arrowsize: 30,
		            varrowtopimg: "./images/arrowvt.png",
		            varrowbottomimg: "./images/arrowvb.png",
		            harrowleftimg: "./images/arrowhl.png",
		            harrowrightimg: "./images/arrowhr.png",
		            headerrowcount: 1,
		            railsize: 16,
		            barsize: 8
		            /*onscroll: function (scrollTop, scrollLeft) {
		                //console.log("scrollTop: " + scrollTop + ", scrollLeft: " + scrollLeft);
		            }
		            freezeColumn : false, // Boolean
		            freezeFooter : true, // Boolean
		            freezeColumnCssClass : "", // String
		            freezeFooterCssClass : "", // String
		            freezeHeaderRowCount : 0, // Integer
		            freezeColumnCount : 0 // Integer
		        });
		        gridViewScroll.enhance();*/
		        /*gridHeight = $("#grSelPortesPanelItemContent").height();
		        $("#grSelPortesVertical_BIMG").css("top", (gridHeight-30) + "px !important");
		        $("#grSelPortesHorizontalRail").css("top", gridHeight + "px !important");
		        $("#grSelPortesHorizontalBar").css("top", gridHeight + "px !important");
		        $("#grSelPortesHorizontal_LIMG").css("top", gridHeight + "px !important");
		        $("#grSelPortesHorizontal_RIMG").css("top", gridHeight + "px !important");*/
		    }
		    var jorge = "";
		    jorge = "1";
		}
        function InitializeRequest(sender, args) {
            $("#hdnRedirect").val('');
            $("#hdnReload").val('');
            $('#hdnControlJS').val('');
            if (prm.get_isInAsyncPostBack()) {
                args.set_cancel(true);
            }
            postBackElement = args.get_postBackElement();
            $("UpdateProgress1").css("display", "block");
        }
        function EndRequest(sender, args) {
            $('#UpdateProgress1').hide();

            pageLoad();
            CompruebaErrores();
        }
        function AbortPostBack() {
            $('#UpdateProgress1').hide();
            if (prm.get_isInAsyncPostBack()) {
                prm.abortPostBack();
            }
            pageLoad();
            CompruebaErrores();
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

        var DialogMensajes;

        function MuestraMensaje(mensaje, tipo, titulo, redirect) {
            $("#hdnControlJS").val(mensaje);
            switch (tipo) {
                case 1:
                    $("#hndTipoError").val("ERROR"); // color ROJO
                    if (titulo == "") { titulo = "ERROR"; }
                    break;
                case 2:
                    $("#hndTipoError").val("AVISO"); // color AMARILLO
                    if (titulo == "") { titulo = "AVISO"; }
                    break;
                case 3:
                    $("#hndTipoError").val("OK"); // color VERDE
                    if (titulo == "") { titulo = "MENSAJE"; }
                    break;
                default:
                    $("#hndTipoError").val("MENSAJE"); // color AZUL
                    if (titulo == "") { titulo = "MENSAJE"; }
                    break;
            }
            $("#hdnTitulo").val(titulo);
            $("#hdnRedirect").val(redirect);
            CompruebaErrores();
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
        function SetGridViewHoverOn(gridView) {
            if (gridView != null) {
                gridView.originalstyle = gridView.style.backgroundColor;
                gridView.style.backgroundColor = '#FFFFCC';
            }
        }
        function SetGridViewHoverOff(gridView) {
            if (gridView != null) {
                gridView.style.backgroundColor = gridView.originalstyle;
            }
        }
    </script>
</head>
<body>
    <form id="Form1" method="post" runat="server" style="width:98%" class="pd-l-0 pd-r-0">
        <asp:ScriptManager runat="server" EnablePageMethods="true" EnablePartialRendering="true" EnableViewState="true" AsyncPostBackTimeout="999999" ></asp:ScriptManager>
        <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Always">
            <ContentTemplate>
                <asp:HiddenField ID="hdnFacturaId" runat="server" />
                <asp:HiddenField ID="hdnClienteId" runat="server" />
                <asp:HiddenField ID="hndPrimeravez" runat="server" Value="1" />
                <asp:HiddenField ID="hndAlta" runat="server" Value="1" />
                <asp:HiddenField ID="hndBaja" runat="server" Value="0" />

                <input name="hdnControlErrors" id="hdnControlJS" runat="server" type="hidden"/>
                <input name="hdnTipoErrors" id="hndTipoError" runat="server" type="hidden"/>
                <input name="hdnTitulo" id="hdnTitulo" runat="server" type="hidden"/>
                <input name="hdnRedirect" id="hdnRedirect" runat="server" type="hidden"/>
                <input name="hdnReload" id="hdnReload" runat="server" type="hidden"/>
            </ContentTemplate>
         </asp:UpdatePanel>

        <div class="container Multiopcion">
            <div class="row" style="margin-top: 0px !important; margin-bottom: 15px !important">
                <div class="col-md-3 col-sm-3 text-left pd-l-0">
                    <h1><label id="lblTituloPag" runat="server">NUEVA FACTURA</label></h1>
                </div>
                <div class="col-md-1 col-sm-1 text-center" style="margin-top: 20px;">
                
                </div>
                <div class="col-md-8 col-sm-8 pd-r-0" style="margin-top: 20px;">
                    <div style="float:right;">
                        <asp:UpdatePanel runat="server" ID="UPCODCLI" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="col-md-3 col-sm-3 col-xs-3 form-group pd-l-0">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-user"></i> Cliente</span>
                                        <asp:TextBox class="string form-control" id="txtCodCli" runat="server" maxlength="4"  AutoPostBack="true" Text="" Height="100%"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-9 col-sm-9 col-xs-9 form-group pd-l-0 pd-r-0">
                                <div class="input-group" style="width:100%;">
                                    <asp:TextBox class="string form-control" id="txtCliente" runat="server" maxlength="40" Text="" ReadOnly="true"></asp:TextBox>
                                    <asp:Label id="lbldeleteprescriptor" runat="server" class="input-group-addon btn pd-l-5 pd-r-5" onclick="DeleteCliente();"><span id="ico_delete_cliente" class="fa fa-times"></span></asp:Label>
                                    <asp:Label id="lblicobuscadorPrescriptor" runat="server" class="input-group-addon btn btn_ico activo" onclick="OpenBuscadorClientes();"><span id="ico_buscador_cliente" class="fa fa-search"></span></asp:Label>
                                </div>
                            </div>
                        </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>

            <div class="row container_summary">
                <div class="col-md-12 col-sm-12 pd-l-0 pd-r-0">
                    <asp:UpdatePanel runat="server" ID="UPanelPortesSel" UpdateMode="Conditional">
                    <ContentTemplate>                    
                        <!-- NO REGISTROS -->
                        <div id="NoRegs_Datos" runat="server" class="row col-md-12 col-sm-12 no-results text-center">
                            <div><i class="fa fa-exclamation-triangle"></i></div>
                            <div>Ningún Porte seleccionado con el criterio indicado</div>
                        </div>
                        <!-- TOTAL ROWS ============================= -->
                        <div class="row col-md-12 col-sm-12">
                            <div id="TotalRows_Datos" runat="server" class="col-md-4 col-sm-4 pd-l-0">
                                <span><asp:Label runat="server" id="lblTotalRows_Datos" text=""></asp:Label></span>
                            </div>
                            <div id="TotalPages_Datos" runat="server" class="col-md-8 col-sm-8 text-right">
                                <span><asp:Label runat="server" id="lblTotalVenta" text=""></asp:Label></span>
                            </div>
                        </div>
                        <asp:GridView ID="grSelPortes" runat="server" 
				            Width="100%" 
                            Height="500"
				            PageSize="50" 
				            AutoGenerateColumns="false" 
                            CssClass="tab-GridView table-sm pd-l0 pd-r-0"
				            AllowSorting="false" 
                            AllowPaging="false"
                            Font-Size="Small">
				            <AlternatingRowStyle />
				            <RowStyle />
				            <HeaderStyle />
                            <PagerStyle CssClass="GridviewScrollPager" /> 
                            <PagerSettings  Mode="NumericFirstLast" FirstPageText="|<" PreviousPageText="<" NextPageText=">" LastPageText=">|" />
                            <PagerStyle HorizontalAlign = "Right" CssClass="pagination-ys" />
				            <Columns>
                                <asp:TemplateField HeaderText="PORTE" ItemStyle-Width="5%" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="LEFT" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdnAUTOPORTE" runat="server" Value='<%# Bind("AUTOPORTE")%>' />
                                        <asp:Label runat="server" id="lblNumpor" CssClass="" text='<%# Bind("NUMPOR")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="FECHA" ItemStyle-Width="7%" HeaderStyle-Width="7%" ItemStyle-HorizontalAlign="LEFT" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" id="lblFechaPorte" CssClass="" text='<%# Eval("FECHA", "{0:dd/MM/yyyy}")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="MATRICULA" ItemStyle-Width="7%" HeaderStyle-Width="7%" ItemStyle-HorizontalAlign="LEFT" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" id="lblMatricula" CssClass="" text='<%# Bind("MATRICULA")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                                                        
                                <asp:TemplateField HeaderText="DESTINO" ItemStyle-Width="38%" HeaderStyle-Width="38%" ItemStyle-HorizontalAlign="LEFT" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" id="lblDestino" CssClass="" text='<%# Bind("DESTINO")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DESIGNACIÓN" ItemStyle-Width="27%" HeaderStyle-Width="27%" ItemStyle-HorizontalAlign="LEFT" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" id="lblDesignacion" CssClass="" text='<%# Bind("DESIGNACION")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="PAGADO" ItemStyle-Width="5%" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label runat="server" id="lblEstadoPorte" CssClass="" text='<%# Bind("ESTADO")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="" ItemStyle-Width="3%" HeaderStyle-Width="3%" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnAdd_Porte" runat="server" data-toggle="tooltip" data-placement="bottom" Text="" ToolTip="Añadir Porte a Factura"><i class="fa fa-plus-square fa-2x" aria-hidden="true"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
				            </Columns>
				            <EmptyDataRowStyle Width="98%" HorizontalAlign="Center" />    
                            <FooterStyle Height="38px" />
				        </asp:GridView>
                    </ContentTemplate>
                    </asp:UpdatePanel>
		        </div>	
            </div>
        </div>

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
                    <button type="button" class="btn btn-default" data-dismiss="modal"  id="btnCapaMensajesAceptar">Aceptar</button>
                    <input type="hidden" id="hndEndSession" runat="server" />
                </div>
            </div>
            </div>
        </div>

        <div id="CapaConfirm" class="modal fade" role="dialog">
            <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"  id="ConfirmTitle">Confirmar</h4>
                </div>
                <div class="modal-body" style="display:;width:100%; max-height:600px; overflow-y : auto;">
                <p>
                    <label id="lblMsgConfirm"></label>
                </p>
                </div>
                <div class="modal-footer">
                <button type="button" class="btn btn-danger btn-ok" id="btnConfirmAceptar">Aceptar</button>
                <button type="button" data-dismiss="modal" class="btn btn-default" id="btnConfirmCancel">Cancelar</button>
                </div>
            </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <div class="scroll-top-wrapper" title="Ir arriba">
	        <span class="scroll-top-inner">
		        <i class="fa fa-2x fa-arrow-circle-up"></i>
	        </span>
        </div>
    </form>
</body>
</html>
