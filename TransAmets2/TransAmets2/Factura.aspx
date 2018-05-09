<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Factura.aspx.vb" Inherits="TransAmets2.Factura1" %>
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
        #ctl00_MainContent_grSelPortesCopy {margin: 0px !important; padding: 0px !important;height: 30px !important;}
        #ctl00_MainContent_grSelPortes{margin: 0px !important; padding: 0px !important;}
        #ctl00_MainContent_grSelPortesPagerBottom {margin-top:10px;}
        #ctl00_MainContent_grSelPortesHeaderCopy{ text-align: center;}
        #ctl00_MainContent_grSelPortes{
            font-size: 10px !important;
        }
        /*ctl00_MainContent_grSelPortesVerticalRail{top:30px !important;}
        #ctl00_MainContent_grSelPortesVertical_BIMG{top:485px !important;}
        #ctl00_MainContent_grSelPortesHorizontalRail{top:485px !important;}
        #ctl00_MainContent_grSelPortesHorizontalBar{top:485px !important;}
        #ctl00_MainContent_grSelPortesHorizontal_LIMG{top:485px !important;}
        #ctl00_MainContent_grSelPortesHorizontal_RIMG{top:485px !important;}*/

        #ctl00_MainContent_grPortesFacturaCopy {margin: 0px !important; padding: 0px !important;height: 30px !important;}
        #ctl00_MainContent_grPortesFactura{margin: 0px !important; padding: 0px !important;}
        #ctl00_MainContent_grPortesFacturaPagerBottom {margin-top:10px;}
        #ctl00_MainContent_grPortesFacturaHeaderCopy{ text-align: center;}
        #ctl00_MainContent_grPortesFactura{
            font-size: 10px !important;
        }

        #ctl00_MainContent_grCobrosFacturaCopy {margin: 0px !important; padding: 0px !important;height: 30px !important;}
        #ctl00_MainContent_grCobrosFactura{margin: 0px !important; padding: 0px !important;}
        #ctl00_MainContent_grCobrosFacturaPagerBottom {margin-top:10px;}
        #ctl00_MainContent_grCobrosFacturaHeaderCopy{ text-align: center;}
        #ctl00_MainContent_grCobrosFactura{
            font-size: 10px !important;
        }

        #ctl00_MainContent_grFacturaEmailsCopy {margin: 0px !important; padding: 0px !important;height: 30px !important;}
        #ctl00_MainContent_grFacturaEmails{margin: 0px !important; padding: 0px !important;}
        #ctl00_MainContent_grFacturaEmailsPagerBottom {margin-top:10px;}
        #ctl00_MainContent_grFacturaEmailsHeaderCopy{ text-align: center;}
        #ctl00_MainContent_grFacturaEmails{
            font-size: 10px !important;
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
        #ctl00_MainContent_btnSearchPortes{
            margin-top: 30px !important;
            margin-left: 15px !important;
        }

        ::-ms-clear {
          display: none;
        }

        .form-control-clear {
          z-index: 10;
          pointer-events: auto;
          cursor: pointer;
        }
        .input-group .form-control:not(:first-child):not(:last-child), .input-group-addon:not(:first-child):not(:last-child), .input-group-btn:not(:first-child):not(:last-child) {
            border-radius: 0;
        }
        #ctl00_MainContent_btnSearchPortes{width: 40px; margin-top: 25px !important; margin-left: 5px !important;}
        #divAddPortesH:hover, #divPortesFacturaH:hover, #divDatosEconomicosH:hover, #divOtrosDatos:hover{
            cursor:pointer;
            cursor: hand;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Always">
        <ContentTemplate>
            <asp:HiddenField ID="hdnFacturaId" runat="server" />
            <asp:HiddenField ID="hdnNUMFAC" runat="server" />
            <asp:HiddenField ID="hdnClienteId" runat="server" />
            <asp:HiddenField ID="hdnClienteEmail" runat="server" />
            <asp:HiddenField ID="hndPrimeravez" runat="server" Value="1" />
            <asp:HiddenField ID="hndAlta" runat="server" Value="1" />
            <asp:HiddenField ID="hndBaja" runat="server" Value="0" />

            <input name="hdnControlErrors" id="hdnControlJS" runat="server" type="hidden">
            <input name="hdnTipoErrors" id="hndTipoError" runat="server" type="hidden">
            <input name="hdnTitulo" id="hdnTitulo" runat="server" type="hidden">
            <input name="hdnRedirect" id="hdnRedirect" runat="server" type="hidden">
            <input name="hdnReload" id="hdnReload" runat="server" type="hidden">

            <input name="hdnFilePDF" id="hdnFilePDF" runat="server" type="hidden" />
        </ContentTemplate>
     </asp:UpdatePanel>
    
    <div class="container Multiopcion">
        <div class="row" style="margin-top: 0px !important; margin-bottom: 15px !important">
            <div class="col-md-4 col-sm-4 text-left pd-l-0">
                <h1><label id="lblTituloPag" runat="server">NUEVA FACTURA</label></h1>
            </div>
            <div class="col-md-1 col-sm-1 text-center" style="margin-top: 20px;">
                
            </div>
            <div class="col-md-7 col-sm-7 pd-r-0" style="margin-top: 20px;">
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
        
        <div class="row container_summary resultados" style="margin-top:0px;">
            <div class="pestanas col-md-12 col-sm-12 pd-l-0 pd-r-0">
                <div id="cajabotones" style="float: right; position: absolute; top: 0; z-index: 1; right: 0;">
                    <asp:UpdatePanel runat="server" ID="UP_Botones" UpdateMode="Conditional">
                        <ContentTemplate>
                            <button type="button" class="btn btn-fol btn-fol-forms-grey hvr-grow-shadow" id="btnEmail" runat="server" onclick="javascript: EnviarEmail();">Envío Email&nbsp;&nbsp;<span class="fa fa-envelope"></span></button>
                            <button type="button" class="btn btn-fol btn-fol-forms-grey hvr-grow-shadow" id="btnOpenFactura" runat="server" onclick="javascript: OpenFactura();">Abrir&nbsp;&nbsp;<span class="fa fa-eye"></span></button>
                            <button type="button" class="btn btn-fol btn-fol-forms-grey hvr-grow-shadow" id="btnBtnImprimir" runat="server" onclick="javascript: Imprimir();">Imprimir&nbsp;&nbsp;<span class="fas fa-print"></span></button>

                            <button type="button" id="btnGuardar" runat="server" class="btn btn-fol btn-fol-forms-grey hvr-grow-shadow" ><span class="far fa-save"></span>&nbsp;&nbsp;Guardar</button>
                            <button type="button" class="btn btn-fol btn-fol-forms-grey hvr-grow-shadow" id="btnCancel" runat="server" onclick="javascript: Salir();">Cancelar&nbsp;&nbsp;<span class="fa fa-undo"></span></button>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="pestanas" style="float: left; position: absolute; top: 0; z-index: 0;">
                    <!-- Nav tabs -->
                    <ul id="tabs" class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#TabDatosPorte" aria-controls="future" role="tab" data-toggle="tab" data-tab="1">Datos Factura</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="TabDatosPorte">
                            <div class="registro" style="padding-top: 10px">
                                <div class="row registro"style="margin-bottom: 10px;">
                                    <div class="col-md-3 col-sm-3 col-xs-3 pd-l-5 pd-r-5">
                                        <div class="form-group has-feedback has-clear">
                                            <div class="input-group">
                                                <span class="input-group-addon">Nº Factura</span>
                                                <asp:TextBox ID="txtNumFactura" runat="server" CssClass="string NumericField form-control" MaxLength="9"></asp:TextBox>
                                                <!--<span class="form-control-clear glyphicon glyphicon-remove form-control-feedback hidden"></span>-->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-3 col-xs-3 form-group pd-l-5 pd-r-5">
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-calendar"></i> Fecha Factura</span>
                                                <asp:TextBox ID="txtFecFactura" runat="server" CssClass="form-control date-picker hasDatepicker"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-3 col-xs-3 form-group pd-l-5 pd-r-5">
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-calendar"></i> Fecha Vencimiento</span>
                                                <asp:TextBox ID="txtFecVencimiento" runat="server" CssClass="form-control date-picker hasDatepicker"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-3 col-xs-3 form-group pd-l-5 pd-r-5">
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-calendar"></i> Fecha Cobro</span>
                                                <asp:TextBox ID="txtFecCobro" runat="server" CssClass="form-control date-picker hasDatepicker"></asp:TextBox>
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
        <div class="container pd-l-0 pd-r-0">
            <div class="row container_summary">
                <!-- SELECCIÓN DE PORTES -->
                <div class="row col-md-12 col-sm-12 pd-l-0 pd-r-0" style="margin-top:10px !important;">
                    <div id="divAddPortes" style="position: relative; left: 0px; top: 0px; height: 100%; z-index: 5; right: 0px; margin: 0px auto; margin-top: 80px;">
                        <div id="divPortesClientePend" runat="server" class="panel panel-default">
                            <div id="divAddPortesH" class="panel-heading" style="background-color: #626060 !important; color: #fff;">
                                <table border="0" class="clickable" style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title"><b><i class="fa fa-truck"></i>  SELECCIÓN DE PORTES A INCLUIR EN LA FACTURA</b></h3>
                                        </td>
                                        <td class="boton_collapse" style="width: 30px; border-left:1px solid #808080;">
                                            <span class="pull-right"><i class="glyphicon glyphicon-chevron-up"></i></span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" style="display: inline-block; width: 100%; min-height:500px; overflow-y:hidden; overflow-y: hidden; background-color: #fff;">
                                <div class="row pd-l-0 pd-r-0" style="margin-top: 10px; background-color: #ffffff !important;">
                                    <asp:UpdatePanel runat="server" ID="UP_Filtros_Portes" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <div id="tbl_filterPortes" class="row" style="border-bottom:1px solid #c7c7c7;">
                                            <div class="col-md-5 col-sm-5 col-xs-5 pd-l-5 pd-r-0">
                                                <div class="col-md-5 col-sm-5 col-xs-5 form-group pd-l-0 pd-r-5">
                                                    <label for="ddlTipoPorte"><i class="fa fa-th-list"></i> TIPO DE PORTES</label>
                                                    <asp:DropDownList runat="server" ID="ddlTipoPorte" CssClass="form-control selectpicker show-tick" data-width="100%">
                                                        <asp:ListItem Selected="True" Value="">TODOS</asp:ListItem>
                                                        <asp:ListItem Value="P">Pendientes de facturar</asp:ListItem>
                                                        <asp:ListItem Value="A">Con albaranes</asp:ListItem>
                                                    </asp:DropDownList>                        
                                                </div> 
                                                <div class="col-md-3 col-sm-3 col-xs-3 form-group pd-l-5 pd-r-5">
                                                    <label for="txtMatricula"><i class="fa fa-calendar"></i> Hasta Fecha</label>
                                                    <asp:TextBox ID="txtHastaFechaPortes" runat="server" CssClass="form-control date-picker hasDatepicker"></asp:TextBox>
                                                </div>
                                                <div class="col-md-4 col-sm-4 col-xs-4 form-group pd-l-5 pd-r-0">
                                                    <label for="txtMatricula"><i class="fa fa-truck"></i> Matrícula</label>
                                                    <div class="input-group">
                                                        <asp:TextBox class="string form-control" id="txtMatricula" runat="server" maxlength="15" Text=""></asp:TextBox>
                                                        <asp:Label id="Label1" runat="server" class="input-group-addon btn pd-l-5 pd-r-5" onclick="DeleteTransportista();"><span id="ico_delete_matricula" class="fa fa-times"></span></asp:Label>
                                                        <asp:Label id="Label2" runat="server" class="input-group-addon btn btn_ico activo" onclick="OpenBuscadorTransportistas();"><span id="ico_buscador_matricula" class="fa fa-search"></span></asp:Label>
                                                        <asp:HiddenField ID="hndCodTransportista" runat="server" Value="" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-7 col-sm-7 col-xs-7 pd-l-5 pd-r-5">
                                                <div class="col-md-6 col-sm-6 col-xs-6 form-group pd-l-0 pd-r-5">
                                                    <label for="lbl_Conductor"><i class="fa fa-truck"></i> CONDUCTOR</label>                                                                   
                                                    <asp:TextBox class="string form-control" id="txtConductor" runat="server" Text="" ReadOnly="true"></asp:TextBox>
                                                </div>
                                                <div class="col-md-5 col-sm-5 col-xs-5 form-group pd-l-5 pd-r-5">
                                                    <label for="dllAgencias"><i class="fa fa-th-list"></i> Agencia</label>
                                                    <asp:DropDownList runat="server" ID="ddlAgencias" CssClass="form-control selectpicker show-tick" data-width="100%">
                                            
                                                    </asp:DropDownList>  
                                                </div> 
                                                <div class="col-md-1 col-sm-1 col-xs-1 pd-l-0 pd-r-0">
                                                    <asp:LinkButton ID="btnSearchPortes" runat="server" CssClass="form-control btn btn-fol-forms-grey bt-search-fol hvr-grow-shadow" Text="Seleccionar" data-toggle="tooltip" data-placement="bottom" ToolTip="Buscar Portes con los filtros indicados"><span class="fa fa-search"></span></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="margin-top:10px;">
                                            <!-- NO REGISTROS -->
                                            <div id="NoRegs_Datos" runat="server" class="row col-md-12 col-sm-12 pd-t-10 no-results text-center">
                                                <div><i class="fa fa-exclamation-triangle fa-2x"></i></div>
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
                                                Height="400"
				                                PageSize="50" 
				                                AutoGenerateColumns="false" 
                                                CssClass="tab-GridView table-sm pd-l-0 pd-r-0"
				                                AllowSorting="false" 
                                                AllowPaging="false"
                                                Font-Size="Small" 
                                                onrowcommand="grSelPortes_RowCommand">
				                                <AlternatingRowStyle />
				                                <RowStyle />
				                                <HeaderStyle />
                                                <PagerStyle CssClass="GridviewScrollPager" /> 
                                                <PagerSettings  Mode="NumericFirstLast" FirstPageText="|<" PreviousPageText="<" NextPageText=">" LastPageText=">|" />
                                                <PagerStyle HorizontalAlign = "Right" CssClass="pagination-ys" />
				                                <Columns>
                                                    <asp:TemplateField HeaderText="" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="hdnAUTOPORTE" runat="server" Value='<%# Bind("AUTOPORTE")%>' />
                                                            <asp:HiddenField ID="hdnPAGADO" runat="server" Value='<%# Bind("ESTADO")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="PORTE" ItemStyle-Width="3%" HeaderStyle-Width="3%" ItemStyle-HorizontalAlign="LEFT" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" id="lblNumpor" data-toggle="tooltip" data-placement="right" text='<%# Bind("NUMPOR")%>'></asp:Label>
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
                                                                        
                                                    <asp:TemplateField HeaderText="DESTINO" ItemStyle-Width="35%" HeaderStyle-Width="35%" ItemStyle-HorizontalAlign="LEFT" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" id="lblDestino" CssClass="" text='<%# Bind("DESTINO")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="DESIGNACIÓN" ItemStyle-Width="27%" HeaderStyle-Width="27%" ItemStyle-HorizontalAlign="LEFT" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" id="lblDesignacion" CssClass="" text='<%# Bind("DESIGNACION")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="VENTA" ItemStyle-Width="5%" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" id="lblVENTA" CssClass="" text='<%# Bind("VENTA")%>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="" ItemStyle-Width="6%" HeaderStyle-Width="6%" ItemStyle-HorizontalAlign="Center">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnAdd_Porte2" runat="server" data-toggle="tooltip" data-placement="left" CommandName="AddPorte" CommandArgument='<%# Bind("AUTOPORTE")%>'  Text="" ToolTip="Añadir Porte a Factura"><i class="fa fa-plus-square fa-2x" aria-hidden="true"></i></asp:LinkButton>
                                                            <Button ID="btnVerPorte1" class="icono fa fa-search fa-2x" data-toggle="tooltip" data-placement="left" OnClick="javascript: VerPorte(<%# Eval("AUTOPORTE")%>)" title="Ver Porte" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
				                                </Columns>
				                                <EmptyDataRowStyle Width="98%" HorizontalAlign="Center" />    
                                                <FooterStyle Height="38px" />
				                            </asp:GridView>
                                        </div>
                                    </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- PORTES SELECCIONADO -->
                <div class="row col-md-12 col-sm-12 pd-l-0 pd-r-0" style="margin-top:10px !important;">
                    <div id="divPortesFactura" style="position: relative; left: 0px; top: 0px; height: 100%; z-index: 5; right: 0px; margin: 0px auto;">
                        <div class="panel panel-default">
                            <div id="divPortesFacturaH" class="panel-heading" style="background-color: #626060 !important; color: #fff;">
                                <table border="0" class="clickable" style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title"><b><i class="fa fa-truck"></i>  PORTES INCLUIDOS EN LA FACTURA</b></h3>
                                        </td>
                                        <td class="boton_collapse" style="width: 30px; border-left:1px solid #808080;">
                                            <span class="pull-right"><i class="glyphicon glyphicon-chevron-up"></i></span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" style="display: inline-block; width: 100%; min-height:250px;  max-height: 500px; overflow-y: auto; background-color: #fff;">
                                <div class="row mt-10">
                                    <div class="col-md-12 col-sm-12 pd-l-0 pd-r-0">
                                        <asp:UpdatePanel runat="server" ID="UP_Portes_Factura" UpdateMode="Conditional">
                                        <ContentTemplate>                                            
                                            <!-- NO REGISTROS -->
                                            <div id="NoRegs_Datos_Portes" runat="server" class="row col-md-12 col-sm-12 pd-t-10 no-results text-center">
                                                <div><i class="fa fa-exclamation-triangle fa-2x"></i></div>
                                                <div>Ningún Porte en la Factura</div>
                                            </div>
                                            <!-- TOTAL ROWS ============================= -->
                                            <div class="row col-md-12 col-sm-12">
                                                <div id="TotalRows_Datos_Portes" runat="server" class="col-md-4 col-sm-4 pd-l-0">
                                                    <span><asp:Label runat="server" id="lblTotalRows_PortesFactura" text=""></asp:Label></span>
                                                </div>
                                                <div id="TotalPages_Datos_Portes" runat="server" class="col-md-8 col-sm-8 text-right">
                                                    <span><asp:Label runat="server" id="lblTotalVenta_Factura" text=""></asp:Label></span>
                                                </div>
                                            </div>
                                            <div class="col-md-12 col-sm-12 pd-l-0 pd-r-0">
                                                <asp:GridView ID="grPortesFactura" runat="server"
                                                    Width="100%" 
                                                    Height="400"
				                                    PageSize="50" 
				                                    AutoGenerateColumns="false" 
                                                    CssClass="tab-GridView table-sm pd-l0 pd-r-0"
				                                    AllowSorting="false" 
                                                    AllowPaging="false"
                                                    Font-Size="Small" 
                                                    OnRowCommand="grPortesFactura_RowCommand">
				                                    <AlternatingRowStyle />
				                                    <RowStyle />
				                                    <HeaderStyle />
                                                    <PagerStyle CssClass="GridviewScrollPager" /> 
                                                    <PagerSettings  Mode="NumericFirstLast" FirstPageText="|<" PreviousPageText="<" NextPageText=">" LastPageText=">|" />
                                                    <PagerStyle HorizontalAlign = "Right" CssClass="pagination-ys" />
				                                    <Columns>
                                                        <asp:TemplateField HeaderText="" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:HiddenField ID="hdnAUTOPORTE" runat="server" Value='<%# Bind("AUTOPORTE")%>' />
                                                                <asp:HiddenField ID="hdnPAGADO" runat="server" Value='<%# Bind("ESTADO")%>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PORTE" ItemStyle-Width="3%" HeaderStyle-Width="3%" ItemStyle-HorizontalAlign="LEFT" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" id="lblNumpor" data-toggle="tooltip" data-placement="right" text='<%# Bind("NUMPOR")%>'></asp:Label>
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
                                                                        
                                                        <asp:TemplateField HeaderText="DESTINO" ItemStyle-Width="35%" HeaderStyle-Width="35%" ItemStyle-HorizontalAlign="LEFT" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" id="lblDestino" CssClass="" text='<%# Bind("DESTINO")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="DESIGNACIÓN" ItemStyle-Width="27%" HeaderStyle-Width="27%" ItemStyle-HorizontalAlign="LEFT" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" id="lblDesignacion" CssClass="" text='<%# Bind("DESIGNACION")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="VENTA" ItemStyle-Width="5%" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" id="lblVENTA" CssClass="" text='<%# Bind("VENTA")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="" ItemStyle-Width="6%" HeaderStyle-Width="6%" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="btnDelete_Porte" runat="server" data-toggle="tooltip" data-placement="left" CommandName="DeletePorte" CommandArgument='<%# Bind("AUTOPORTE")%>'  Text="" ToolTip="Quitar Porte de la Factura"><i class="fa fa-minus-square fa-2x" aria-hidden="true"></i></asp:LinkButton>
                                                                <Button ID="btnViewPorteFactura" class="fa fa-search fa-2x" data-toggle="tooltip" data-placement="left" OnClick="<%# Eval("AUTOPORTE", "return VerPorte({0});")%>" title="Ver Porte" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
				                                    </Columns>
				                                    <EmptyDataRowStyle Width="98%" HorizontalAlign="Center" />    
                                                    <FooterStyle Height="38px" />
                                                </asp:GridView>
                                            </div>
                                        </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- DATOS ECONOMICOS -->
                <div class="row col-md-12 col-sm-12 pd-l-0 pd-r-0" style="margin-top:10px !important;">
                    <div id="divDatosEconomicos" style="position: relative; left: 0px; top: 0px; height: 100%; z-index: 5; right: 0px; margin: 0px auto;">
                        <div class="panel panel-default">
                            <div id="divDatosEconomicosH" class="panel-heading" style="background-color: #626060 !important; color: #fff;">
                                <table border="0" class="clickable" style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title"><b><i class="fa fa-calculator"></i>  DATOS ECONÓMICOS</b></h3>
                                        </td>
                                        <td class="boton_collapse" style="width: 30px; border-left:1px solid #808080;">
                                            <span class="pull-right"><i class="glyphicon glyphicon-chevron-up"></i></span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" style="display: inline-block; width: 100%; min-height:150px; max-height: 650px; overflow-y: auto; background-color: #fff;">
                                <asp:UpdatePanel runat="server" ID="UP_Datos_Economicos" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <div class="row registro pd-l-0 pd-r-0" style="padding-top: 10px !important;">
                                        <div class="col-md-4 col-sm-4 pd-l-5 pd-r-5 form-group">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon">TOTAL COMPRA</span>
                                                    <input class="string NumericField form-control" id="txtCompra" type="text" runat="server" maxlength="8" readonly="readonly" />
                                                    <span class="input-group-addon"><i class="fa fa-euro-sign"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4 pd-l-5 pd-r-5 form-group">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon">TOTAL VENTA</span>
                                                    <asp:TextBox runat="server" ID="txtVenta" CssClass="string NumericField form-control" MaxLength="10" ReadOnly="true"></asp:TextBox>
                                                    <span class="input-group-addon"><i class="fa fa-euro-sign"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4 pd-l-5 pd-r-5 form-group">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon" style="background-color:#3367D6; color: #fff;">TOTAL FACTURA</span>
                                                    <asp:TextBox runat="server" ID="txtTotalFactura" CssClass="string NumericField form-control text-right" Font-Bold="true" MaxLength="10" ReadOnly="true" Text="0,00"></asp:TextBox>
                                                    <span class="input-group-addon"><i class="fa fa-euro-sign"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row registro pd-l-0 pd-r-0" style="padding-top: 10px !important;">
                                        <div class="col-md-4 col-sm-4 pd-l-5 pd-r-5 form-group">
                                                <div class="col-md-12 col-sm-12 col-xs-12 form-group pd-l-0 pd-r-0">
                                                <Label class="txtCliente">Recargo </Label>&nbsp;&nbsp;&nbsp;
                                                <input type="checkbox" id="chkRecargo" runat="server" style="" />
                                                <div class="pd-l-0 pd-r-0">
                                                    <div class="col-md-3 col-sm-3 col-xs-3 form-group pd-l-0">
                                                        <asp:TextBox class="string form-control" id="txtRecargo" runat="server" maxlength="5" AutoPostBack="false" Text="0,00" Height="100%"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-9 col-sm-9 col-xs-9 form-group pd-l-0 pd-r-0">
                                                        <div class="input-group" style="width:100%;">
                                                            <asp:TextBox class="string NumericField form-control" id="txtImpRecargo" runat="server" maxlength="40" Text="0,00" ReadOnly="true"></asp:TextBox>
                                                            <span class="input-group-addon"><i class="fa fa-euro-sign"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4 pd-l-5 pd-r-5 form-group">
                                            <div class="col-md-12 col-sm-12 col-xs-12 form-group pd-l-0 pd-r-0">
                                                <Label class="txtCliente">Descuento </Label>&nbsp;&nbsp;&nbsp;
                                                <input type="checkbox" id="chkDescuento" runat="server" style="" />
                                                <div class="pd-l-0 pd-r-0">
                                                    <div class="col-md-3 col-sm-3 col-xs-3 form-group pd-l-0">
                                                        <asp:TextBox class="string form-control" id="txtDescuento" runat="server" maxlength="6" AutoPostBack="false" Text="0,00" Height="100%"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-9 col-sm-9 col-xs-9 form-group pd-l-0 pd-r-0">
                                                        <div class="input-group" style="width:100%;">
                                                            <asp:TextBox class="string NumericField form-control" id="txtImpDescuento" runat="server" maxlength="40" Text="0,00" ReadOnly="true"></asp:TextBox>
                                                            <span class="input-group-addon"><i class="fa fa-euro-sign"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-sm-4 pd-l-5 pd-r-5 form-group">
                                            <div class="col-md-12 col-sm-12 col-xs-12 form-group pd-l-0 pd-r-0">
                                                <Label class="txtCliente">I.V.A. </Label>&nbsp;&nbsp;&nbsp;
                                                <input type="checkbox" id="chkIVA" runat="server" style="" checked="checked" />
                                                <div class="pd-l-0 pd-r-0">
                                                    <div class="col-md-4 col-sm-4 col-xs-4 form-group pd-l-0">
                                                        <asp:TextBox class="string form-control" id="txtIVA" runat="server" maxlength="6" Text="21,00" Height="100%" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-8 col-sm-8 col-xs-8 form-group pd-l-0 pd-r-0">
                                                        <div class="input-group" style="width:100%;">
                                                            <asp:TextBox class="string NumericField form-control" id="txtImpIVA" runat="server" maxlength="40" Text="" ReadOnly="true"></asp:TextBox>
                                                            <span class="input-group-addon"><i class="fa fa-euro-sign"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row registro pd-l-15" style="padding-top: 10px !important;">
                                        <div class="col-md-8 col-sm-8 pd-l-10 pd-r-10" >
                                            
                                        </div>
                                        <div class="col-md-4 col-sm-4 pd-l-10 pd-r-10 text-right">
                                            <button type="button" id="btnRecalcularFactura" runat="server" class="btn btn-fol btn-fol-forms-grey hvr-grow-shadow" ><span class="fa fa-calculator"></span>&nbsp;&nbsp;Recalcular</button>
                                        </div>
                                    </div>
                                </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row col-md-12 col-sm-12 pd-l-0 pd-r-0" style="margin-top:10px !important;">
                    <div id="divCobrosFactura" style="position: relative; left: 0px; top: 0px; height: 100%; z-index: 5; right: 0px; margin: 0px auto;">
                        <div class="panel panel-default">
                            <div id="divCobrosFacturaH" class="panel-heading" style="background-color: #626060 !important; color: #fff;">
                                <table border="0" class="clickable" style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title"><b><i class="fa fa-university"></i>  COBROS FACTURA</b></h3>
                                        </td>
                                        <td class="boton_collapse" style="width: 30px; border-left:1px solid #808080;">
                                            <span class="pull-right"><i class="glyphicon glyphicon-chevron-up"></i></span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-body" style="display: inline-block; width: 100%; min-height:220px; max-height:320px; overflow-y:hidden; overflow-y: hidden; background-color: #fff;">
                                <div class="row pd-l-0 pd-r-0" style="margin-top: 10px; background-color: #ffffff !important;">
                                    <asp:UpdatePanel runat="server" ID="UPCobrosFactura" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <div id="tbl_CobrosFactura" runat="server" class="row" style="margin-top:10px !important; border-bottom:1px solid #c7c7c7;">
                                            <div class="col-md-4 col-sm-4 col-xs-4 pd-l-10 pd-r-10" style="padding-bottom: 10px !important;">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">IMPORTE COBRO</span>
                                                        <asp:TextBox ID="txtImporteCobro" runat="server" CssClass="string NumericField form-control" MaxLength="10"></asp:TextBox>
                                                        <span class="input-group-addon"><i class="fa fa-euro-sign"></i></span>                                                       
                                                        <asp:HiddenField runat="server" ID="hdnAUTOCOBRO" Value="" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 col-sm-4 col-xs-4 pd-l-10 pd-r-10" style="padding-bottom: 10px !important;">
                                                <div class="form-group">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">FECHA COBRO</span>
                                                        <asp:TextBox ID="txtFechaCobro" runat="server" CssClass="form-control date-picker hasDatepicker"></asp:TextBox>
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>                                                       
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 col-sm-4 col-xs-4 pd-l-10 pd-r-10" style="padding-bottom: 10px !important;">
                                                <div class="col-md-6 col-sm-6 col-xs-6 pd-l-10 pd-r-5">
                                                    <asp:LinkButton ID="btnAddCobro" runat="server" CssClass="form-control btn btn-fol-forms-grey bt-search-fol hvr-grow-shadow" Text="" data-toggle="tooltip" data-placement="bottom" ToolTip="Nuevo Cobro de Factura" OnClick="btnAddCobro_Click"><span class="fas fa-plus"></span>&nbsp;&nbsp;Nuevo Cobro</asp:LinkButton>
                                                    <asp:LinkButton ID="btnCancelarCobro" runat="server" CssClass="form-control btn btn-fol-forms-grey bt-search-fol hvr-grow-shadow" Text="" data-toggle="tooltip" data-placement="bottom" ToolTip="Cancelar operación Cobro" OnClick="btnCancelarCobro_Click" Visible="false"><span class="fa fa-undo"></span>&nbsp;&nbsp;Cancelar</asp:LinkButton>
                                                </div>
                                                <div class="col-md-6 col-sm-6 col-xs-6 pd-l-5 pd-r-10">
                                                    <asp:LinkButton ID="btnGuardarCobro" runat="server" CssClass="form-control btn btn-fol-forms-grey bt-search-fol hvr-grow-shadow" Text="Guardar" data-toggle="tooltip" data-placement="bottom" ToolTip="Guardar Cobro de Factura" OnClick="btnGuardarCobro_Click" Visible="false"><span class="far fa-save"></span>&nbsp;&nbsp;Guardar Cobro</asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row mt-10" style="margin-top:10px !important;">
                                            <div class="col-md-12 col-sm-12 pd-l-0 pd-r-0">
                                                <!-- TOTAL ROWS ============================= -->
                                                <div class="row col-md-12 col-sm-12" style="margin-bottom: 10px;">
                                                    <div class="col-md-4 col-sm-4 pd-l-10">
                                                        <div class="form-group">
                                                            <div class="input-group"> 
                                                                <span class="input-group-addon">IMPORTE COBRADO</span>
                                                                <asp:TextBox runat="server" ID="txtTotalCobrado" CssClass="string NumericField form-control text-right" Font-Bold="true" MaxLength="10" ReadOnly="true"></asp:TextBox>
                                                                <span class="input-group-addon"><i class="fa fa-euro-sign"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 col-sm-4 pd-l-10">
                                                    </div>
                                                    <div class="col-md-4 col-sm-4 pd-l-10 text-right">
                                                        <div class="form-group">
                                                            <div class="input-group">
                                                                <span class="input-group-addon">IMPORTE PENDIENTE</span>
                                                                <asp:TextBox runat="server" ID="txtTotalPendiente" CssClass="string NumericField form-control text-right" Font-Bold="true" MaxLength="10" ReadOnly="true"></asp:TextBox>
                                                                <span class="input-group-addon"><i class="fa fa-euro-sign"></i></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- NO REGISTROS -->
                                                <div id="NoRegs_Cobros_Factura" runat="server" class="row col-md-12 col-sm-12 pd-t-10 no-results text-center">
                                                    <div><i class="fa fa-exclamation-triangle fa-2x"></i></div>
                                                    <div>Ningún cobro de la Factura</div>
                                                </div>
                                                <div class="col-md-12 col-sm-12 pd-l-0 pd-r-0">
                                                    <asp:GridView ID="grCobrosFactura" runat="server" 
				                                        Width="100%" 
                                                        Height="150" 
				                                        AutoGenerateColumns="false" 
                                                        CssClass="tab-GridView table-sm pd-l-0 pd-r-0"
				                                        AllowSorting="false" 
                                                        AllowPaging="false"
                                                        Font-Size="Small" 
                                                        onrowcommand="grCobrosFactura_RowCommand">
				                                        <AlternatingRowStyle />
				                                        <RowStyle />
				                                        <HeaderStyle />
				                                        <Columns>
                                                            <asp:TemplateField HeaderText="" Visible="false">
                                                                <ItemTemplate>
                                                                    <asp:HiddenField ID="hdnAUTOCOBRO" runat="server" Value='<%# Bind("AUTOCOBRO")%>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="IMPORTE" ItemStyle-Width="40%" HeaderStyle-Width="40%" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" id="lblCOBRO" CssClass="" text='<%# Bind("IMPORTE_COBRO")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="FECHA" ItemStyle-Width="40%" HeaderStyle-Width="40%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" id="lblFechaPorte" CssClass="" text='<%# Eval("FECHA_COBRO", "{0:dd/MM/yyyy}")%>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="" ItemStyle-Width="20%" HeaderStyle-Width="20%" ItemStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="btnModCobroFactura" runat="server" data-toggle="tooltip" data-placement="left" CommandName="ModCobroFactura" CommandArgument='<%# Bind("AUTOCOBRO")%>'  Text="" ToolTip="Modificar Cobro de Factura"><i class="fas fa-edit fa-2x" aria-hidden="true"></i></asp:LinkButton>
                                                                    &nbsp;&nbsp;&nbsp;
                                                                    <asp:LinkButton ID="btnDeleteCobroFactura" runat="server" data-toggle="tooltip" data-placement="left" CommandName="DeleteCobroFactura" CommandArgument='<%# Bind("AUTOCOBRO")%>'  Text="" ToolTip="Eliminar Cobro de Factura"><i class="fas fa-trash-alt fa-2x" aria-hidden="true"></i></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
				                                        </Columns>
				                                        <EmptyDataRowStyle Width="98%" HorizontalAlign="Center" />    
				                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- OTROS DATOS -->
                <div class="row col-md-12 col-sm-12 pd-l-0 pd-r-0" style="margin-top:10px !important;">
                    <div id="divOtrosDatos" style="position: relative; left: 0px; top: 0px; height: 100%; z-index: 5; right: 0px; margin: 0px auto;">
                        <div class="panel panel-default" style="width: 100%">
                        <div id="divOtrosDatosH" class="panel-heading" style="background-color:#626060 !important; color:#fff;">
                            <table border="0" class="clickable" style="width: 100%;">
                                <tr>
                                    <td>
                                        <h3 class="panel-title"><b><i class="fa fa-info-circle"></i>  OTROS DATOS</b></h3>
                                    </td>
                                    <td class="boton_collapse" style="width: 30px; border-left:1px solid #808080;">
                                        <span class="pull-right"><i class="glyphicon glyphicon-chevron-up"></i></span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="panel-body" style="display: inline-block; width: 100%; background-color: #fff;">                                           
                            <div class="row registro pd-l-0 pd-r-0" style="padding-top: 10px !important;">
                                <div class="col-md-6 col-sm-6 form-group">
                                    <span><i class="far fa-credit-card"></i> FORMA DE PAGO</span>
                                    <asp:TextBox ID="txtFormaPago" class="form-control" style="min-width: 100%" runat="server" TextMode="MultiLine" Wrap="true" Rows="6" placeholder="Indique la Forma de pago ..." maxlength="1500"></asp:TextBox>
                                    <span><label id="formapago_numcars"></label></span>
                                </div>
                                <div class="col-md-6 col-sm-6 form-group">
                                    <span><i class="fa fa-comment"></i> OBSERVACIONES</span>
                                    <asp:TextBox ID="txtObservaciones" class="form-control" style="min-width: 100%" runat="server" TextMode="MultiLine" Wrap="true" Rows="6" placeholder="Indique las Observaciones ..." maxlength="1500"></asp:TextBox>
                                    <span><label id="observaciones_numcars"></label></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    </div>
                </div>
                <!-- ENVIOS EMAILS FACTURA -->
                <div class="row col-md-12 col-sm-12 pd-l-0 pd-r-0" style="margin-top:10px !important;">
                    <div id="divEnviosEmailFacturas" style="position: relative; left: 0px; top: 0px; height: 100%; z-index: 5; right: 0px; margin: 0px auto;">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="background-color: #626060 !important; color: #fff;">
                                <table border="0" class="clickable" style="width: 100%;">
                                    <tr>
                                        <td>
                                            <h3 class="panel-title"><b><i class="fa fa-envelope"></i>  ENVIOS FACTURA POR EMAIL</b></h3>
                                        </td>
                                        <td class="boton_collapse" style="width: 30px; border-left:1px solid #808080;">
                                            <span class="pull-right"><i class="glyphicon glyphicon-chevron-up"></i></span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                             <div class="panel-body" style="display: inline-block; width: 100%; min-height:150px; max-height:150px; overflow-y:hidden; overflow-y: hidden; background-color: #fff;">
                                <div class="row pd-l-0 pd-r-0" style="margin-top: 10px; background-color: #ffffff !important;">
                                    <asp:UpdatePanel runat="server" ID="UP_Factura_Emails" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <!-- NO REGISTROS -->
                                        <div id="NoRegs_FacturaEmails" runat="server" class="row col-md-12 col-sm-12 pd-t-10 no-results text-center">
                                            <div><i class="fa fa-exclamation-triangle fa-2x"></i></div>
                                            <div>Ningún envío por email de la Factura</div>
                                        </div>
                                        <div class="col-md-12 col-sm-12 pd-l-0 pd-r-0" style="height:100px;">
                                            <asp:GridView ID="grFacturaEmails" runat="server" 
				                            Width="100%" 
                                            Height="100" 
				                            AutoGenerateColumns="false" 
                                            CssClass="tab-GridView table-sm pd-l-0 pd-r-0"
				                            AllowSorting="false" 
                                            AllowPaging="false"
                                            Font-Size="Small" 
                                            onrowcommand="grFacturaEmails_RowCommand">
				                            <AlternatingRowStyle />
				                            <RowStyle />
				                            <HeaderStyle />
				                            <Columns>
                                                <asp:TemplateField HeaderText="" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hdnEmailAUTOPORTE" runat="server" Value='<%# Bind("ID")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="EMAIL DESTINATARIO" ItemStyle-Width="40%" HeaderStyle-Width="40%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" id="lblEMAIL" CssClass="" text='<%# Bind("EMAIL_DESTINO")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FECHA ENVÍO" ItemStyle-Width="40%" HeaderStyle-Width="40%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" id="lblFechaPorte" CssClass="" text='<%# Eval("FECHA_ENIVO", "{0:dd/MM/yyyy}")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="" ItemStyle-Width="20%" HeaderStyle-Width="20%" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnDelete_FacturaEmail" runat="server" data-toggle="tooltip" data-placement="left" CommandName="DeleteFacturaEmail" CommandArgument='<%# Bind("ID")%>'  Text="" ToolTip="Eliminar envío Factura por Email"><i class="fas fa-trash-alt fa-2x" aria-hidden="true"></i></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
				                            </Columns>
				                            <EmptyDataRowStyle Width="98%" HorizontalAlign="Center" />    
				                        </asp:GridView>
                                        </div>
                                    </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
   
    <div id="CapaEnvioEmail" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Envío por email de la factura</h4>
                </div>
                <div class="modal-body" style="display:;width:100%; max-height:600px; overflow-y : auto;">
                    <table border="0" style="width:100%;">
                        <tr>
                            <td><label>Email del Cliente donde enviar la factura:</label></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox class="string form-control" id="txtEmailCliente" runat="server" maxlength="120" placeholder="Indique email destino ..." AutoPostBack="false" Text="" Height="100%"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn" data-dismiss="modal"  id="btnCapaMensajesCancelar">Cancelar</button>
                    <asp:Button runat="server" class="btn btn-default" data-dismiss="modal" id="btnCapaEnvioEmailAceptar" Text="Enviar" OnClick="btnCapaEnvioEmailAceptar_Click" UseSubmitBehavior="false" />
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
            $("#ctl00_MainContent_hdnRedirect").val('');
            $("#ctl00_MainContent_hdnReload").val('');
            $('#ctl00_MainContent_hdnControlJS').val('');

            if (prm.get_isInAsyncPostBack()) {
                args.set_cancel(true);
            }
            postBackElement = args.get_postBackElement();
            $("#ctl00_UpdateProgress1").css("display", "block");
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

            $('.panel-heading table.clickable').on("click", function (e) {
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

            //** icono borrar contenido campo **//
            $('.has-clear input[type="text"]').on('focus input propertychange', function () {
                var $this = $(this);
                var visible = Boolean($this.val());
                $this.siblings('.form-control-clear').toggleClass('hidden', !visible);
            }).on('blur', function () {
                $(this).siblings('.form-control-clear').addClass('hidden');
            }).trigger('propertychange');

            $('.form-control-clear').on('mousedown', function () {
                return false;
            }).click(function () {
                $(this).siblings('input[type="text"]').val('')
                  .trigger('propertychange').focus();
            });
            //** fin icono borrar contenido campo **//

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
            
            var numfac = $("#ctl00_MainContent_hndAlta").val();
            if (numfac == "1") {
                $("#<%=txtCodCli.ClientId%>").focus();
            } else {
                $("#<%=txtFecFactura.ClientId%>").focus();
            } 
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

            $('#lblMsgConfirm').html('<b>¿ Seguro que desea dar de Baja esta Factura ?</b> <br/>');
            var modal = $('#CapaConfirm');
            modal.find('.modal-title').text('Confirmar Baja de Factura');
            modal.find('.modal-header').css({
                "background-color": "#D9534F",
                "color": "#fff"
            });
            $("#ctl00_MainContent_btnConfirmCancel").focus();
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
        $('#CapaEnvioEmail').on('show.bs.modal', function (event) {
            var modal = $('#CapaEnvioEmail');
            modal.find('.modal-header').css({
                "background-color": "#3367D6",
                "color": "#fff"
            });

            $('#ctl00_MainContent_txtEmailCliente').focus();
        });

        function Salir() {
            document.location.href = 'facturas_listado.aspx';
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
                    setTimeout(function () { $('#ctl00_MainContent_btn_Mensajes_Aceptar').focus(); }, 1000);
                }
            }
        }
        function pageLoad() {
            ReloadDatepickers();

            recarga_eventos_jquery();
        }
        
        function recarga_eventos_jquery() {
            $('[data-toggle="tooltip"]').tooltip();

            $("#ctl00_MainContent_chkRecargo").change(function () {
                Recalcular_Factura();
            });
            $("#ctl00_MainContent_txtRecargo").change(function () {
                Recalcular_Factura();
            });
            $("#ctl00_MainContent_chkDescuento").change(function () {
                Recalcular_Factura();
            });
            $("#ctl00_MainContent_txtDescuento").change(function () {
                Recalcular_Factura();
            });
            $("#ctl00_MainContent_chkIVA").change(function () {
                Recalcular_Factura();
            });

            var tGrid = '';
            $objGrid = $("#<%=grSelPortes.ClientID%>");
		    //debugger;
		    if ($objGrid) {
		        var gridWidth = $("#divAddPortes").width();// $(window).width();
		        gridWidth -= 4;
		        var gridHeight = $(window).height() - 124;
		        $objGrid.gridviewScroll({
		            width: gridWidth,
		            height: 400,
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
		    }

            $objGridF = $("#<%=grPortesFactura.ClientID%>");
		    //debugger;
            if ($objGridF) {
		        var gridWidth = $("#divAddPortes").width();// $(window).width();
		        gridWidth -= 4;
		        var gridHeight = $(window).height() - 124;
		        $objGridF.gridviewScroll({
		            width: gridWidth,
		            height: 400,
		            arrowsize: 30,
		            varrowtopimg: "images/arrowvt.png",
		            varrowbottomimg: "images/arrowvb.png",
		            harrowleftimg: "images/arrowhl.png",
		            harrowrightimg: "images/arrowhr.png",
		            wheelstep: 50,
		            startVertical: $objGridF.val(),
		            startHorizontal: $objGridF.val(),
                    onScrollVertical: function (delta) { 
                        $objGridF.val(delta);
                    }, 
                    onScrollHorizontal: function (delta) { 
                        $objGridF.val(delta);
                    }
		        });
            }

            $objGridC = $("#<%=grCobrosFactura.ClientID%>");
		    //debugger;
            if ($objGridC) {
                var gridWidth = $("#divCobrosFactura").width();// $(window).width();
		        gridWidth -= 5;
		        var gridHeight = $(window).height() - 124;
		        $objGridC.gridviewScroll({
		            width: gridWidth,
		            height: 160,
		            arrowsize: 30,
		            varrowtopimg: "images/arrowvt.png",
		            varrowbottomimg: "images/arrowvb.png",
		            harrowleftimg: "images/arrowhl.png",
		            harrowrightimg: "images/arrowhr.png",
		            wheelstep: 50,	            
		            horizontalbar: "hidden",
		            startVertical: $objGridC.val(),
		            startHorizontal: $objGridC.val(),
                    onScrollVertical: function (delta) { 
                        $objGridC.val(delta);
                    }, 
                    onScrollHorizontal: function (delta) { 
                        $objGridC.val(delta);
                    }
		        });
            }

            $objGridE = $("#<%=grFacturaEmails.ClientID%>");
		    //debugger;
            if ($objGridE) {
                var gridWidth = $("#divEnviosEmailFacturas").width();// $(window).width();
		        gridWidth -= 5;
		        var gridHeight = $(window).height() - 124;
		        $objGridE.gridviewScroll({
		            width: gridWidth,
		            height: 100,
		            arrowsize: 30,
		            varrowtopimg: "images/arrowvt.png",
		            varrowbottomimg: "images/arrowvb.png",
		            harrowleftimg: "images/arrowhl.png",
		            harrowrightimg: "images/arrowhr.png",
		            wheelstep: 50,
		            horizontalbar: "hidden",
		            startVertical: $objGridE.val(),
		            startHorizontal: $objGridE.val(),
		            onScrollVertical: function (delta) {
		                $objGridE.val(delta);
		            },
		            onScrollHorizontal: function (delta) {
		                $objGridE.val(delta);
		            }
		        });
            }

            // SOLO NUMEROS sin puntos con coma
            $("#ctl00_MainContent_txtRecargo, #ctl00_MainContent_txtDescuento, #ctl00_MainContent_txtImporteCobro").keydown(function (event) {
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
            // Formatear los importes
            $("#ctl00_MainContent_txtImporteCobro").focusout(function (event) {
                var valor = $(this).val();
                if (valor != "") {
                    valor = valor.replace(".", "");
                    valor = valor.replace(",", ".");
                    if (!isNaN(valor) == true) {
                        $(this).val(humanizeNumber(valor, 2));
                    }
                }
            });
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
            $("#ctl00_MainContent_ddlTipoPorte").selectpicker('refresh');
            $("#ctl00_MainContent_ddlTipoPorte").selectpicker('render');

            $("#ctl00_MainContent_ddlAgencias").selectpicker('refresh');
            $("#ctl00_MainContent_ddlAgencias").selectpicker('render');

            /* CALENDARIOS ============================================== */
            $('#ctl00_MainContent_txtFecFactura').daterangepicker({
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
                "cancelClass": "btn-cleantxtFecFactura"
            }, function (start, end, label) {
                $('#ctl00_MainContent_txtFecFactura').val(start.format('DD/MM/YYYY'));
            });
            /* Acciones de calendarios para reiniciar los input */
            $('.btn-cleantxtFecFactura').on('click', function () {
                $("#ctl00_MainContent_txtFecFactura").val('');
            });

            $('#ctl00_MainContent_txtFecVencimiento').daterangepicker({
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
                "cancelClass": "btn-cleantxtFecVencimiento"
            }, function (start, end, label) {
                $('#ctl00_MainContent_txtFecVencimiento').val(start.format('DD/MM/YYYY'));
            });
            /* Acciones de calendarios para reiniciar los input */
            $('.btn-cleantxtFecVencimiento').on('click', function () {
                $("#ctl00_MainContent_txtFecVencimiento").val('');
            });

            $('#ctl00_MainContent_txtFecCobro').daterangepicker({
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
                "cancelClass": "btn-cleantxtFecCobro"
            }, function (start, end, label) {
                $('#ctl00_MainContent_txtFecCobro').val(start.format('DD/MM/YYYY'));
            });
            /* Acciones de calendarios para reiniciar los input */
            $('.btn-cleantxtFecCobro').on('click', function () {
                $("#ctl00_MainContent_txtFecCobro").val('');
            });

            $('#ctl00_MainContent_txtHastaFechaPortes').daterangepicker({
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
                "cancelClass": "btn-cleantxtHastaFechaPortes"
            }, function (start, end, label) {
                $('#ctl00_MainContent_txtHastaFechaPortes').val(start.format('DD/MM/YYYY'));
            });
            /* Acciones de calendarios para reiniciar los input */
            $('.btn-cleantxtHastaFechaPortes').on('click', function () {
                $("#ctl00_MainContent_txtHastaFechaPortes").val('');
            });

            $('#ctl00_MainContent_txtFechaCobro').daterangepicker({
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
                "cancelClass": "btn-cleantxtFechaCobro"
            }, function (start, end, label) {
                $('#ctl00_MainContent_txtFechaCobro').val(start.format('DD/MM/YYYY'));
            });
            /* Acciones de calendarios para reiniciar los input */
            $('.btn-cleantxtFechaCobro').on('click', function () {
                $("#ctl00_MainContent_txtFechaCobro").val('');
            });
        };
        
        // SOLO NUMEROS sin puntos sin coma
        $("#ctl00_MainContent_txtCliente").keydown(function (event) {
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
            $("#<%=txtConductor.ClientId%>").val(conductor);
            $('#BuscadorTransportistas').modal('toggle');
        }
        function DeleteTransportista() {
            $("#<%=txtMatricula.ClientId%>").val("");
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
        $('#ctl00_MainContent_txtObservaciones').keyup(function () {
            var obj = $('#ctl00_MainContent_txtObservaciones');
            Calcula_NumCars(obj, 'observaciones_numcars', 1500)
        });
        $('#ctl00_MainContent_txtFormaPago').keyup(function () {
            var obj = $('#ctl00_MainContent_txtFormaPago');
            Calcula_NumCars(obj, 'formapago_numcars', 1500)
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
        //debugger;
        function VerPorte(autoporte) {
            window.open("Porte.aspx?id=" + autoporte + "&N=N&B=N", "VerPorte");
        }
        function Recalcular_Factura() {
            $("#<%=btnRecalcularFactura.ClientID%>")[0].click();
        }
        function Imprimir() {
            var autofac = $("#ctl00_MainContent_hdnFacturaId").val();
            if (autofac == "") {
                MuestraError("No hay una factura activa para imprimir.", "ERROR", "IMPRESIÓN FACTURA")
            } else {
                window.open("VisorPDF.aspx?tipo=fac&id=" + autofac,"VisorPDF");
            }
        }
        function OpenFactura() {
            var carpetaraiz = '<%=Session("UrlRaizAplicacion")%>';
            var fileFactura = $("#ctl00_MainContent_hdnFilePDF").val();
            var filepdf = carpetaraiz + fileFactura;
            window.open(filepdf, "VerDocumento");
        }
        function EnviarEmail() {
            $('#CapaEnvioEmail').modal('show');
        }
        function AddCobro() {
            $("#ctl00_MainContent_txtImporteCobro").val('');
            $("#ctl00_MainContent_txtFechaCobro").val('');
            $("#ctl00_MainContent_btnAddCobro").hide();
            $("#ctl00_MainContent_btnCancelarCobro").show();
            $("#ctl00_MainContent_btnGuardarCobro").show();
            $("#ctl00_MainContent_txtImporteCobro").focus();
        }
        function CancelarCobro() {
            $("#ctl00_MainContent_txtImporteCobro").val('');
            $("#ctl00_MainContent_txtFechaCobro").val('');
            $("#ctl00_MainContent_btnCancelarCobro").hide();
            $("#ctl00_MainContent_btnGuardarCobro").hide();
            $("#ctl00_MainContent_btnAddCobro").show();
        }
        debugger;
    </script>
</asp:Content>
