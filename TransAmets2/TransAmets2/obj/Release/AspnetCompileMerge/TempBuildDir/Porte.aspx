<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Porte.aspx.vb" Inherits="TransAmets2.Porte" %>
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
    <link href="css/hover-min.css" rel="stylesheet" media="all">
    <!--[if gte IE 9]>
     <link href="css/i9_btn_fix.css" rel="stylesheet" type="text/css"  />
    <![endif]-->
    <script type="text/javascript" src="Scripts/jquery-1.12.1.min.js"></script>
    <script src="Scripts/jquery-ui-1.11.4/jquery-ui.min.js"></script> 
    <script type="text/javascript" src="Scripts/json2.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="Scripts/popper.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="Scripts/moment-with-locales.js"></script>
    <script type="text/javascript" src="Scripts/daterangepicker.js"></script>
    <script type="text/javascript" src="Scripts/respond.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap-dialog.min.js"></script>
    <script type="text/javascript" src="Scripts/master.js"></script>
    <style>
        .trDataGrid {
            background-color:#fff !important;
            color: #555 !important;
        }
        .trDataGrid:hover {
            background-color:#e5e5e5;
            color: #555;
            cursor:pointer;
            cursor:hand;
        }
        .trDataGrid .seleccionado {
            background-color:#3F61B7 !important;
            color: #fff !important;
        }
        #BuscadorClientes, #BuscadorTransportistas, #CapaMensajes {
            /*right:auto !important;*/
            overflow: visible !important;
            overflow-x:visible !important;
            overflow-y:visible !important;
        }
        .ui-datepicker {
            z-index: 999 !important;
        }

        .ui-datepicker select.ui-datepicker-month, .ui-datepicker select.ui-datepicker-year {
            color: #333;
        }
        #tablaAgenda tr:hover {
            background-color:#FAFAFA;
        }
        #tablaAgenda .rowClicked {
            background-color:#FAFAFA;
        }
        
        /* COLLAPSE */
        .divAgenda .panel-heading span {
            margin-top: -20px;
            font-size: 15px;
        }

        .Multiopcion .row {
            margin-top: 20px;
            padding: 0 10px;
        }

        .divAgenda .panel-heading {
            background-color: #ff0000;
            color: #fff;
            font-weight: bold;
        }

            .divAgenda .panel-heading i {
            }

        .divAgenda .clickable {
            cursor: pointer;
            background-color: #c3c3c3;
            max-height: 30px !important;
        }

        .panel-heading a:after {
            font-family: 'Glyphicons Halflings';
            content: "\e114";
            float: right;
            color: grey;
        }

        .panel-heading a.collapsed:after {
            content: "\e080";
        }
        /* FIN COLLAPSE */
        .bot-Multiopcion:hover {
            cursor: pointer;
            background-color: #c7c7c7;
        }

        .bot-Multiopcion {
            -webkit-box-shadow: 0 2px 0 0 #c7c7c7;
            -moz-box-shadow: 0 2px 0 0 #c7c7c7;
            box-shadow: 0 2px 0 0 #c7c7c7;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            margin-top: 0;
            color: #404040;
            border: 0;
            width: 25px;
            height: 25px;
            font-family: robotobold;
            font-size: 1.4em;
            background-color: #e5e5e5;
            padding: 0 15px 0 35px;
            text-align: center;
            vertical-align: middle;
        }

        .btn-fol-forms-white, .btn-fol-forms-white:active, .btn-fol-forms-white:active:focus, .btn-fol-forms-white:focus, .btn-fol-forms-white:hover, .btn-fol-forms-white:visited {
            background-image: -ms-linear-gradient(top,#fff 0,#fcfcfc 50%,#e5e5e5 100%);
            background-image: -moz-linear-gradient(top,#fff 0,#fcfcfc 50%,#e5e5e5 100%);
            background-image: -o-linear-gradient(top,#fff 0,#fcfcfc 50%,#e5e5e5 100%);
            background-image: -webkit-gradient(linear,left top,left bottom,color-stop(0,#fff),color-stop(50,#fcfcfc),color-stop(100,#e5e5e5));
            background-image: -webkit-linear-gradient(top,#fff 0,#fcfcfc 50%,#e5e5e5 100%);
            background-image: linear-gradient(to bottom,#fff 0,#fcfcfc 50%,#e5e5e5 100%);
            -webkit-box-shadow: 0 2px 0 0 #c7c7c7;
            -moz-box-shadow: 0 2px 0 0 #c7c7c7;
            box-shadow: 0 2px 0 0 #c7c7c7;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            margin-top: 0;
            color: #404040;
            border: 0;
            height: 34px;
            font-family: robotobold;
            font-size: 1.1em;
            background-color: transparent;
            padding: 0 15px 0 15px;
            text-align: center;
            vertical-align: middle;
        }

        .btn-fol-forms-grey, .btn-fol-forms-grey:active, .btn-fol-forms-grey:active:focus, .btn-fol-forms-grey:focus, .btn-fol-forms-grey:hover, .btn-fol-forms-grey:visited {
            background-image: -ms-linear-gradient(top,#707070 0,#616161 50%,#555 100%);
            background-image: -moz-linear-gradient(top,#707070 0,#616161 50%,#555 100%);
            background-image: -o-linear-gradient(top,#707070 0,#616161 50%,#555 100%);
            background-image: -webkit-gradient(linear,left top,left bottom,color-stop(0,#707070),color-stop(50,#616161),color-stop(100,#555));
            background-image: -webkit-linear-gradient(top,#707070 0,#616161 50%,#555 100%);
            background-image: linear-gradient(to bottom,#707070 0,#616161 50%,#555 100%);
            -webkit-box-shadow: 0 2px 0 0 #c7c7c7;
            -moz-box-shadow: 0 2px 0 0 #c7c7c7;
            box-shadow: 0 2px 0 0 #c7c7c7;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            margin-top: 0;
            color: #fff;
            border: 0;
            height: 34px;
            font-family: robotobold;
            font-size: 1.1em;
            background-color: transparent;
            padding: 5px 15px 5px 15px;
            text-align: center;
            vertical-align: middle;
        }
        
        .container_summary .row {
            margin-top: 0px !important;
            margin-bottom: 0px;
            margin-left: 0px;
            margin-right: 0px;
        }

        .container_summary .registro .proposal {
            border-bottom: solid 1px transparent;
        }

        .Multiopcion .dropdown-menu .Multiopcion .dropdown-menu a,
        .Multiopcion .dropdown-menu .Multiopcion .dropdown-menu a:hover,
        .Multiopcion .dropdown-menu .Multiopcion .dropdown-menu a:visited {
            height: 15px;
        }

        .dividerH {
            height: 1px;
            width: 100%;
            display: block; /* for use on default inline elements like span */
            margin: 9px 0;
            overflow: hidden;
            background-color: #e5e5e5;
        }

        .caja_tasacion_independiente {
            margin: 20px 0;
            background-color: #E6E6E6;
            border-bottom: 1px solid #e5e5e5;
        }

        .Multiopcion table tr {
            border-top-color: #fff;
        }

        .boton_icono_sombra {
            box-shadow: 0 0 5px black;
            width: 28px;
            margin-right: 15px;
        }

        .boton_collapse {
            width: 30px;
            text-align: center;
            vertical-align: middle;
            border-left: 1px solid #DDDDDD;
            cursor: pointer;
        }
        #mercancia_numcars, #destino_numcars, #observaciones_numcars, #incidencias_numcars {
            color: #7a7878;
            font-size: 12px;
            font-weight:normal;
            padding-bottom:0px;
            margin-bottom:0px;
        }
        .container_summary .registro label {
            margin-top: 7px;
        }
        label {
            margin-bottom: 7px;
        }
        #CapaMensajes #lblErrores {
            font-weight:normal;
            color: #808080;
        }
        .TituloError {
            color:#000;font-weight:bold;text-decoration:underline;
        }
        @media screen and (min-width: 768px) {
	        #CapaMensajes .modal-dialog  {width:900px;}
            #BuscadorClientes .modal-dialog  {width:950px;}
            #BuscadorTransportistas .modal-dialog  {width:950px;}
        }
        .modal-gris .modal-backdrop {
          background-color: #F2F2F2;
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
        #BuscadorTransportistas .modal-header .close {
            float: right !important;
            /*margin-right: -30px !important;
            margin-top: -30px !important;*/
            background-color: white !important;
            border-radius: 15px !important;
            width: 30px !important;
            height: 30px !important;
            opacity: 1 !important;
        }
        .container_summary .registro div .bgrojo{background-color:#ff0000 !important;}
        .textred{color:#ff0000 !important;}
        .FacCobPagVerde{
            font-size:1.3em;
            font-weight:bold;
            background-color:#46d12b;
            color: #fff;
            border: 1px solid #797979;
            text-align:center;
            vertical-align:middle;
        }
        .FacCobPagRojo{
            font-size:1.3em;
            font-weight:bold;
            background-color: #ff0000;
            color: #fff;
            border: 1px solid #797979;
            text-align:center;
            vertical-align:middle;
        }
        .FacCobPag{
            font-size:1em;
            font-weight:bold;
            color: #fff;
        }
        /* stilos checkbox y radio dircarga*/
        
        input[type=checkbox],input[type=radio]
        {
          background-color: transparent;
          /* Double-sized Checkboxes & Radio */
          -ms-transform: scale(1.5); /* IE */
          -moz-transform: scale(1.5); /* FF */
          -webkit-transform: scale(1.5); /* Safari and Chrome */
          -o-transform: scale(1.5); /* Opera */

          ms-filter: contrast(200%);
          -moz-filter: contrast(200%);
          -webkit-filter: contrast(200%);
          -o-filter: contrast(200%);
          filter: contrast(200%);
        }
        /* fin stilos checkbox y radio dircarga*/
        .GridView_CliCarga {margin:0px !important;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Always">
        <ContentTemplate>
            <asp:HiddenField ID="hdnPorteId" runat="server" />
            <asp:HiddenField ID="hdnClienteId" runat="server" />
            <asp:HiddenField ID="hndDirCliente_id" runat="server" />
            <asp:HiddenField ID="hndMatricula" runat="server" />
            <asp:HiddenField ID="hndPrimeravez" runat="server" Value="1" />
            <asp:HiddenField ID="hndAlta" runat="server" Value="1" />
            <asp:HiddenField ID="hndBaja" runat="server" Value="0" />

            <input name="hdnControlErrors" id="hdnControlJS" runat="server" type="hidden">
            <input name="hdnTipoErrors" id="hndTipoError" runat="server" type="hidden">
            <input name="hdnTitulo" id="hdnTitulo" runat="server" type="hidden">
            <input name="hdnRedirect" id="hdnRedirect" runat="server" type="hidden">
            <input name="hdnReload" id="hdnReload" runat="server" type="hidden">
        </ContentTemplate>
     </asp:UpdatePanel>
    
    <div class="container Multiopcion">
        <div class="row" style="margin-top: 0px !important; margin-bottom: 15px !important">
            <div class="col-md-3 col-sm-3 text-left pd-l-0">
                <h1><label id="lblTituloPag" runat="server">NUEVO PORTE</label></h1>
            </div>
            <div class="col-md-2 col-sm-2 text-center" style="margin-top: 20px;">
                <div id="cajaEstado" runat="server">
                    <div id="dFacturado" runat="server" class="col-md-4 col-sm-4 FacCobPagRojo" data-toggle="tooltip" data-placement="bottom" title="Porte Facturado. Fondo rojo=No, Verde = SI" style="-webkit-border-radius: 4px 0px 0px 4px; -moz-border-radius: 4px 0px 0px 4px; border-radius: 4px 0px 0px 4px;"><label id="lblFacturado" runat="server" class="FacCobPag" style="margin-top:5px;">F</label></div>
                    <div id="dCobrado" runat="server" class="col-md-4 col-sm-4 FacCobPagRojo" data-toggle="tooltip" data-placement="bottom" title="Porte Cobrado. Fondo rojo=No, Verder = Si"><label id="lblCobrado" runat="server" class="FacCobPag" style="margin-top:5px;">C</label></div>
                    <div id="dPagado" runat="server" class="col-md-4 col-sm-4 FacCobPagRojo" data-toggle="tooltip" data-placement="bottom" title="Porte Pagado. Fondo rojo=No, Verde = Si" style="-webkit-border-radius: 0px 4px 4px 0px; -moz-border-radius: 0px 4px 4px 0px; border-radius: 0px 4px 4px 0px;"><label id="lblPagado" runat="server" class="FacCobPag" style="margin-top:5px;">P</label></div>
                </div>
            </div>
            <div class="col-md-7 col-sm-7 pd-r-0" style="margin-top: 20px;">
                <div style="float:right;">
                    <div class="col-md-3 col-sm-3 col-xs-3 form-group pd-l-0 pd-r-5">
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">Nº</span>
                                <asp:TextBox ID="txtNumPorte" runat="server" CssClass="form-control date-picker hasDatepicker" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9 col-sm-9 col-xs-9 pd-l-5 pd-r-5">
                        <div class="col-md-6 col-sm-6 col-xs-6 form-group pd-l-0 pd-r-5">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Fecha Porte</span>
                                    <asp:TextBox ID="txtFecPorte" runat="server" CssClass="form-control date-picker hasDatepicker"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-6 form-group pd-l-5 pd-r-0">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Fecha Entrega</span>
                                    <asp:TextBox ID="txtFecEntrega" runat="server" CssClass="form-control date-picker hasDatepicker"></asp:TextBox>
                                </div>
                            </div>
                        </div>                     
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row container_summary resultados" style="margin-top:0px;">
            <div class="pestanas col-md-12 col-sm-12 pd-l-0 pd-r-0">
                <div id="cajabotones" style="float: right; position: absolute; top: 0; z-index: 1; right: 0;">
                    <asp:UpdatePanel runat="server" ID="UP_Botones" UpdateMode="Conditional">
                        <ContentTemplate>
                            <button type="button" class="btn btn-fol btn-fol-forms-grey hvr-grow-shadow" id="btnBtnPrecios" runat="server"><span class="fa fa-euro-sign" onclick="javascript: Precios();"></span>&nbsp;&nbsp;Precios</button>
                            <button type="button" class="btn btn-fol btn-fol-forms-grey hvr-grow-shadow" id="btnBtnBusPrecios" runat="server" onclick="javascript: BuscardorPrecios();">Buscar Precios&nbsp;&nbsp;<span class="fa fa-search"></span></button>

                            <button type="button" id="btnGuardar" runat="server" class="btn btn-fol btn-fol-forms-grey hvr-grow-shadow" ><span class="far fa-save"></span>&nbsp;&nbsp;Guardar</button>
                            <button type="button" class="btn btn-fol btn-fol-forms-grey hvr-grow-shadow" id="btnCancel" runat="server" onclick="javascript: Salir();">Cancelar&nbsp;&nbsp;<span class="fa fa-undo"></span></button>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="pestanas" style="float: left; position: absolute; top: 0; z-index: 0;">
                    <!-- Nav tabs -->
                    <ul id="tabs" class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#TabDatosPorte" aria-controls="future" role="tab" data-toggle="tab" data-tab="1">Datos Porte</a></li>
                        <li role="presentation" class=""><a href="#TabSuplidos" aria-controls="eligible" role="tab" data-toggle="tab" data-tab="2">Suplidos</a></li>
                        <li role="presentation" class=""><a href="#TabFacturaPago" aria-controls="eligible" role="tab" data-toggle="tab" data-tab="3">Factura - Pago</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="TabDatosPorte">
                            <div class="registro" style="padding-top: 10px">
                                <div class="row registro"style="margin-bottom: 10px;">
                                    <div class="col-md-4 col-sm-4 pd-l-5 pd-r-5">
                                        <div class="col-md-4 col-sm-4 pd-l-0 pd-r-5 form-group">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon">TNS</span>
                                                    <input class="string NumericField form-control" id="txtTns" type="text" runat="server" maxlength="2" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-8 col-sm-8 pd-l-5 pd-r-5 form-group">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon">VOLUMEN</span>
                                                    <asp:DropDownList runat="server" ID="ddlVolumen" CssClass="form-control selectpicker show-tick" data-width="auto">
                                                        <asp:ListItem Selected="True" Value="" Text="Seleccionar"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-8 col-sm-8 pd-l-5 pd-r-5">
                                        <div class="col-md-4 col-sm-4 pd-l-5 pd-r-5 form-group">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon">COMPRA</span>
                                                    <input class="string NumericField form-control" id="txtCompra" type="text" runat="server" maxlength="8" />
                                                    <span class="input-group-addon"><i class="fa fa-euro-sign"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4 pd-l-5 pd-r-5 form-group">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon">VENTA</span>
                                                    <input class="string NumericField form-control" id="txtVenta" type="text" runat="server" maxlength="8" />
                                                    <span class="input-group-addon"><i class="fa fa-euro-sign"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4 pd-l-5 pd-r-5 form-group">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon">SALDO</span>
                                                    <input class="string NumericField form-control" id="txtSaldo" type="text" runat="server" maxlength="8" readonly="readonly" />
                                                    <span class="input-group-addon"><i class="fa fa-euro-sign"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- CLIENTE, DIR CLIENTE -->
                                <div class="row registro">
                                    <div class="panel panel-default" style="width: 100%">
                                        <div class="panel-heading" style="background-color:#626060 !important; color:#fff;">
                                            <table border="0" style="width: 100%;">
                                                <tr>
                                                    <td>
                                                        <h3 class="panel-title"><b>DATOS CLIENTE Y ORIGEN DEL PORTE</b></h3>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="panel-body" style="display: inline-block; width: 100%; background-color: #fff;">
                                            <asp:UpdatePanel runat="server" ID="UP_Cliente" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                <div class="row registro">
                                                    <div class="col-md-5 col-sm-5 col-xs-5 pd-l-0 pd-r-0">
                                                        <div class="col-md-12 col-sm-12 col-xs-12 form-group pd-l-0 pd-r-0">
                                                            <Label class="txtCliente"><i class="fa fa-user"></i> Cliente</Label>
                                                            <div class="pd-l-0 pd-r-0">
                                                                <div class="col-md-2 col-sm-2 col-xs-2 form-group pd-l-0">
                                                                    <asp:TextBox class="string form-control" id="txtCodCli" runat="server" maxlength="4"  AutoPostBack="true" Text="" Height="100%"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-10 col-sm-10 col-xs-10 form-group pd-l-0 pd-r-0">
                                                                    <div class="input-group" style="width:100%;">
                                                                        <asp:TextBox class="string form-control" id="txtCliente" runat="server" maxlength="40" Text="" ReadOnly="true"></asp:TextBox>
                                                                        <asp:Label id="lbldeleteprescriptor" runat="server" class="input-group-addon btn pd-l-5 pd-r-5" onclick="DeleteCliente();"><span id="ico_delete_cliente" class="fa fa-times"></span></asp:Label>
                                                                        <asp:Label id="lblicobuscadorPrescriptor" runat="server" class="input-group-addon btn btn_ico activo" onclick="OpenBuscadorClientes();"><span id="ico_buscador_cliente" class="fa fa-search"></span></asp:Label>
                                                                        <asp:Label id="lblicoAddCliente" runat="server" class="input-group-addon btn btn_ico activo" onclick="AddCliente();"><span id="ico_add_cliente" class="fa fa-plus"></span></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-12 col-sm-12 col-xs-12 pd-l-0 pd-r-0" style="margin-top: 35px">
                                                            <Label class="txtCliente"><i class="fa fa-map-marker-alt"></i> Dirección Cliente libre</Label>
                                                            <asp:TextBox ID="txtDircargaLibre" class="form-control" style="min-width: 100%" runat="server" TextMode="MultiLine" Wrap="true" Rows="6"  maxlength="1500"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div id="dirCargaCliente" class="col-md-7 col-sm-7 col-xs-7" style="height: 235px !important; margin-top:15px;">
                                                        <div class="panel panel-default" style="height: 100%;">
                                                            <div class="panel-heading">
                                                                <table border="0" style="width: 100%;">
                                                                    <tr>
                                                                        <td style="width: 40px; margin-right: 15px;">
                                                                            <img class="boton_icono_sombra icono" id="btnAdd_Agenda" src="images/ico_button_add_grey.png" runat="server" title="Añadir Dirección carga Cliente" />
                                                                        </td>
                                                                        <td style="width: 30px;"></td>
                                                                        <td>
                                                                            <h3 class="panel-title"><b>DIRECCIÓN CARGA CLIENTE</b></h3>
                                                                        </td>
                                                                        <td class="totalregAgenObserva">
                                                                            <label id="lblTotalRegsAgenda" runat="server"></label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div class="panel-body" style="display: inline-block; width: 100%; max-height: 180px; overflow-y: auto; background-color: #fff;">
                                                                <asp:UpdatePanel runat="server" ID="UPanelDirCarga" UpdateMode="Conditional">
                                                                <ContentTemplate>
                                                                    <asp:GridView ID="gcDirCarga" runat="server" 
				                                                        Width="100%" 
				                                                        PageSize="150" 
				                                                        AutoGenerateColumns="false" 
				                                                        AllowSorting="false" 
				                                                        CssClass="tab-GridView GridView_CliCarga table-sm"
                                                                        AllowPaging="false"
                                                                         Font-Size="Small">
				                                                        <AlternatingRowStyle />
				                                                        <RowStyle />
				                                                        <HeaderStyle />
                                                                        <PagerSettings  Mode="NumericFirstLast" FirstPageText="|<" PreviousPageText="<" NextPageText=">" LastPageText=">|" />
                                                                        <PagerStyle HorizontalAlign = "Right" CssClass="pagination-ys" />
				                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="" ItemStyle-Width="1%" HeaderStyle-Width="1%" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Top" ItemStyle-BackColor="Transparent">
                                                                                <ItemTemplate>
                                                                                    <asp:RadioButton ID="rd_DirCarga_id" runat="server" AutoPostBack="true" GroupName="rdDirCarga_id" ValidationGroup="rdDirCarga_id" OnCheckedChanged="rd_DirCarga_id_CheckedChanged" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="DIRECCIÓN CARGA" ItemStyle-Width="47%" HeaderStyle-Width="40%">
                                                                                <ItemTemplate>
                                                                                    <asp:HiddenField ID="hnd_Dircarga_id" runat="server" Value='<%# Bind("CODDIRCLI")%>' />
                                                                                    <asp:Label ID="lbl_DIRCARGA" runat="server" Text='<%# Bind("DIRECCION")%>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>

                                                                            <asp:TemplateField HeaderText="POBLACIÓN" ItemStyle-Width="30%" HeaderStyle-Width="30%">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbl_POBLACION" runat="server" Text='<%# Bind("POBLACION")%>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="PROVINCIA" ItemStyle-Width="20%" HeaderStyle-Width="20%">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbl_PROVINCIA" runat="server" Text='<%# Bind("PROVINCIA")%>'></asp:Label>
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
                                                </div>
                                            </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- MATRICULA, AGENCIA -->
                                <div class="row registro">
                                    <div class="panel panel-default" style="width: 100%">
                                        <div class="panel-heading" style="background-color:#626060 !important; color:#fff;">
                                            <table border="0" style="width: 100%;">
                                                <tr>
                                                    <td>
                                                        <h3 class="panel-title"><b>TRANSPORTISTA</b></h3>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="panel-body" style="display: inline-block; width: 100%;background-color: #fff;">
                                            <div class="row registro">
                                                <div class="col-md-9 col-sm-9 col-xs-9 pd-l-0 pd-r-0">
                                                    <asp:UpdatePanel ID="UPMatricula" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <div class="col-md-3 col-sm-3 col-xs-3 form-group pd-l-0">
                                                            <label for="txtMatricula"><i class="fa fa-truck"></i> Matrícula</label>
                                                            <div class="input-group">
                                                                <asp:TextBox class="string form-control" id="txtMatricula" runat="server" maxlength="15" Text=""></asp:TextBox>
                                                                <asp:Label id="lblDeleteMatricula" runat="server" class="input-group-addon btn pd-l-5 pd-r-5" onclick="DeleteTransportista();"><span id="ico_delete_matricula" class="fa fa-times"></span></asp:Label>
                                                                <asp:Label id="lblicobuscadorMatricula" runat="server" class="input-group-addon btn btn_ico activo" onclick="OpenBuscadorTransportistas();"><span id="ico_buscador_matricula" class="fa fa-search"></span></asp:Label>
                                                                <asp:Label id="lblicoAddMatricula" runat="server" class="input-group-addon btn btn_ico activo" onclick="AddTransportista();"><span id="ico_add_transportista" class="fa fa-plus"></span></asp:Label>
                                                                <asp:HiddenField ID="hndCodTransportista" runat="server" Value="" />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-5 col-sm-5 col-xs-5 form-group pd-l-0">
                                                            <label for="lbl_Conductor"><i class="fa fa-truck"></i> CONDUCTOR</label>
                                                            <asp:TextBox class="string form-control" id="txtConductor" runat="server" Text="" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-md-4 col-sm-4 col-xs-4 form-group pd-l-0 pd-r-0">
                                                            <label for="lblPropietario"><i class="fa fa-truck"></i> PROPIETARIO</label>
                                                            <asp:TextBox class="string form-control" id="txtPropietario" runat="server" Text="" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                                <div class="col-md-3 col-sm-3 col-xs-3 form-group">
                                                    <label for="dllAgencias"><i class="fa fa-th-list"></i> Agencia</label>
                                                    <asp:DropDownList runat="server" ID="ddlAgencias" CssClass="form-control selectpicker show-tick" data-width="100%">
                                            
                                                    </asp:DropDownList>  
                                                </div>                                    
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                            
                                <!-- MERCANCIA, DESTINO, OBSERVACIONES, INCIDENCIAS -->
                                <div class="row registro">
                                    <div class="panel panel-default" style="width: 100%">
                                        <div class="panel-heading" style="background-color:#626060 !important; color:#fff;">
                                            <table border="0" style="width: 100%;">
                                                <tr>
                                                    <td>
                                                        <h3 class="panel-title"><b>DATOS DEL DESTINO</b></h3>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="panel-body" style="display: inline-block; width: 100%; background-color: #fff;">
                                            <div class="row registro pd-l-0 pd-r-0" style="padding-top: 10px !important;">
                                                <div class="col-md-6 col-sm-6 form-group">
                                                    <span><i class="fa fa-cube"></i> DETALLE PORTE</span>
                                                    <asp:TextBox ID="txtDetalle" class="form-control" style="min-width: 100%" runat="server" TextMode="MultiLine" Wrap="true" Rows="6"  placeholder="Indique la mercancia del porte ..." maxlength="1500"></asp:TextBox>
                                                    <span><label id="detalle_numcars"></label></span>
                                                </div>
                                                <div class="col-md-6 col-sm-6 form-group">
                                                    <span><i class="fa fa-cube"></i> MERCANCIA</span>
                                                    <asp:TextBox ID="txtMercancia" class="form-control" style="min-width: 100%" runat="server" TextMode="MultiLine" Wrap="true" Rows="6"  placeholder="Indique la mercancia del porte ..." maxlength="1500"></asp:TextBox>
                                                    <span><label id="mercancia_numcars"></label></span>
                                                </div>
                                            </div>
                                            <div class="row registro pd-l-0 pd-r-0">
                                                <div class="col-md-6 col-sm-6 form-group pd-l-5 pd-r-5 pd-t-0">
                                                    <div class="row col-md-12 col-sm-12 form-group">
                                                        <span><i class="fa fa-arrow-right"></i><i class="fa fa-map-marker-alt"></i> DESTINO PORTE</span>
                                                        <asp:TextBox ID="txtDestino" class="form-control" style="min-width: 100%" runat="server" TextMode="MultiLine" Wrap="true" Rows="3" placeholder="Indique el destino del porte ..." maxlength="1500"></asp:TextBox>
                                                        <span><label id="destino_numcars"></label></span>
                                                    </div>
                                                    <div class="row col-md-12 col-sm-12 form-group">
                                                        <span><i class="fas fa-info-circle"></i> DETALLE DESTINO PORTE</span>
                                                        <asp:TextBox ID="txtDetalleDestino" class="form-control" style="min-width: 100%" runat="server" TextMode="MultiLine" Wrap="true" Rows="3" placeholder="Indique el destino del porte ..." maxlength="1500"></asp:TextBox>
                                                        <span><label id="detalle_destino_numcars"></label></span>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 col-sm-6 form-group">
                                                    <span><i class="fa fa-comment"></i> OBSERVACIONES (DESIGNACIÓN)</span>
                                                    <asp:TextBox ID="txtObservaciones" class="form-control" style="min-width: 100%" runat="server" TextMode="MultiLine" Wrap="true" Rows="9" placeholder="Indique las observaciones del porte ..." maxlength="1500"></asp:TextBox>
                                                    <span><label id="observaciones_numcars"></label></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- OTROS DATOS -->
                                <div class="row registro">
                                    <div class="panel panel-default" style="width: 100%">
                                        <div class="panel-heading" style="background-color:#626060 !important; color:#fff;">
                                            <table border="0" style="width: 100%;">
                                                <tr>
                                                    <td>
                                                        <h3 class="panel-title"><b>OTROS DATOS</b></h3>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="panel-body" style="display: inline-block; width: 100%; background-color: #fff;">                                           
                                            <div class="row registro pd-l-0 pd-r-0" style="padding-top: 10px !important;">
                                                <div class="col-md-6 col-sm-6 form-group">
                                                    <span><i class="far fa-list-alt"></i> INCIDENCIAS</span>
                                                    <asp:TextBox ID="txtIncidencias" class="form-control" style="min-width: 100%" runat="server" TextMode="MultiLine" Wrap="true" Rows="6" placeholder="Indique las incidencias del porte ..." maxlength="1500"></asp:TextBox>
                                                    <span><label id="incidencias_numcars"></label></span>
                                                </div>
                                                <div class="col-md-6 col-sm-6 form-group">
                                                    <span><i class="far fa-list-alt"></i> LÍNEAS FACTURA</span>
                                                    <asp:TextBox ID="txtLineasFactura" class="form-control" style="min-width: 100%" runat="server" TextMode="MultiLine" Wrap="true" Rows="6" placeholder="Indique las incidencias del porte ..." maxlength="1500"></asp:TextBox>
                                                    <span><label id="lineasfactu_numcars"></label></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div role="tabpanel" class="tab-pane" id="TabSuplidos">
                            <div class="registro" style="padding-top: 10px">
                                <div class="panel-body" style="display: inline-block; width: 100%; background-color: #fff;">
                                    <div class="row registro">
                                        <div class="col-md-8 col-sm-8">
                                            <div class="form-group">
                                                <Label class="txtSuplidos"><i class="fas fa-clipboard-list"></i> DETALLE SUPLIDOS</Label>
                                                <asp:TextBox ID="txtSuplidos" class="form-control" runat="server" TextMode="MultiLine" Wrap="true" Rows="6" placeholder="Indique los suplidos del porte ..." maxlength="1500"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                            <div class="form-group">
                                                <label for="lbl_Conductor"><i class="fa fa-euro-sign"></i> IMPORTE SUPLIDOS</label>
                                                <div class="input-group">
                                                    <input class="string NumericField form-control" id="txtImporteSuplido" type="text" runat="server" maxlength="8" />
                                                    <span class="input-group-addon"><i class="fa fa-euro-sign"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                            <div class="form-group">
                                                <label for="ddlIvaSuplido"><i class="fa fa-th-list"></i> I.V.A.</label>
                                                <asp:DropDownList runat="server" ID="ddlIvaSuplido" CssClass="form-control selectpicker show-tick" data-width="100%">
                                                    <asp:ListItem Selected="True" Value="N" Text="NO"></asp:ListItem>
                                                    <asp:ListItem Value="S" Text="SI"></asp:ListItem>
                                                </asp:DropDownList>  
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div role="tabpanel" class="tab-pane" id="TabFacturaPago">
                            <div class="registro" style="padding-top: 10px">
                                <div class="panel-body" style="display: inline-block; width: 100%; background-color: #fff;">
                                    <div class="row registro">
                                        <div class="col-md-5 col-sm-5 pd-l-0 pd-r-0">
                                            <div class="panel panel-default" style="width: 100%">
                                                <div class="panel-heading" style="background-color:#626060 !important; color:#fff;">
                                                    <table border="0" style="width: 100%;">
                                                        <tr>
                                                            <td>
                                                                <h3 class="panel-title"><b>PAGO PORTE</b></h3>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="panel-body" style="display: inline-block; width: 100%; background-color: #fff;">
                                                    <div class="col-md-6 col-sm-6 form-group">
                                                        <label for="txtFecLimVal">Fecha Pago</label>
                                                        <div class="input-group">
                                                            <asp:TextBox ID="txtFechaPago" runat="server" CssClass="form-control date-picker hasDatepicker textred" ReadOnly="true"></asp:TextBox>
                                                            <label for="date-picker" class="input-group-addon"><span class="fa fa-calendar"></span></label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 col-sm-6 form-group">
                                                        <label for="txtFecLimVal">Nº Recibo</label>
                                                        <div class="input-group">
                                                            <asp:TextBox ID="txtNumRecibo" runat="server" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-2">&nbsp;</div>
                                        <div class="col-md-5 col-sm-5 pd-l-0 pd-r-0">
                                            <div class="panel panel-default" style="width: 100%">
                                                <div class="panel-heading" style="background-color:#626060 !important; color:#fff;">
                                                    <table border="0" style="width: 100%;">
                                                        <tr>
                                                            <td>
                                                                <h3 class="panel-title"><b>FACTURA</b></h3>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="panel-body" style="display: inline-block; width: 100%; background-color: #fff;">
                                                    <div class="col-md-6 col-sm-6 form-group">
                                                        <label for="txtFecLimVal">Fecha Cobro</label>
                                                        <div class="input-group">
                                                            <asp:TextBox ID="txtFechaCobro" runat="server" CssClass="form-control date-picker hasDatepicker textred" ReadOnly="true"></asp:TextBox>
                                                            <label for="date-picker" class="input-group-addon"><span class="fa fa-calendar"></span></label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 col-sm-6 form-group">
                                                        <label for="txtFecLimVal">Nº Factura</label>
                                                        <div class="input-group">
                                                            <asp:TextBox ID="txtNumFactura" runat="server" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
        </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

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
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <div style="height:25px"></div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpFooter" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphScripts" runat="server">
    <script type="text/javascript">
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_initializeRequest(InitializeRequest);
        prm.add_endRequest(EndRequest);
        var postBackElement;
        function InitializeRequest(sender, args) {
            $("#hdnRedirect").val('');
            $("#hdnReload").val('');
            $('#ctl00_MainContent_hdnControlJS').val('');

            if (prm.get_isInAsyncPostBack()) {
                args.set_cancel(true);
            }
            postBackElement = args.get_postBackElement();
            $get('UpdateProgress1').style.display = "block";
        }
        function EndRequest(sender, args) {
            if (args.get_error() != undefined){
                //**alert(args.get_error().message.substr(args.get_error().name.length + 2));**
                args.set_errorHandled(true);
            }
            $('#ctl00_UpdateProgress1').hide();

            pageLoad();
            CompruebaErrores();
        }
        function AbortPostBack() {
            $('#ctl00_UpdateProgress1').hide();
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

        $(document).ready(function () {
            //Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {   });

            $('.panel-heading span.clickable').on("click", function (e) {
                if ($(this).hasClass('panel-collapsed')) {
                    // expand the panel
                    $(this).parents('.panel').find('.panel-body').slideDown();
                    $(this).removeClass('panel-collapsed');
                    $(this).find('i').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
                }
                else {
                    // collapse the panel
                    $(this).parents('.panel').find('.panel-body').slideUp();
                    $(this).addClass('panel-collapsed');
                    $(this).find('i').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
                }
            });

            if ($("#ctl00_MainContent_hndAlta").val == "0") {
                //$("#ico_buscador_prescriptor").addClass = "fa-user"
                //$("#ico_buscador_prescriptor").removeClass = "fa-search"
            }

            pageLoad();

            $('#ctl00_UpdateProgress1').hide();
            CompruebaErrores();

            $(document).on('scroll', function () {
                if ($(window).scrollTop() > 100) {
                    $('.scroll-top-wrapper').addClass('show');
                } else {
                    $('.scroll-top-wrapper').removeClass('show');
                }
            });

            $('.scroll-top-wrapper').on('click', scrollToTop);

            //if ($("#ctl00_MainContent_hndRenovacion").val() == "S") { $("#ctl00_MainContent_txtFecFinRenovacion").focus(); }
            //if ($("#ctl00_MainContent_hndBaja").val() == "1") { $("#ctl00_MainContent_txtFecBaja").focus(); }

            $('[data-toggle="tooltip"]').tooltip();
            $("#dFacturado").tooltip({
                template: '<div class="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-head"><h3><span class="fas fa-info-circle"></span> Facturado</h3></div><div class="tooltip-inner"></div></div>',
                title: 'Si fondo Rojo, el porte no ha sido facturado. Si el fondo es Verde, ha sido facturado.',
                html: true
            });
        });

        function scrollToTop() {
            verticalOffset = typeof (verticalOffset) != 'undefined' ? verticalOffset : 0;
            element = $('body');
            offset = element.offset();
            offsetTop = offset.top;
            $('html, body').animate({ scrollTop: 0 }, 200, 'linear');
        }

        function MuestraError(msg, tipo, titulo) {
            $('#ctl00_MainContent_hdnControlJS').val(msg);
            $('#ctl00_MainContent_hndTipoError').val(tipo);
            $('#ctl00_MainContent_hdnTitulo').val(titulo);
            if (msg != '') {
                CompruebaErrores();
            }
        }
        $("#ctl00_MainContent_btnGuardar").on('click', function () {
            if ($("#ctl00_MainContent_hndBaja").val() == "1") {
                $('#CapaConfirm').modal('show');
                return false;
            } else {
                javascript: __doPostBack('Guardar', 'JavaScript')
            }
        });
        $('#CapaConfirm').on('click', '#btnConfirmAceptar', function (e) {           
            var $modalDiv = $(e.delegateTarget);
            javascript: __doPostBack('delete', 'JavaScript')
        });
        $('#CapaConfirm').on('show.bs.modal', function (e) {
            var data = $(e.relatedTarget).data();
            //$('.title', this).text(data.recordTitle);
            //$('.btn-ok', this).data('recordId', data.recordId);

            $('#lblMsgConfirm').html('<b>¿ Seguro que desea dar de Baja este Porte ?</b> <br/>');
            var modal = $('#CapaConfirm');
            modal.find('.modal-title').text('Confirmar Baja de Porte');
            modal.find('.modal-header').css({
                "background-color": "#D9534F",
                "color": "#fff"
            });
            $("#btnConfirmCancel").focus();
        });
        $('#CapaMensajes').on('show.bs.modal', function (event) {
            $('#btnCapaMensajesAceptar').focus();
        });
        $('#CapaMensajes').on('hide.bs.modal', function (event) {
            $('#ctl00_MainContent_hdnControlJS').val('');
            var EndSession = $('#ctl00_MainContent_hndEndSession').val();
            if (EndSession == "S") {
                document.location.href = 'Login.aspx';
            }
        });
        $('#CapaMensajes').on('click', '#btnCapaMensajesAceptar', function (e) {
            var hdnRedirect = $("#ctl00_MainContent_hdnRedirect").val();
            var hdnReload = $("#ctl00_MainContent_hdnReload").val();
            if (hdnRedirect != "") {
                document.location.href = hdnRedirect;
            } else {
                if (hdnReload != "") {
                    location.reload();
                }
            }
        });

        function Salir() {
            document.location.href = 'portes_listado.aspx';
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
        function pageLoad() {
            ReloadDatepickers();

            recarga_eventos_jquery();
        }
        
        function recarga_eventos_jquery() {
            
        }

        function humanizeNumber(n, decimals) {
            var dec_point = ",";
            var thousands_sep = ".";
            number = (n + '').replace(/[^0-9+\-Ee.]/g, '');
            var n = !isFinite(+number) ? 0 : +number,
                prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
                sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
                dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
                s = '',
                toFixedFix = function (n, prec) {
                    var k = Math.pow(10, prec);
                    return '' + Math.round(n * k) / k;
                };
            // Fix for IE parseFloat(0.55).toFixed(0) = 0;
            s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
            if (s[0].length > 3) {
                s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
            }
            if ((s[1] || '').length > prec) {
                s[1] = s[1] || '';
                s[1] += new Array(prec - s[1].length + 1).join('0');
            }
            if (decimals > 0) {
                if ((s[1]).length < prec) {
                    s[1] += "0";
                }
            }
            // Add this number to the element as text.
            return s.join(dec);
        }

        function ReloadDatepickers() {
            $("#ctl00_MainContent_ddlVolumen").selectpicker('refresh');
            $("#ctl00_MainContent_ddlVolumen").selectpicker('render');

            $("#ctl00_MainContent_ddlAgencias").selectpicker('refresh');
            $("#ctl00_MainContent_ddlAgencias").selectpicker('render');

            /* CALENDARIOS ============================================== */
            $('#ctl00_MainContent_txtFecPorte').daterangepicker({
                "autoUpdateInput": false,
                "showDropdowns": true,
                "autoApply": false,
                "singleDatePicker": true,
                "drops": "down",
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
                "minDate": moment().subtract('month', 60).startOf('month'),
                "cancelClass": "btn-cleantxtVehRegDate"
            }, function (start, end, label) {
                $('#ctl00_MainContent_txtFecPorte').val(start.format('DD/MM/YYYY'));
            });
            /* Acciones de calendarios para reiniciar los input */
            $('.btn-cleantxtFecPorte').on('click', function () {
                $("#ctl00_MainContent_txtFecPorte").val('');
            });

            $('#ctl00_MainContent_txtFecEntrega').daterangepicker({
                "autoUpdateInput": false,
                "showDropdowns": true,
                "autoApply": false,
                "singleDatePicker": true,
                "drops": "down",
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
                "minDate": moment().subtract('month', 60).startOf('month'),
                "cancelClass": "btn-cleantxtVehRegDate"
            }, function (start, end, label) {
                $('#ctl00_MainContent_txtFecEntrega').val(start.format('DD/MM/YYYY'));
            });
            /* Acciones de calendarios para reiniciar los input */
            $('.btn-cleantxtFecEntrega').on('click', function () {
                $("#ctl00_MainContent_txtFecEntrega").val('');
            });
        };
                
        // SOLO NUMEROS sin puntos sin coma
        $("#ctl00_MainContent_txtTns").keydown(function (event) {
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
        // SOLO NUMEROS sin puntos con coma
        $("#ctl00_MainContent_txtCompra, #ctl00_MainContent_txtVenta, #ctl00_MainContent_txtImporteSuplido").keydown(function (event) {
            //8=backspace; 9=tab; 46=delete; 188=coma; >=35 <=40 arrow keys/home/end; >=48 <=57 numbers on keyboard; >=96 <=105 number on keypad
            if (event.shiftKey) { event.preventDefault(); }
            if (!(event.keyCode == 8
                || event.keyCode == 9
                || event.keyCode == 46
                || event.keyCode == 188
                || (event.keyCode >= 35 && event.keyCode <= 40)
                || (event.keyCode >= 48 && event.keyCode <= 57)
                || (event.keyCode >= 96 && event.keyCode <= 105))
            ) {
                if (event.keyCode == 110) {
                    event.preventDefault();     // Prevent character input
                    $(this).val($(this).val() + ',');
                } else {
                    event.preventDefault();     // Prevent character input
                }
            }
        });
        // SOLO NUMEROS sin puntos sin coma con "/" para las fechas
        $("#ctl00_MainContent_txtCompra").focusout(function (event) {
            var valor = $(this).val();
            if (valor != "") {
                valor = valor.replace(".", "");
                valor = valor.replace(",", ".");
                if (!isNaN(valor) == true) {
                    /*valor = valor.replace(".", "");
                    valor = valor.replace(",", ".");*/
                    $(this).val(humanizeNumber(valor, 2));
                    Calcula_Saldo();
                }
            }
        });
        $("#ctl00_MainContent_txtVenta").focusout(function (event) {
            var valor = $(this).val();
            if (valor != "") {
                valor = valor.replace(".", "");
                valor = valor.replace(",", ".");
                if (!isNaN(valor) == true) {
                    /*valor = valor.replace(".", "");
                    valor = valor.replace(",", ".");*/
                    $(this).val(humanizeNumber(valor, 2));
                    Calcula_Saldo();
                }
            }
        });
        $("#ctl00_MainContent_txtImporteSuplido").focusout(function (event) {
            var valor = $(this).val();
            if (valor != "") {
                valor = valor.replace(".", "");
                valor = valor.replace(",", ".");
                if (!isNaN(valor) == true) {
                    /*valor = valor.replace(".", "");
                    valor = valor.replace(",", ".");*/
                    $(this).val(humanizeNumber(valor, 2));
                }
            }
        });
        function Calcula_Saldo() {
            var Compra = $("#ctl00_MainContent_txtCompra").val();
            var Venta = $("#ctl00_MainContent_txtVenta").val();
            $("#ctl00_MainContent_txtSaldo").val('0,00');
            if (Compra != "" && Venta != "") {
                Compra = Compra.replace(".", "");
                Compra = Compra.replace(",", ".");

                Venta = Venta.replace(".", "");
                Venta = Venta.replace(",", ".");
                if (!isNaN(Compra) == true && !isNaN(Venta)==true) {
                    diferencia = parseFloat(Venta) - parseFloat(Compra);
                    $("#ctl00_MainContent_txtSaldo").val(humanizeNumber(diferencia, 2));
                }
            } else {
                if (Compra != "" && Venta == "") {
                    Compra = Compra.replace(".", "");
                    Compra = Compra.replace(",", ".");
                    if (!isNaN(Compra) == true) {
                        $("#ctl00_MainContent_txtSaldo").val(humanizeNumber(parseFloat(Compra), 2));
                    }
                } else {
                    Venta = Venta.replace(".", "");
                    Venta = Venta.replace(",", ".");
                    if (!isNaN(Venta) == true) {
                        $("#ctl00_MainContent_txtSaldo").val(humanizeNumber(parseFloat(Venta), 2));
                    }
                }
            }
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

            $("#<%=txtCodCli.ClientId%>").trigger("change");
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
            $("#<%=txtPropietario.ClientId%>").val(propietario);
            $("#<%=txtConductor.ClientId%>").val(conductor);
            $('#BuscadorTransportistas').modal('toggle');
        }
        function DeleteTransportista() {
            $("#<%=txtMatricula.ClientId%>").val("");
            $("#<%=txtPropietario.ClientID%>").val("");
            $("#<%=txtConductor.ClientId%>").val("");
        }
        /* FIN BUSCADOR TRANSPORTISTAS */
        function Calcula_NumCars(obj, lbl, maxcars) {
            var maxLength = maxcars;
            var length = obj.val().length;
            var length = maxLength - length;
            var s = "Texto de " + maxLength + " caracteres. Restan " + length + " caracteres.";
            $('#' + lbl).text(s);
        }
        $('#ctl00_MainContent_txtDetalle').keyup(function () {
            var obj = $('#ctl00_MainContent_txtDetalle');
            Calcula_NumCars(obj, 'detalle_numcars', 1500)
        });
        $('#ctl00_MainContent_txtMercancia').keyup(function () {
            var obj = $('#ctl00_MainContent_txtMercancia');
            Calcula_NumCars(obj, 'mercancia_numcars', 1500)
        });
        $('#ctl00_MainContent_txtDestino').keyup(function () {
            var obj = $('#ctl00_MainContent_txtDestino');
            Calcula_NumCars(obj, 'destino_numcars', 1500)
        });
        $('#ctl00_MainContent_txtDetalleDestino').keyup(function () {
            var obj = $('#ctl00_MainContent_txtDetalleDestino');
            Calcula_NumCars(obj, 'detalle_destino_numcars', 1500)
        });
        $('#ctl00_MainContent_txtObservaciones').keyup(function () {
            var obj = $('#ctl00_MainContent_txtObservaciones');
            Calcula_NumCars(obj, 'observaciones_numcars', 1500)
        });
        $('#ctl00_MainContent_txtIncidencias').keyup(function () {
            var obj = $('#ctl00_MainContent_txtIncidencias');
            Calcula_NumCars(obj, 'incidencias_numcars', 1500)
        });
        $('#ctl00_MainContent_txtLineasFactura').keyup(function () {
            var obj = $('#ctl00_MainContent_txtLineasFactura');
            Calcula_NumCars(obj, 'lineasfactu_numcars', 1500)
        });
        
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
    </script>
</asp:Content>
