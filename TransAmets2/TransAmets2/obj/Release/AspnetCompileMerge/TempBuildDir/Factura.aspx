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
    <script type="text/javascript" src="Scripts/gridviewScroll.min.js"></script>
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
        .tab-GridView{padding-top:0px !important; padding-left:0px !important;padding-right:0px !important}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Always">
        <ContentTemplate>
            <asp:HiddenField ID="hdnFacturaId" runat="server" />
            <asp:HiddenField ID="hdnClienteId" runat="server" />
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
        
        <div class="row container_summary resultados" style="margin-top:0px;">
            <div class="pestanas col-md-12 col-sm-12 pd-l-0 pd-r-0">
                <div id="cajabotones" style="float: right; position: absolute; top: 0; z-index: 1; right: 0;">
                    <asp:UpdatePanel runat="server" ID="UP_Botones" UpdateMode="Conditional">
                        <ContentTemplate>
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
                                    <div class="col-md-3 col-sm-3 col-xs-3 pd-l-0 pd-r-5">
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
                                
                                <!-- SELECCIÓN DE PORTES -->
                                <div class="row col-md-12 col-sm-12 pd-l-0 pd-r-0" style="margin-top:10px !important;">
                                    <div id="divAddPortes" style="position: relative; left: 0px; top: 0px; height: 100%; z-index: 5; right: 0px; margin: 0px auto;">
                                        <div class="panel panel-default">
                                            <div class="panel-heading" style="background-color: #626060 !important; color: #fff;">
                                                <table border="0" class="clickable" style="width: 100%;">
                                                    <tr>
                                                        <td>
                                                            <h3 class="panel-title"><b>SELECCIÓN DE PORTES A INCLUIR EN LA FACTURA</b></h3>
                                                        </td>
                                                        <td class="boton_collapse" style="width: 30px; border-left:1px solid #808080;">
                                                            <span class="pull-right"><i class="glyphicon glyphicon-chevron-up"></i></span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="panel-body" style="display: inline-block; width: 100%; min-height:350px;  max-height: 500px; overflow-y: auto; background-color: #fff;">
                                                <div class="row pd-l-0 pd-r-0" style="margin-top: 10px; background-color: #e5e5e5 !important;">
                                                    <asp:UpdatePanel runat="server" ID="UP_Filtros_Portes" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <div id="tbl_filterPortes" class="row" style="border-bottom:1px solid #c7c7c7;">
                                                            <div class="col-md-4 col-sm-4 col-xs-4 pd-l-0 pd-r-10">
                                                                <div class="col-md-7 col-sm-7 col-xs-7 form-group pd-l-0 pd-r-5">
                                                                    <label for="ddlTipoPorte"><i class="fa fa-th-list"></i> TIPO DE PORTES</label>
                                                                    <asp:DropDownList runat="server" ID="ddlTipoPorte" CssClass="form-control selectpicker show-tick" data-width="100%">
                                                                        <asp:ListItem Selected="True" Value="">TODOS</asp:ListItem>
                                                                        <asp:ListItem Value="P">Pendientes de facturar</asp:ListItem>
                                                                        <asp:ListItem Value="A">Con albaranes</asp:ListItem>
                                                                    </asp:DropDownList>                        
                                                                </div> 
                                                                <div class="col-md-5 col-sm-5 col-xs-5 form-group pd-l-5 pd-r-0">
                                                                    <label for="txtMatricula"><i class="fa fa-calendar"></i> Hasta Fecha Portes</label>
                                                                    <asp:TextBox ID="txtHastaFechaPortes" runat="server" CssClass="form-control date-picker hasDatepicker"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-7 col-sm-7 col-xs-7 pd-l-5 pd-r-5">
                                                                <div class="col-md-3 col-sm-3 col-xs-3 form-group pd-l-0 pd-r-5">
                                                                    <label for="txtMatricula"><i class="fa fa-truck"></i> Matrícula</label>
                                                                    <div class="input-group">
                                                                        <asp:TextBox class="string form-control" id="txtMatricula" runat="server" maxlength="15" Text=""></asp:TextBox>
                                                                        <asp:Label id="Label1" runat="server" class="input-group-addon btn pd-l-5 pd-r-5" onclick="DeleteTransportista();"><span id="ico_delete_matricula" class="fa fa-times"></span></asp:Label>
                                                                        <asp:Label id="Label2" runat="server" class="input-group-addon btn btn_ico activo" onclick="OpenBuscadorTransportistas();"><span id="ico_buscador_matricula" class="fa fa-search"></span></asp:Label>
                                                                        <asp:HiddenField ID="hndCodTransportista" runat="server" Value="" />
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-5 col-sm-5 col-xs-5 form-group pd-l-5 pd-r-5">
                                                                    <label for="lbl_Conductor"><i class="fa fa-truck"></i> CONDUCTOR</label>                                                                   
                                                                    <asp:TextBox class="string form-control" id="txtConductor" runat="server" Text="" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-4 col-sm-4 col-xs-4 form-group pd-l-5 pd-r-0">
                                                                    <label for="dllAgencias"><i class="fa fa-th-list"></i> Agencia</label>
                                                                    <asp:DropDownList runat="server" ID="ddlAgencias" CssClass="form-control selectpicker show-tick" data-width="100%">
                                            
                                                                    </asp:DropDownList>  
                                                                </div> 
                                                            </div>
                                                            <div class="col-md-1 col-sm-1 col-xs-1 pd-l-0 pd-r-10">
                                                                <asp:LinkButton ID="btnSearchPortes" runat="server" CssClass="form-control btn btn-fol-forms-grey bt-search-fol hvr-grow-shadow" Text="Seleccionar" data-toggle="tooltip" data-placement="bottom" ToolTip="Buscar Portes con los filtros indicados"><span class="fa fa-search"></span></asp:LinkButton>
                                                            </div>
                                                        </div>
                                                  
                                                        <div class="row" style="margin-top:10px;">
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
                                                            <div id="CajaGridSelPortes" class="col-md-12 col-sm-12 pd-l-0 pd-r-0">
                                                                <asp:GridView ID="grSelPortes" runat="server" 
				                                                    Width="100%" 
				                                                    PageSize="150" 
				                                                    AutoGenerateColumns="false" 
				                                                    AllowSorting="false" 
				                                                    CssClass="tab-GridView table-sm"
                                                                    AllowPaging="false"
                                                                    Font-Size="Small">
				                                                    <AlternatingRowStyle />
				                                                    <RowStyle />
				                                                    <HeaderStyle BackColor="#EDEDED" />
                                                                    <PagerSettings  Mode="NumericFirstLast" FirstPageText="|<" PreviousPageText="<" NextPageText=">" LastPageText=">|" />
                                                                    <PagerStyle HorizontalAlign = "Right" CssClass="pagination-ys" />
				                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="PORTE" ItemStyle-Width="5%" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="LEFT">
                                                                            <ItemTemplate>
                                                                                <asp:HiddenField ID="hdnAUTOPORTE" runat="server" Value='<%# Bind("AUTOPORTE")%>' />
                                                                                <asp:Label runat="server" id="lblNumpor" CssClass="" text='<%# Bind("NUMPOR")%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField HeaderText="FECHA" ItemStyle-Width="6%" HeaderStyle-Width="6%" ItemStyle-HorizontalAlign="LEFT">
                                                                            <ItemTemplate>
                                                                                <asp:Label runat="server" id="lblFechaPorte" CssClass="" text='<%# Eval("FECHA", "{0:dd/MM/yyyy}")%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField HeaderText="MATRICULA" ItemStyle-Width="8%" HeaderStyle-Width="8%" ItemStyle-HorizontalAlign="LEFT">
                                                                            <ItemTemplate>
                                                                                <asp:Label runat="server" id="lblMatricula" CssClass="" text='<%# Bind("MATRICULA")%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        
                                                                        <asp:TemplateField HeaderText="DESTINO" ItemStyle-Width="43%" HeaderStyle-Width="43%" ItemStyle-HorizontalAlign="LEFT">
                                                                            <ItemTemplate>
                                                                                <asp:Label runat="server" id="lblDestino" CssClass="" text='<%# Bind("DESTINO")%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="DESIGNACIÓN" ItemStyle-Width="25%" HeaderStyle-Width="25%" ItemStyle-HorizontalAlign="LEFT">
                                                                            <ItemTemplate>
                                                                                <asp:Label runat="server" id="lblDesignacion" CssClass="" text='<%# Bind("DESIGNACION")%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField HeaderText="PAGADO" ItemStyle-Width="8%" HeaderStyle-Width="8%" ItemStyle-HorizontalAlign="Center">
                                                                            <ItemTemplate>
                                                                                <asp:Label runat="server" id="lblEstadoPorte" CssClass="" text='<%# Bind("ESTADO")%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField HeaderText="" ItemStyle-Width="5%" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Center">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="btnAdd_Porte" runat="server" CssClass="btn btn-fol btn-fol-forms-grey bt-search-registro hvr-grow-shadow btn-open-delete" data-toggle="tooltip" data-placement="bottom" Text="" ToolTip="Añadir Porte a Factura"><span class="far fa-plus-square" style="margin-top: 13px;"></span></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
				                                                    </Columns>
				                                                    <EmptyDataRowStyle Width="90%" HorizontalAlign="Center" />    
                                                                    <FooterStyle Height="38px" />
				                                                </asp:GridView>
                                                            </div> 
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row col-md-12 col-sm-12 pd-l-0 pd-r-0" style="margin-top:10px !important;">
                                    <div id="divPortesFactura" style="position: relative; left: 0px; top: 0px; height: 100%; z-index: 5; right: 0px; margin: 0px auto;">
                                        <div class="panel panel-default">
                                            <div class="panel-heading" style="background-color: #626060 !important; color: #fff;">
                                                <table border="0" class="clickable" style="width: 100%;">
                                                    <tr>
                                                        <td>
                                                            <h3 class="panel-title"><b>PORTES INCLUIDOS EN LA FACTURA</b></h3>
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
                                                            <div class="row">
                                                            <!-- NO REGISTROS -->
                                                            <div id="NoRegs_Datos_Portes" runat="server" class="row col-md-12 col-sm-12 no-results text-center">
                                                                <div><i class="fa fa-exclamation-triangle"></i></div>
                                                                <div>Ningún Porte seleccionado</div>
                                                            </div>
                                                            <!-- TOTAL ROWS ============================= -->
                                                            <div class="row col-md-12 col-sm-12">
                                                                <div id="TotalRows_Datos_Portes" runat="server" class="col-md-4 col-sm-4 pd-l-0">
                                                                    <span><asp:Label runat="server" id="lblTotalRows_Datos_Portes" text=""></asp:Label></span>
                                                                </div>
                                                                <div id="TotalPages_Datos_Portes" runat="server" class="col-md-4 col-sm-4 text-center">
                                                                    <span><asp:Label runat="server" id="lblTotalPages_Datos_Portes" text=""></asp:Label></span>
                                                                </div>
                                                                <div class="col-md-4 col-sm-4 text-right">
                                                                    
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12 col-sm-12 pd-l-0 pd-r-0">
                                                                <asp:DataGrid ID="gr_Portes_Factura" runat="server"
                                                                    ShowHeader="False"
                                                                    GridLines="Horizontal"
                                                                    BorderWidth="0px"
                                                                    AllowSorting="False"
                                                                    AllowPaging="False"
                                                                    CellSpacing="0"
                                                                    CellPadding="0"
                                                                    AllowCustomPaging="False"
                                                                    PageSize="10"
                                                                    BorderStyle="None"
                                                                    AutoGenerateColumns="False"
                                                                    CssClass="">
                                                                    <FooterStyle></FooterStyle>
                                                                    <AlternatingItemStyle></AlternatingItemStyle>
                                                                    <ItemStyle></ItemStyle>
                                                                    <HeaderStyle></HeaderStyle>
                                                                    <Columns>
                                                                        <asp:TemplateColumn>
                                                                            <ItemTemplate>
                                                                                <div class="caja_regs_gridview">
                                                                                    <div class="row border-sup col-md-12 col-sm-12 pd-l-0 pd-r-0" style="margin-left: 0px; background-color: #DDDDDD;box-shadow: 3px 3px 8px #999;">
                                                                                        <div class="col-md-2 col-sm-2 col-xs-2 form-group datos_listado">
                                                                                            <span style="font-weight:bold">Nº </span><br />
                                                                                            <asp:Label runat="server" id="lblNumporFac" CssClass="" text=''></asp:Label>
                                                                                        </div>
                                                                                        <div class="col-md-3 col-sm-3 col-xs-3 form-group datos_listado">
                                                                                            <span style="font-weight:bold"><i class="fa fa-calendar"></i> Fecha</span><br />
                                                                                            <asp:Label runat="server" id="lblFechaPorteFac" CssClass="" text=''></asp:Label>
                                                                                        </div>
                                                                                        <div class="col-md-3 col-sm-3 col-xs-3 form-group datos_listado">
                                                                                            <span style="font-weight:bold"><i class="fa fa-truck"></i> MATRICULA</span><br />
                                                                                            <asp:Label runat="server" id="lblMatriculaFac" CssClass="" text=''></asp:Label>
                                                                                            <asp:HiddenField ID="hdnAUTOPORTEFac" runat="server" Value="" />
                                                                                        </div>
                                                                                        <div class="col-md-2 col-sm-2 col-xs-2 form-group datos_listado">
                                                                                            <span style="font-weight:bold"><i class="fa fa-truck"></i> Pagado</span><br />
                                                                                            <asp:Label runat="server" id="lblPortePagado" CssClass="" text=''></asp:Label>
                                                                                        </div>
                                                                                        <div class="col-md-2 col-sm-2 col-xs-2 pd-l-0 pd-r-10" style="margin-left:0px !important">          
                                                                                            <asp:LinkButton ID="btn_Delete" runat="server" CssClass="btn btn-fol btn-fol-forms-grey bt-search-registro hvr-grow-shadow btn-open-delete" data-toggle="tooltip" data-placement="bottom" Text="" ToolTip="Quitar Porte"><span class="fa fa-trash" style="margin-top: 13px;"></span></asp:LinkButton>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateColumn>
                                                                    </Columns>
                                                                    <PagerStyle VerticalAlign="Middle" HorizontalAlign="Center" CssClass="pagerEligible FOLcustom-footer-panel" Mode="NumericPages"></PagerStyle>
                                                                </asp:DataGrid>
                                                            </div>
                                                        </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </div> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row col-md-12 col-sm-12 pd-l-0 pd-r-0" style="margin-top:10px !important;">
                                    <div style="position: relative; left: 0px; top: 0px; height: 100%; z-index: 5; right: 0px; margin: 0px auto;">
                                        <div class="panel panel-default">
                                            <div class="panel-heading" style="background-color: #626060 !important; color: #fff;">
                                                <table border="0" class="clickable" style="width: 100%;">
                                                    <tr>
                                                        <td>
                                                            <h3 class="panel-title"><b>DATOS ECONÓMICOS</b></h3>
                                                        </td>
                                                        <td class="boton_collapse" style="width: 30px; border-left:1px solid #808080;">
                                                            <span class="pull-right"><i class="glyphicon glyphicon-chevron-up"></i></span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="panel-body" style="display: inline-block; width: 100%; min-height:150px; max-height: 650px; overflow-y: auto; background-color: #fff;">

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
            debugger;
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

            $('[data-toggle="tooltip"]').tooltip();
            
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
                    setTimeout(function () { $('#btn_Mensajes_Aceptar').focus(); }, 1000);
                }
            }
        }
        function pageLoad() {
            ReloadDatepickers();

            recarga_eventos_jquery();
        }
        
        function recarga_eventos_jquery() {
            var gridWidth = $("#tbl_filterPortes").width();// $(window).width();
		    var gridHeight = $(window).height() - 124;
		    var headerHeight1 = $("#ctl00_MainContent_UP_Filtros_Portes").height();
		    var headerHeight2 = $("divAddPortes .panel-body").height();
		    gridHeight = headerHeight2 - headerHeight1;
		    //alert("headerHeight=" + headerHeight);
		    //debugger;
		    $("#<%=grSelPortes.ClientID%>").gridviewScroll({
		        width: gridWidth,
		        height: 400,
		        startHorizontal: 0,
		        arrowsize: 30,
		        varrowtopimg: "images/arrowvt.png",
		        varrowbottomimg: "images/arrowvb.png",
		        harrowleftimg: "images/arrowhl.png",
		        harrowrightimg: "images/arrowhr.png"
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
    </script>
</asp:Content>
