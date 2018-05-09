<%@ Page Language="vb" AutoEventWireup="true" CodeBehind="Buscador_Clientes.aspx.vb" Inherits="TransAmets2.Buscador_Clientes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="es">
    <head runat="server">
	    <title>BUSCADOR DE CLIENTES</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=9;IE=11;IE=edge" />
		<meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="expires" content="0"/>        
	
        <link href="css/bootstrap.min.css" rel="stylesheet" />
        <link href="css/bootstrapValidator.min.css" rel="stylesheet" />
        <link href="css/daterangepicker.css" rel="stylesheet" />
        <link href="css/bootstrap-select.css" rel="stylesheet" />
        <link href="Scripts/jquery-ui-1.11.4/jquery-ui.min.css" rel="stylesheet" />
        <link href="css/bootstrap-dialog.min.css" rel="stylesheet" />
        <link href="css/styles_main.css" rel="stylesheet" />
        <link href="css/font-awesome/font-awesome.min.css" rel="stylesheet" />
        <link href="css/hover-min.css" rel="stylesheet" media="all" />
		<base target="_self" />

		<script type="text/javascript" src="Scripts/jquery-1.12.1.min.js"></script>
        <script type="text/javascript" src="Scripts/jquery-ui-1.11.4/jquery-ui.min.js"></script> 
        <script type="text/javascript" src="Scripts/json2.min.js"></script>
        <script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
        <script type="text/javascript" src="Scripts/gridviewScroll.min.js"></script>
		<script type="text/javascript" language="javascript">
		    var prm;
		    var postBackElement;
		    $(document).ready(function () {
		        prm = Sys.WebForms.PageRequestManager.getInstance();
		        prm.add_initializeRequest(InitializeRequest);
		        prm.add_endRequest(EndRequest);

		        $('select').each(function (e) {
		            var selE = $('select:eq(' + e + ') option:selected').text();
		            $(this).wrap('<div class="selectWrap"></div>');
		            $('.selectWrap:eq(' + e + ')').append('<span class="selectInner"></span>');
		            $('.selectInner:eq(' + e + ')').text(selE);
		        });
		        $('select').change(function () {
		            var i = $(this).index('select');
		            var sel = $('select:eq(' + i + ') option:selected').text();
		            $('.selectInner:eq(' + i + ')').text(sel);
		        });

		        // SOLO NUMEROS sin puntos sin coma
		        $("#txtCodigo").keydown(function (event) {
		            //8=backspace; 9=tab; 46=delete; 188=coma; >=35 <=40 arrow keys/home/end; >=48 <=57 numbers on keyboard; >=96 <=105 number on keypad
		            if (event.shiftKey) { event.preventDefault(); }
		            if (!(event.keyCode == 8
                        || event.keyCode == 9
                        || event.keyCode == 46
                        || (event.keyCode >= 35 && event.keyCode <= 40)
                        || (event.keyCode >= 48 && event.keyCode <= 57)
                        || (event.keyCode >= 96 && event.keyCode <= 105))
                    ) {
		                event.preventDefault();     // Prevent character input
		            }
		        });

		        pageLoad();

		        $('#UpdateProgress1').hide();
		        CompruebaErrores();

		        $("#txtDescripcion").focus();

		        window.setTimeout(function() {
		            $("#txtCodigo").focus();
		        }, 1000);
		    });
		    $(document).keypress(function (e) {
		        var keycode = event.keyCode || event.which;
		        if (keycode == '13') {
		            $("#btSearch").trigger("click");
		        }
		    });
		    function LimpiarFiltros() {
		        $("#txtCodigo").val('');
		        $("#txtDescripcion").val('');
		        $("#txtCIFNIF").val('')
		    }
		    function controlarFiltros() {
		        //Controlamos que el usuario indico al menos un campo de filtro, con un minimo de 3 caracteres
		        /*var srHayFiltro = false;
		        if (document.getElementById("txtDescripcion") != null && (document.getElementById("txtDescripcion").value != "") && (document.getElementById("txtDescripcion").value.length > 2)) {
		            srHayFiltro = true;
		        }
		        if (document.getElementById("txtCIFNIF") != null && (document.getElementById("txtCIFNIF").value != "") && (document.getElementById("txtCIFNIF").value.length > 2)) {
		            srHayFiltro = true;
		        }
		        if (srHayFiltro == false) {
		            MuestraMensaje("Ha de indicar al menos un filtro con al menos 3 caracteres", 1, "ERROR", "");
		            return false;
		        } else {*/
		            return true;
		        //}
		    }
		    function ReturnDataClient(Codigo, Descripcion) {
		        window.parent.ClienteSelected(Codigo, Descripcion);
		    }
		    function pageLoad() {
		        recarga_eventos_jquery();
		    }
		    function recarga_eventos_jquery() {
		        var gridWidth = $("#dfiltros").width();// $(window).width();
		        var gridHeight = $(window).height() - 124;
		        var headerHeight = $("#divHeader").height();
		        gridHeight = gridHeight - headerHeight;
		        $("#<%=gcDatosBuscador.ClientID%>").gridviewScroll({
		            width: gridWidth,
		            height: gridHeight,
		            startHorizontal: 0,
		            arrowsize: 30,
		            varrowtopimg: "images/arrowvt.png",
		            varrowbottomimg: "images/arrowvb.png",
		            harrowleftimg: "images/arrowhl.png",
		            harrowrightimg: "images/arrowhr.png"
		        });
		    }
		    function DescripcionFocus() {
		        $("#txtDescripcion").focus();
		    }
		    function CodigoFocus() {
		        $("#txtCodigo").focus();
		    }
		    function InitializeRequest(sender, args) {
		        $("#hdnRedirect").val('');
		        $("#hdnReload").val('');
		        $('#hdnControlJS').val('');
		        if (prm.get_isInAsyncPostBack()) {
		            args.set_cancel(true);
		        }
		        postBackElement = args.get_postBackElement();
		        $("#ctl00_UpdateProgress1").css("display", "block");
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
		        switch (tipo){
		            case 1:
		                $("#hndTipoError").val("ERROR"); // color ROJO
		                if(titulo == ""){titulo = "ERROR";}
                        break;
		            case 2:
		                $("#hndTipoError").val("AVISO"); // color AMARILLO
                        if(titulo == ""){titulo = "AVISO";}
                        break;
		            case 3:
		                $("#hndTipoError").val("OK"); // color VERDE
                        if(titulo == ""){titulo = "MENSAJE";}
                        break;
		            default:
		                $("#hndTipoError").val("MENSAJE"); // color AZUL
                        if(titulo == ""){titulo = "MENSAJE";}
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
		    
		    function ReturnData(obj) {
		        //var oSeleccionado = obj.getAttribute("valorId");
		        //ReturnDataClient(oSeleccionado);
		    }
	
		    function ReturnDataVacio() {
		        var retObject = new Object();
		
		        retObject.CODCLI;
			    retObject.DESCRIPCION = "";		
			    									
			    window.returnValue = retObject;
			    closeWindow();
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

		    function closeWindow() {
		        var is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;
		        if (is_chrome == true) {
		            popDialog();
		        }
		        else {
		            window.close();
		        }
		    }
		    //debugger;
		</script>
        <style type="text/css">
            #txtDescripcion { text-transform: uppercase; }
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
            @-moz-document url-prefix() {
                table, table td {
                    font-size: 13px !important;
                }

            }
            .titularTab, .titularTab.span span {border-bottom: 1px solid #dddddd; color: #404040; display:block!important; font-size: 22px!important; font-weight: bold; height: 62px!important; min-height: 62px!important; padding-left: 51px!important; padding-top: 15px!important; width: 100%!important; box-sizing: border-box; -webkit-box-sizing: padding-box; -moz-box-sizing: padding-box; box-sizing: padding-box;}
            .titularTab.span span {padding-top: 0px !important; font-weight: bold !important; padding-left: 0 !important;}
            .redondear td .titularTab, .redondear td.titularTab  {margin-bottom: 10px; padding-top: 18px !important; width: auto!important;}
            .titularTab span {font-size: 14px!important; font-weight: normal!important;}
            .titularTab.Center {text-align: center; padding-left: 0!important; padding-right: 0!important;}
            .icoRight { background-position: /*96*/99%!important; padding-left: 20px!important;}
            .titularTab.titRojo {background: #fe0000; color: #fff; height: 50px !important; padding-left: 20px!important; /*padding-top: 10px !important;*/ min-height: 0px !important; padding-top: 10px !important; padding-bottom: 10px!important; position: relative; width: 100%;}
            .titularTab .cerrarPopUp {position: absolute; right: 10px;}
            .titularTab.noIco {padding-left: 20px;}
            .per1 {
                margin-top: 2px !important;
            }
            .btn-fol-forms-grey, .btn-fol-forms-grey:active, .btn-fol-forms-grey:focus:active, .btn-fol-forms-grey:focus, .btn-fol-forms-grey:hover, .btn-fol-forms-grey:visited {
                margin-top: 18px;
            }
            .buscador .form-group
            {
                padding-left:5px;
                padding-right:5px;
            }

            /* paginacion gridview*/
            .pagination-ys {
                /*display: inline-block;*/
                padding-left: 0;
                margin: 10px 0;
                border-radius: 4px;
            }
 
            .pagination-ys table > tbody > tr > td {
                display: inline;
            }
 
            .pagination-ys table > tbody > tr > td > a,
            .pagination-ys table > tbody > tr > td > span {
                position: relative;
                float: left;
                padding: 8px 12px;
                line-height: 1.42857143;
                text-decoration: none;
                /*color: #dd4814;*/
                color:#000;
                background-color: #ffffff;
                border: 1px solid #dddddd;
                margin-left: -1px;
            }
 
            .pagination-ys table > tbody > tr > td > span {
                position: relative;
                float: left;
                padding: 8px 12px;
                line-height: 1.42857143;
                text-decoration: none;    
                margin-left: -1px;
                z-index: 2;
                /*color: #aea79f;*/
                color: #B7B7B7;
                background-color: #f5f5f5;
                border-color: #dddddd;
                cursor: default;
            }
 
            .pagination-ys table > tbody > tr > td:first-child > a,
            .pagination-ys table > tbody > tr > td:first-child > span {
                margin-left: 0;
                border-bottom-left-radius: 4px;
                border-top-left-radius: 4px;
            }
 
            .pagination-ys table > tbody > tr > td:last-child > a,
            .pagination-ys table > tbody > tr > td:last-child > span {
                border-bottom-right-radius: 4px;
                border-top-right-radius: 4px;
            }
 
            .pagination-ys table > tbody > tr > td > a:hover,
            .pagination-ys table > tbody > tr > td > span:hover,
            .pagination-ys table > tbody > tr > td > a:focus,
            .pagination-ys table > tbody > tr > td > span:focus {
                /*color: #97310e;*/
                color:#000;
                font-weight:bold;
                background-color: #eeeeee;
                border-color: #dddddd;
            }
            /* fin paginacion gridview*/
            #gcDatosBuscadorCopy {margin: 0px !important; padding: 0px !important;}
            #gcDatosBuscador{margin: 0px !important; padding: 0px !important;}
            #gcDatosBuscadorPagerBottom {margin-top:10px;}

            @media screen and (min-width: 768px) {
	            #CapaMensajes .modal-dialog  {width:700px;}
            }
        </style>
</head>
<body style="margin-top:-10px;">
	<form id="Form1" method="post" runat="server" defaultbutton="btSearch" style="width:98%" class="pd-l-0 pd-r-0">
        <asp:ScriptManager runat="server" EnablePageMethods="true" EnablePartialRendering="true" EnableViewState="true" AsyncPostBackTimeout="999999" ></asp:ScriptManager>
		
        <div class="container pd-l-0 pd-r-0">
            <div class="row container_summary">
                <div class="col-md-12 col-sm-12 pd-l-0 pd-r-0" style="padding-bottom:0px !important;margin-bottom:0px !important;">
                    <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Always">
                        <ContentTemplate>
                        <div id="dfiltros" class="row buscador gutter-10" style="margin-bottom: 10px !important;">
                            <div class="col-md-2 col-sm-2 form-group">
                                <label for="txtCodigo">Código</label>
                                <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control" Text=""></asp:TextBox>
                            </div>
                            <div class="col-md-6 col-sm-6 form-group">
                                <label for="txtDescripcion">Cliente</label>
                                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" Text=""></asp:TextBox>
                            </div>
                            <div class="col-md-2 col-sm-2 form-group">
                                <label for="txtCIFNIF">CIF/NIF</label>
                                <asp:TextBox ID="txtCIFNIF" runat="server" CssClass="form-control" Text=""></asp:TextBox>
                            </div>
                            <div class="col-md-2 col-sm-2 form-group">
                                <div class="col-md-4 col-sm-4 form-group pd-l-0 pd-r-0">
                                    <a onclick="LimpiarFiltros()" class="btn btn-fol-forms-grey-med bt-search-fol hvr-grow-shadow"><span class="fa fa-undo" style="margin-top: 6px;"></span></a>
                                </div>
                                <div class="col-md-8 col-sm-8 form-group pd-l-0 pd-r-0">
                                    <label for="btnSearch"></label>
                                    <asp:Button ID="btSearch" runat="server" CssClass="form-control btn btn-fol-forms-grey bt-search-fol" Text="Buscar"></asp:Button>
                                </div>
                            </div>
                        </div>
                        <div id="NoRegs" runat="server" class="col-md-12 col-sm-12 no-results text-center">
                            <asp:Image ID="noresults" ImageUrl="./images/no_results.png" runat="server" />
                        </div>
                        <div id="dtextfiltros" runat="server" class="col-md-12 col-sm-12 no-results text-center hide">
                            <label>Indique algo en los filtros y pulse el botón Buscar</label>
                        </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <asp:UpdatePanel runat="server" ID="UpdatePanel3" UpdateMode="Always">
                <ContentTemplate>
                    <div class="col-md-12 col-sm-12 pd-l-10 pd-r-10">
                        <!-- TOTAL ROWS ============================= -->
                        <div id="dTotalRows" runat="server" class="col-md-8 col-sm-8 pd-l-0">
                            <span><asp:Label runat="server" id="lblTotalRows" text=""></asp:Label></span>
                        </div>
                        <div id="dTotalPages" runat="server" class="col-md-4 col-sm-4 text-right">
                            <span><asp:Label runat="server" id="lblTotalPages" text=""></asp:Label></span>
                        </div>
                   </div>
                </ContentTemplate>
                </asp:UpdatePanel>
               <div class="col-md-12 col-sm-12 pd-l-10 pd-r-10">
                    <asp:UpdatePanel runat="server" ID="UPanelGrid" UpdateMode="Always">
                    <ContentTemplate>
                        <asp:GridView ID="gcDatosBuscador" runat="server" 
				            Width="100%" 
				            PageSize="20" 
				            AutoGenerateColumns="false" 
				            AllowSorting="true" 
				            CssClass="tab-GridView table-sm"
                            AllowPaging="true">
				            <AlternatingRowStyle />
				            <RowStyle />
				            <HeaderStyle />
                            <PagerSettings  Mode="NumericFirstLast" FirstPageText="|<" PreviousPageText="<" NextPageText=">" LastPageText=">|" />
                            <PagerStyle HorizontalAlign = "Right" CssClass="pagination-ys" />
				            <Columns>
                                <asp:TemplateField HeaderText="CÓDIGO" ItemStyle-Width="10%" HeaderStyle-Width="10%">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_CODIGO" runat="server" Text='<%# Bind("CODIGOCLI")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CLIENTE" ItemStyle-Width="75%" HeaderStyle-Width="75%">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_NOMBRE" runat="server" Text='<%# Bind("CLINOM")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="CIF/NIF" ItemStyle-Width="15%" HeaderStyle-Width="15%">
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_CIFNIF" runat="server" Text='<%# Bind("CLICIF")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
				            </Columns>
				            <EmptyDataRowStyle Width="90%" HorizontalAlign="Center" />    
                            <FooterStyle Height="38px" />
				        </asp:GridView>
                    </ContentTemplate>
                    </asp:UpdatePanel>
		        </div>			
            </div>    
        </div>

        <asp:UpdatePanel runat="server" ID="UpdatePanel2" UpdateMode="Always">
        <ContentTemplate>															
			<input id="hiNumTotalPages" style="WIDTH: 32px;" type="hidden" name="Hidden1" runat="server" />
            <input id="hiCurrentPage" style="WIDTH: 32px;" type="hidden" value="0" name="Hidden1" runat="server" />		    
                
			<input id="hdnDescripcion" style="WIDTH: 8px" type="hidden" name="hdnDescripcion" runat="server" />
            <input id="hdnCifNif" style="WIDTH: 8px" type="hidden" name="hdnCifNif" runat="server" />			        						    						    						    
                
            <asp:HiddenField ID="hdnClienteId" runat="server" />
                
            <input name="hdnControlErrors" id="hdnControlJS" runat="server" type="hidden"/>
            <input name="hdnTipoErrors" id="hndTipoError" runat="server" type="hidden"/>
            <input name="hdnTitulo" id="hdnTitulo" runat="server" type="hidden"/>
            <input name="hdnRedirect" id="hdnRedirect" runat="server" type="hidden"/>
            <input name="hdnReload" id="hdnReload" runat="server" type="hidden"/>
        </ContentTemplate>
        </asp:UpdatePanel>

        <div id="CapaMensajes" class="modal fade">
            <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Error</h4>
                </div>
                <div class="modal-body" style="display:;width:100%; max-height:600px; overflow-y : auto;">
                    <p>
                        <label id="lblErrores" style="color:#808080;"></label>
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
                    <td><img src="<%=ResolveUrl("~/images/procesando.gif")%>" alt="" /></td>
                </tr>
                </table>
            </div>
        </ContentTemplate>
        </asp:UpdatePanel>
	</form>
</body>
</html>

