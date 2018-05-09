<%@ Page Title="" Language="vb" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="principal.aspx.vb" Inherits="TransAmets2.principal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" runat="server">
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
    <link href="css/styles_main.css" rel="stylesheet" />
    <link href="css/morris.css" rel="stylesheet" />
    <link href="css/hover-min.css" rel="stylesheet" media="all">
    <!--[if gte IE 9]>
     <link href="css/i9_btn_fix.css" rel="stylesheet" type="text/css"  />
    <![endif]-->
    <script type="text/javascript" src="Scripts/jquery-1.12.1.min.js"></script>
    <script src="Scripts/jquery-ui-1.11.4/jquery-ui.min.js"></script> 
    <script type="text/javascript" src="Scripts/json2.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="Scripts/moment-with-locales.js"></script>
    <script type="text/javascript" src="Scripts/daterangepicker.js"></script>
    <script type="text/javascript" src="Scripts/respond.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap-dialog.min.js"></script>
    <script type="text/javascript" src="Scripts/raphael.min.js"></script>
    <script type="text/javascript" src="Scripts/morris.min.js"></script>
    <script type="text/javascript" src="Scripts/master.js"></script>
    <style>
        .ELsortOrder div{
	        background-color: #ddd;
	        padding: 5px;
	        margin-bottom: 10px;
	        border-right: solid 2px rgb(242, 242, 242);
	        cursor: pointer;
        }
        .ELsortOrder .selected{ 
	        background-color: #ff0000;
	        color: #fff;	
        }
        .btn-fol-forms-grey, .btn-fol-forms-grey:active, .btn-fol-forms-grey:focus:active, .btn-fol-forms-grey:focus, .btn-fol-forms-grey:hover, .btn-fol-forms-grey:visited {
            margin-top: 3px;
        }
        .buscador .form-group
        {
            padding-left:5px;
            padding-right:5px;
        }
        .estadopropuestalistado {
            /*font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;*/
            font-size:13px;
            color: #4e4d4d;
        }
        .datos_listado {
            padding-left:10px !important;
            padding-right:10px !important;
        }
        .titulo_mtoficheroLimites span{
            float:right;
            vertical-align:middle;
            font-size:18px;
            color: #4e4d4d;
            margin-top:20px;
        }
        .filtros_buscador{
            margin-right:-10px;
            margin-top:10px;
            margin-bottom: 10px;
            border: 3px solid transparent;
            padding: 0px;
          }
        .col-md-1-5 { width: 12,5%; } /* = 8,3333 + 4,16667*/
        .col-md-2-5 { width: 20,83333%; } /* = 16,6666 + 4,16667*/
        .col-md-3-5 { width: 29,16667%; } /* = 25 + 4,16667 */
        .col-md-4-5 { width: 37,5%; } /* = 33,3333 + 4,16667 */
        .col-md-5-5 { width: 45,83333%; } /* = 41,6667 + 4,16667 */
        .col-md-6-5 { width: 54,16667%; } /* = 50 + 4,16667 */
        .col-md-7-5 { width: 62,5%; } /* = 58,3333 + 4,16667 */
        .col-md-8-5 { width: 70,83333%; } /* = 66,6666 + 4,16667 */
        .col-md-9-5 { width: 79,16667%; } /* = 75 + 4,16667 */
        .col-md-10-5 { width: 87,5%; } /* = 83,3333 + 4,16667 */
        .col-md-11-5 { width: 95,8333%; } /* = 91,6666 + 4,16667 */
        #ctl00_MainContent_rpPrescriptores tbody > tr {
            border-bottom: 1px solid transparent;
        }
        #BuscadorClientes .modal-header .close {
            float: right !important;
            /*margin-right: -30px !important;
            margin-top: -30px !important;*/
            background-color: white !important;
            border-radius: 15px !important;
            width: 30px !important;
            height: 30px !important;
            opacity: 1 !important;
        }
        .bt-search-fol{font-size:0.5em !important;}
        .container{padding-left:0px !important; padding-right:0px !important;}
        .cajabotones{ padding:0px !important; margin: 0px !important}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Always">
        <ContentTemplate>
            <input name="hdnControlErrors" id="hdnControlJS" runat="server" type="hidden">
            <input name="hdnTipoErrors" id="hndTipoError" runat="server" type="hidden">
            <input name="hdnTitulo" id="hdnTitulo" runat="server" type="hidden">
            <input name="hdnRedirect" id="hdnRedirect" runat="server" type="hidden">
            <input name="hdnReload" id="hdnReload" runat="server" type="hidden">

            <input name="hdnFechasDefecto" id="hdnFechasDefecto" runat="server" type="hidden">

            <input id="valuesGrahp1" runat="server" type="hidden" />
            <input id="valuesGrahp2" runat="server" type="hidden" />
            <input id="valuesGrahp3" runat="server" type="hidden" />
        </ContentTemplate>
     </asp:UpdatePanel>
    <div class="container container_summary">
        <div class="row" style="">
            <div class="col-md-6 col-sm-6 text-left pd-l-0">
                <h1>ESTADÍSTICAS</h1>
            </div>
            <div class="col-md-2 col-sm-2 text-right titulo_mtoficheroLimites">
                <span>&nbsp;</span>
            </div>
            <div class="col-md-4 col-sm-4 pd-r-0" style="margin-top: 21px;"">
                <div style="float:right;">
                    <!--<div id="cajabotones" style="float: right; position: absolute; top: 0; z-index: 1; right: 0;">-->
                        <asp:UpdatePanel runat="server" ID="UP_Botones" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="col-md-4 col-sm-4 form-group pd-l-0 pd-r-0">
                                    <a id="btnClearFilters" onclick="LimpiarFiltros()" class="btn btn-fol-forms-grey-med bt-search-fol hvr-grow-shadow" style="margin-top: 3px;" data-toggle="tooltip" data-placement="bottom" title="Limpiar filtros"><span class="fa fa-undo" style="margin-top: 6px;"></span></a>
                                </div>
                                <div class="col-md-8 col-sm-8" style="padding-right: 0px;">
                                    <asp:LinkButton ID="btnSearch" runat="server" CssClass="form-control btn btn-fol-forms-grey bt-search-fol hvr-grow-shadow mr-30" Text="Aceptar" data-toggle="tooltip" data-placement="bottom" ToolTip="Seleccionar datos con los filtros indicados"><span class="fa fa-search"></span>&nbsp;&nbsp;Aceptar</asp:LinkButton>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    <!--</div>-->
                </div>
            </div>
        </div>

        <div class="row" style="">
            <div id="pestanas" style="float: left; z-index: 0;padding-left:0px !important;margin-left:0px !important;">
                <!-- Nav tabs -->
                <ul id="tabs" class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#Filtros0" aria-controls="future" role="tab" data-toggle="tab" data-tab="1">FILTROS</a></li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="Filtros0">
                        <!-- Filtros -->
                        <asp:UpdatePanel runat="server" ID="UP_Filtros" UpdateMode="Conditional">
                            <ContentTemplate>
                            <div id="tbl_filters" class="row buscador" style="margin-left:0px !important; margin-right: 0px !important">
                                <div class="col-md-7 col-sm-7 col-xs-7 form-group">
                                    <div class="col-md-4 col-sm-4 col-xs-4 form-group pd-l-0">
                                        <label for="txtFechas"><i class="fa fa-calendar"></i> Rango de Fechas</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtFechas" runat="server" CssClass="form-control date-picker hasDatepicker"></asp:TextBox>
                                            <label for="date-picker" class="input-group-addon"><span class="fa fa-calendar"></span></label>
                                        </div>
                                    </div>    
                                    <div class="col-md-8 col-sm-8 col-xs-8 form-group">
                                        <Label class="txtCliente"><i class="fa fa-user"></i> Cliente</Label>
                                        <div class="form-group gutter-0 pd-l-0 pd-r-0">
                                            <div class="col-md-2 col-sm-2 col-xs-2 form-group pd-l-0">
                                                <asp:TextBox class="string form-control" id="txtCodCli" runat="server" maxlength="4"  AutoPostBack="true" Text=""></asp:TextBox>
                                            </div>
                                            <div class="col-md-10 col-sm-10 col-xs-10 form-group pd-r-0">
                                                <div class="input-group">
                                                    <asp:TextBox class="string form-control" id="txtCliente" runat="server" maxlength="40" Text="" ReadOnly="true"></asp:TextBox>
                                                    <asp:Label id="lbldeleteprescriptor" runat="server" class="input-group-addon btn pd-l-5 pd-r-5" onclick="DeleteCliente();"><span id="ico_delete_cliente" class="fa fa-times"></span></asp:Label>
                                                    <asp:Label id="lblicobuscadorPrescriptor" runat="server" class="input-group-addon btn btn_ico activo" onclick="OpenBuscadorClientes();"><span id="ico_buscador_cliente" class="fa fa-search"></span></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            
                                <div class="col-md-5 col-sm-5 col-xs-5 form-group">
                                    <div class="col-md-5 col-sm-5 col-xs-5 form-group pd-l-0">
                                        <label for="txtMatricula"><i class="fa fa-truck"></i> Matrícula</label>
                                        <div class="input-group">
                                            <asp:TextBox class="string form-control" id="txtMatricula" runat="server" maxlength="15" Text=""></asp:TextBox>
                                            <asp:Label id="Label1" runat="server" class="input-group-addon btn pd-l-5 pd-r-5" onclick="DeleteTransportista();"><span id="ico_delete_matricula" class="fa fa-times"></span></asp:Label>
                                            <asp:Label id="Label2" runat="server" class="input-group-addon btn btn_ico activo" onclick="OpenBuscadorTransportistas();"><span id="ico_buscador_matricula" class="fa fa-search"></span></asp:Label>
                                            <asp:HiddenField ID="hndCodTransportista" runat="server" Value="" />
                                        </div>
                                    </div>
                                    <div class="col-md-7 col-sm-7 col-xs-7 form-group">
                                        <label for="dllAgencias"><i class="fa fa-th-list"></i> Agencia</label>
                                        <asp:DropDownList runat="server" ID="ddlAgencias" CssClass="form-control selectpicker show-tick" data-width="100%">
                                            
                                        </asp:DropDownList>  
                                    </div>                                    
                                </div>
                            </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <!-- fin Filtros -->
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <asp:UpdatePanel runat="server" ID="UpdatePanel2" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="col-md-3 col-sm-3 ui-sortable pd-l-0 pd-r-5">
			        <div class="widget widget-stats bg-green" style="height: 166px;">
			            <div class="stats-icon stats-icon-lg"><i class="fa fa-euro-sign fa-fw"></i></div>
			            <div class="stats-title underline">TOTAL COMPRAS</div>
			            <div class="stats-number"><label id="numtotalcompras" runat="server">0,00</label></div><br />
			            <div class="stats-progress">
                            <!--<div class="progress-bar" id="numtotalcompras_bar" runat="server" style="width: 70.1%;"></div>-->
                        </div>
                        <div class="stats-desc"><label id="numtotalcompras2" runat="server">Total de Portes: </label></div>
			        </div>
			    </div>
                <div class="col-md-3 col-sm-3 ui-sortable pd-l-5 pd-r-5">
			        <div class="widget widget-stats bg-blue" style="height: 166px;">
			            <div class="stats-icon stats-icon-lg"><i class="fa fa-euro-sign fa-fw"></i></div>
			            <div class="stats-title underline">TOTAL VENTAS</div>
			            <div class="stats-number"><label id="numtotalventas" runat="server">0,00</label></div><br />
			            <div class="stats-desc"><label id="numtotalventas1" runat="server">Total de Portes: </label></div>
                        <div class="stats-desc"><label id="numtotalventas2" runat="server">Beneficio: </label></div>
			        </div>
			    </div>

                <div class="col-md-3 col-sm-3 ui-sortable pd-l-5 pd-r-5">
			        <div class="widget widget-stats bg-purple">
			            <div class="stats-icon stats-icon-lg"><i class="fa fa-euro-sign fa-fw"></i></div>
			            <div class="stats-title underline">FACTURAS PENDIENTES COBRO</div>
			            <div class="stats-number"><label id="importependcobro" runat="server">7,842,900</label></div>
                        <div class="progress">
			                <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="importependcobro_bar" runat="server" style="width: 0.0%;"></div>
                        </div>
                        <div class="stats-desc"><label id="importependcobro2" runat="server">Porcentaje del Total (0.0%)</label></div>
			        </div>
			    </div>
                <div class="col-md-3 col-sm-3 ui-sortable pd-l-5 pd-r-0">
			        <div class="widget widget-stats bg-red">
			            <div class="stats-icon stats-icon-lg"><i class="fa fa-euro-sign fa-fw"></i></div>
			            <div class="stats-title underline">PORTES PENDIENTE PAGO</div>
			            <div class="stats-number"><label id="importepedpago" runat="server">7,842,900</label></div>
			            <div class="progress">
                            <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="importependpago_bar" runat="server" style="width: 0.0%;"></div>
                        </div>
                        <div class="stats-desc"><label id="importepedpago2" runat="server">Porcentaje del total (0.0%)</label></div>
			        </div>
			    </div>
            </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <div class="row">
            <div class="row col-md-12 col-sm-12" style="padding-right: 0px !important;margin-right: 0px !important;padding-left: 0px !important;margin-left: 0px !important;">  
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr><td align="center" valign="top">
                        <table border="0" style="width:100%;" cellspacing="5">
                            <tr>
                                <td align="center" valign="middle" style="background-color:#848284; color:#fff;font-weight:bold;height:30px;font-size:1.2em;">
                                    NÚMERO DE PORTES POR MESES DEL ÚLTIMO AÑO
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="graph1"></div>
                                </td>
                            </tr>
                            <tr><td style="height:15px;"></td></tr>
                            <tr>
                                <td align="center" valign="middle" style="background-color:#848284; color:#fff;font-weight:bold;height:30px;font-size:1.2em;">
                                    COMPRAS/VENTAS POR MESES DEL ÚLTIMO AÑO
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="graph2"></div>
                                </td>
                            </tr>
                            <tr><td style="height:15px;"></td></tr>
                            <tr>
                                <td align="center" valign="middle" style="background-color:#848284; color:#fff;font-weight:bold;height:30px;font-size:1.2em;">
                                    BENEFICIO POR MESES DEL ÚLTIMO AÑO
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="top">
                                    <table border="0" style="width:100%;">
                                        <tr>
                                            <td align="left" valign="top" style="width:35%;">
                                                <div id="lit_members" style="font-family:Arial; font-size:12px;"></div>
                                            </td>
                                            <td style="width:5%"></td>
                                            <td>
                                                <div id="contenedor" style="display:block;">
                                                    <div id="graph3"></div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                    </tr>
                </table>
            </div>
        </div>

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

    <!-- BUSCADOR DE CLIENTES -->   
    <div class="modal fade modal-gris" id="BuscadorClientes" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content" style="background-color:#f2f2f2;">
          <div class="modal-header" style="background-color:#ff0000;color:#fff;">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">BUSCADOR CLIENTES</h4>
          </div>
          <div class="modal-body" style="margin: 5px !important; padding: 5px !important; ">
              <iframe id="fBuscadorClientes" width="100%" height="580" frameborder="0" scrolling="auto" allowtransparency="true" src="Buscador_Clientes.aspx?empty=S"></iframe>
          </div>
          
        </div>
      </div>
    </div>
    <!-- FIN BUSCADOR DE CLIENTES -->

    <!-- BUSCADOR DE TRANSPORTISTAS -->   
    <div class="modal fade modal-gris" id="BuscadorTransportistas" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content" style="background-color:#f2f2f2;">
          <div class="modal-header" style="background-color:#ff0000;color:#fff;">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel2">BUSCADOR DE TRANSPORTISTA</h4>
          </div>
          <div class="modal-body" style="margin: 5px !important; padding: 5px !important; ">
              <iframe id="fBuscadorTransportistas" width="100%" height="580" frameborder="0" scrolling="auto" allowtransparency="true" src="Buscador_Transportistas.aspx?empty=S"></iframe>
          </div>
          
        </div>
      </div>
    </div>
    <!-- FIN BUSCADOR DE TRANSPORTISTAS -->

    <div class="scroll-top-wrapper" title="Ir arriba">
	    <span class="scroll-top-inner">
		    <i class="fa fa-2x fa-arrow-circle-up"></i>
	    </span>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpFooter" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphScripts" runat="server">
    <script type="text/javascript">
        //curruserid = "";
        $(document).keypress(function (e) {
            if (e.keyCode === 13) {
                
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
            //$("#ctl00_UpdateProgress1").css("display", "block");
            $("#ctl00_UpdateProgress1").css("display", "block");
        }
        function EndRequest(sender, args) {
            $('#ctl00_UpdateProgress1').hide();
        }
        function AbortPostBack() {
            $('#ctl00_UpdateProgress1').hide();
            ReloadDatepicker();
            if (prm.get_isInAsyncPostBack()) {
                prm.abortPostBack();
            }
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
            $('#ctl00_UpdateProgress1').hide();

            CompruebaErrores();
        }

        $(document).ready(function () {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);           

            $('#ctl00_UpdateProgress1').hide();

            /* CALENDARIOS ============================================== */
            ReloadDatepicker();

            $(document).on('scroll', function () {
                if ($(window).scrollTop() > 100) {
                    $('.scroll-top-wrapper').addClass('show');
                } else {
                    $('.scroll-top-wrapper').removeClass('show');
                }
            });

            $('.scroll-top-wrapper').on('click', scrollToTop);

            graph1 = Morris.Area({
                element: 'graph1',
                behaveLikeLine: true,
                parseTime: false,
                data: [],
                xkey: 'y',
                ykeys: ['item1'],
                labels: ['Nº Portes'],
                lineColors: ['#FF9E05'], // différencier chaque courbe avec une couleur
                lineWidth: 4,
                pointSize: 5,
                hideHover: true,
                xLabelAngle: 60,
                redraw: true
                /*yLabelFormat: function (y) {
                    var cadena = y.toString();
                    cadena = currencyFormatES(parseFloat(cadena));
                    return cadena;
                }*/
            });

            graph2 = Morris.Bar({
                element: 'graph2',
                parseTime: false,
                data: [],
                xkey: 'y',
                ykeys: ['item1', 'item2'],
                fillOpacity: 0.6,
                hideHover: 'auto',
                pointFillColors: ['#ffffff'],
                pointStrokeColors: ['black'],
                barColors: ["#00C000", "#FF9E05"],
                labels: ['VENTAS', 'COMPRAS'],
                xLabelAngle: 60,
                stacked: false,
                redraw: true,
                yLabelFormat: function (y) {
                    var cadena = y.toString();
                    cadena = currencyFormatES(parseFloat(cadena));
                    return cadena;
                }
            });

            graph3 = Morris.Donut({
                element: 'graph3',
                parseTime: false,
                colors: ["#B0CCE1", "#95BBD7", "#679DC6", "#3980B5", "#3573A3", "#0B62A4", "#326994", "#466F8E", "#21669B", "#27608B", "#1E5B8A", "#095791", "#095085", "#083E67", "#052C48", "#042135"],
                data: [{ "value": "", "label": "" }],
                xkey: 'label',
                ykeys: ['value'],
                labels: ['Value'],
                redraw: true,
                formatter: function (value) {
                    var cadena = value.toString();
                    cadena = currencyFormatES(parseFloat(cadena));
                    return cadena;
                }
                /*tooltips: { callbacks: { label: function (value) { return '$' + value.yLabel.toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.'); }, } }
                scales: { yAxes: [{ ticks: { callback: function(value) { return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, "."); } } }*/
                /*yLabelFormat: function (y) {
                    var parts = y.toString().split(".");
                    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ".");
                    return parts.join(",");
                }*/
            });

            Get_Estadisticas_Portes();

            CompruebaErrores();
        });
        function currencyFormatES(num) {
            return num
               .toFixed(2) // always two decimal digits
               .replace(".", ",") // replace decimal point character with ,
               .replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.") + " €" // use . as a separator
        }
        function ReloadDatepicker() {
            $("#ctl00_MainContent_ddlAgencias").selectpicker('refresh');
            $("#ctl00_MainContent_ddlAgencias").selectpicker('render');

            /* CALENDARIOS ============================================== */
            $('#ctl00_MainContent_txtFechas').daterangepicker({
                "linkedCalendars": false,
                "autoUpdateInput": false,
                "showDropdowns": true,
                "autoApply": false,
                "ranges": {
                    "Hoy": [
                         moment(), moment(),
                    ],
                    "Ayer": [
                        moment().subtract('days', 1), moment().subtract('days', 1),
                    ],
                    "Últimos 7 Días": [
                      moment().subtract('days', 6), moment(),
                    ],
                    "Últimos 30 Días": [
                         moment().subtract('days', 29), moment(),
                    ],
                    "Este mes": [
                        moment().startOf('month'), moment().endOf('month'),
                    ],
                    'Este año': [
                        moment().startOf('year'),
                        moment().endOf('year')
                    ]
                },
                "locale": {
                    "format": "DD/MM/YYYY",
                    "separator": " - ",
                    "applyLabel": "Aceptar",
                    "cancelLabel": "Reset",
                    "fromLabel": "Desde",
                    "toLabel": "Hasta",
                    "customRangeLabel": "Personalizado",
                    "daysOfWeek": [
                        "Dom",
                        "Lun",
                        "Mar",
                        "Mier",
                        "Jue",
                        "Vier",
                        "Sáb"
                    ],
                    "monthNames": [
                        "Enero",
                        "Febrero",
                        "Marzo",
                        "Abril",
                        "Mayo",
                        "Junio",
                        "Julio",
                        "Agosto",
                        "Septiembre",
                        "Octubre",
                        "Noviembre",
                        "Diciembre"
                    ],
                    "firstDay": 1
                },
                "alwaysShowCalendars": true,
                //"minDate": moment().subtract('month', 60).startOf('month'),
                "cancelClass": "btn-cleantxtFechas"
            }, function (start, end, label) {
                $('#ctl00_MainContent_txtFechas').val(start.format('DD/MM/YYYY') + ' - ' + end.format('DD/MM/YYYY'));
                //console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
                //console.log(this);
            });
            /* Acciones de calendarios para reiniciar los input */
            $('.btn-cleantxtFechas').on('click', function () {
                $("#ctl00_MainContent_txtFechas").val('');
            });
        }
        function scrollToTop() {
            verticalOffset = typeof (verticalOffset) != 'undefined' ? verticalOffset : 0;
            element = $('body');
            offset = element.offset();
            offsetTop = offset.top;
            $('html, body').animate({ scrollTop: 0 }, 200, 'linear');
        }

        function CompruebaErrores() {
            var EndSession = $('#ctl00_MainContent_hndEndSession').val();
            if (EndSession == "S") {
                $('#lblErrores').html("Su sesión ha terminado</br>Por favor, identifíquese.");
            } else {
                var errores = $('#ctl00_MainContent_hdnControlJS').val();
                if (errores != '') {
                    errores = errores.replace(/\\n/gi, "<br/>");
                    $('#lblErrores').html(errores);

                    var modal = $('#CapaMensajes');
                    var tipomsg = $('#ctl00_MainContent_hndTipoError').val();
                    var titulomsg = $('#ctl00_MainContent_hdnTitulo').val();
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
            $('#ctl00_MainContent_hdnControlJS').val(msg);
            $('#ctl00_MainContent_hndTipoError').val(tipo);
            $('#ctl00_MainContent_hdnTitulo').val(titulo);
            if (msg != '') {
                CompruebaErrores();
            }
        }
        $('#CapaMensajes').on('hide.bs.modal', function (event) {
            $('#ctl00_MainContent_hdnControlJS').val('');
            var EndSession = $('#ctl00_MainContent_hndEndSession').val();
            if (EndSession == "S") {
                //document.location.href = '';
            }
        });
        $('#CapaMensajes').on('click', '#btnCapaMensajesAceptar', function (e) {
            var hdnRedirect = $("#ctl00_MainContent_hdnRedirect").val();
            var hdnReload = $("#ctl00_MainContent_hdnReload").val();
            if (hdnRedirect != "") {
                //document.location.href = hdnRedirect;
            } else {
                if (hdnReload != "") {
                    location.reload();
                }
            }
        });

        Number.prototype.round = function (places) {
            return +(Math.round(this + "e+" + places) + "e-" + places);
        }
        function Get_Estadisticas_Portes() {
            var msg = "";
            graph1.setData([]);
            graph2.setData([]);
            graph3.setData([]);

            var valuesGrahp1 = $("#ctl00_MainContent_valuesGrahp1").val();
            if (valuesGrahp1 != "") {
                if (valuesGrahp1.indexOf('Error: ') == -1) {
                    if (valuesGrahp1 == "") {
                        graph1.setData([]);
                        mensaje_alert("NO HAY DATOS", "No hay entradas del mes indicado.", 2);
                        return false;
                    } else {
                        datos = $.parseJSON(valuesGrahp1);
                        graph1.setData(datos);
                    }
                    graph1.redraw();
                    // aumentar height area labels
                    var svg = $("#graph1").find("svg");
                    if (svg) {
                        svg[0].height.baseVal.value += 30;
                    }
                }
                else {
                    msg = valuesGrahp1 + "<br/>";
                }
            }

            var valuesGrahp2 = $("#ctl00_MainContent_valuesGrahp2").val();
            if (valuesGrahp2 != "") {
                if (valuesGrahp2.indexOf('Error: ') == -1) {
                    if (valuesGrahp2 == "") {
                        graph2.setData([]);
                        mensaje_alert("NO HAY DATOS", "No hay entradas del mes indicado.", 2);
                        return false;
                    } else {
                        datos = $.parseJSON(valuesGrahp2);
                        cu = datos.length;
                        maxvalor = 0;
                        for (i = 0; i < cu; i++) {
                            if (parseFloat(datos[i]['item1']) > maxvalor) { maxvalor = parseFloat(datos[i]['item1']); }
                            if (parseFloat(datos[i]['item2']) > maxvalor) { maxvalor = parseFloat(datos[i]['item2']); }
                        }
                        porciento = maxvalor * 10 / 100;
                        maxvalor += porciento;
                        graph2.options["ymax"] = maxvalor;
                        graph2.setData(datos);
                    }
                    graph2.redraw();
                    // aumentar height area labels
                    var svg = $("#graph2").find("svg");
                    if (svg) {
                        svg[0].height.baseVal.value += 30;
                    }
                }
                else {
                    if (msg != "") { msg += "<br/>";}
                    msg += valuesGrahp2;
                }
            }

            var valuesGrahp3 = $("#ctl00_MainContent_valuesGrahp3").val();
            $('#lit_members').empty();
            if (valuesGrahp3 != "") {
                if (valuesGrahp3.indexOf('Error: ') == -1) {
                    var TotalValores = 0;
                    if (valuesGrahp3 == "") {
                        graph3.setData([]);
                        mensaje_alert("NO HAY DATOS", "No hay entradas del mes indicado.", 2);
                        return false;
                    } else {
                        datos = $.parseJSON(valuesGrahp3);
                        colores = "";
                        cu = datos.length;
                        for (i = 0; i < cu; i++) {
                            TotalValores += parseInt(datos[i]['value']);
                        }
                        graph3.setData(datos);

                        var legendItem = "";
                        for (i = 0; i < cu; i++) {
                            if (i == (cu - 2)) {
                                i = i;
                            }
                            var porcentaje = (parseInt(datos[i]['value']) / TotalValores) * 100;
                            var legendItem = $('<span></span>').text(datos[i]['label'] + " (" + currencyFormatES(parseFloat(datos[i]['value'])) + " - " + porcentaje.round(1) + "%)").prepend('<br/><span>&nbsp;</span>');
                            var colorc=graph3.options.colors[i];
                            legendItem.find('span')
                              .css('backgroundColor', colorc)
                              .css('width', '15px')
                              .css('height', '15px')
                              .css('vertical-align', 'middle')
                              .css('display', 'inline-block')
                              .css('margin', '5px');
                            $('#lit_members').append(legendItem);
                        }
                    }
                    graph3.redraw();
                }
                else {
                    if (msg != "") { msg += "<br/>"; }
                    msg += valuesGrahp3;
                }
            }

            if (msg != "") {
                MuestraError(msg,"ERROR", "ERROR");
            }
        }
        function Get_Estadisticas_Facturas() {

        }

        /* BUSCADOR CLIENTES */
        function OpenBuscadorClientes() {
            $('#BuscadorClientes').modal({ show: true })
        }
        $('#BuscadorClientes').on('shown.bs.modal', function () {
            $(this).find('.modal-dialog').css({
                width: 'auto',
                height: 'auto',
                'max-width': '860px',
                'min-height': '480px',
                'max-height': '94%'
            });
            $(this).find('.modal-body').css({
                'background-color': '#F2F2F2',
            });
            $("#fBuscadorClientes")[0].contentWindow.CodigoFocus();
        });

        function ClienteSelected(id, nombre) {
            $("#<%=txtCliente.ClientId%>").val(htmlDecode(nombre));
            $("#<%=txtCodCli.ClientId%>").val(id);
            
            $('#BuscadorClientes').modal('toggle');
        }
        function DeleteCliente() {
            $("#<%=txtCliente.ClientId%>").val("");
            $("#<%=txtCodCli.ClientId%>").val("");
        }
        /* FIN BUSCADOR CLIENTES */

        /* BUSCADOR TRANSPORTISTAS */
        function OpenBuscadorTransportistas() {
            $('#BuscadorTransportistas').modal({ show: true })
        }
        $('#BuscadorTransportistas').on('shown.bs.modal', function () {
            $(this).find('.modal-dialog').css({
                width: 'auto',
                height: 'auto',
                'max-width': '860px',
                'min-height': '480px',
                'max-height': '94%'
            });
            $(this).find('.modal-body').css({
                'background-color': '#F2F2F2',
            });
            $("#fBuscadorTransportistas")[0].contentWindow.CodigoFocus();
        });

        function TransportistaSelected(matricula, propietario, conductor) {
            $("#<%=txtMatricula.ClientId%>").val(htmlDecode(matricula));
            $('#BuscadorTransportistas').modal('toggle');
        }
        function DeleteTransportista() {
            $("#<%=txtMatricula.ClientId%>").val("");
        }
        /* FIN BUSCADOR TRANSPORTISTAS */

        function htmlEntities(str) {
            return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
        }
        function htmlEncode(html) {
            return document.createElement('a').appendChild(
                document.createTextNode(html)).parentNode.innerHTML;
        };

        function htmlDecode(html) {
            var a = document.createElement('a'); a.innerHTML = html;
            return a.textContent;
        };
        function LimpiarFiltros() {
            $("#<%=txtFechas.ClientId%>").val($("#<%=hdnFechasDefecto.ClientId%>").val());
            $("#<%=txtCodCli.ClientId%>").val("");
            $("#<%=txtCliente.ClientId%>").val("");
            $("#<%=txtMatricula.ClientId%>").val("");
            $("#dllAgencias").val('');

            ActualizaGraficos();
        }
        function ActualizaGraficos() {
            ReloadDatepicker();

            Get_Estadisticas_Portes();
        }
        //debugger;
    </script>
</asp:Content>
