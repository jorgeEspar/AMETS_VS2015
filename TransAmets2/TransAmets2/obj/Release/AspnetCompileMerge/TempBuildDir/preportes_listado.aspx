<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="preportes_listado.aspx.vb" Inherits="TransAmets2.preportes_listado" %>
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
    <script type="text/javascript" src="Scripts/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="Scripts/moment-with-locales.js"></script>
    <script type="text/javascript" src="Scripts/daterangepicker.js"></script>
    <script type="text/javascript" src="Scripts/respond.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap-dialog.min.js"></script>
    <script type="text/javascript" src="Scripts/master.js"></script>
    <style>
        /* COLLAPSE */
        .divAgenda .panel-heading span {
            margin-top: -20px;
            font-size: 15px;
        }
        .divAgenda .panel-heading {
            background-color: #ff0000;
            color: #fff;
            font-weight: bold;
        }

            .divAgenda .panel-heading i {
            }

        .divAgenda .clickable {
            background-color: #c3c3c3;
            max-height: 30px !important;
            cursor:pointer;
            cursor: hand;
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
        .panel-heading table.clickable hover{
            background-color: #000000;
            color:#fff;
            cursor:pointer;
            cursor: hand;
        }
        /* FIN COLLAPSE */
        .ELsortOrder div{
	        background-color: #ddd;
	        padding: 5px;
	        margin-bottom: 10px;
	        border-right: solid 2px rgb(242, 242, 242);
	        cursor: pointer;
        }
        .ELsortOrder .selected{ 
	        background-color: #189E18;
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
        #ctl00_MainContent_grPortes tbody > tr {
            border-bottom: 1px solid transparent;
        }
        #ctl00_MainContent_btnNuevo, #ctl00_MainContent_btnSearch, #MainContentbtnClearFilters {
            margin-top: 0px !important;
        }
        .bt-search-fol{font-size:0.5em !important;}

        @media screen and (min-width: 768px) {
	        #CapaMensajes .modal-dialog  {width:900px;}
            #BuscadorClientes .modal-dialog  {width:950px;}
            #BuscadorTransportistas .modal-dialog  {width:950px;}
        }
        .dividerH {
            height: 1px;
            width: 100%;
            display: block; /* for use on default inline elements like span */
            margin: 9px 0;
            overflow: hidden;
            background-color: #e5e5e5;
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
         #BuscadorTransportistas .modal-header .close{
             float: right !important;
            /*margin-right: -30px !important;
            margin-top: -30px !important;*/
            background-color: white !important;
            border-radius: 15px !important;
            width: 30px !important;
            height: 30px !important;
            opacity: 1 !important;
         }
         .container{padding-left:0px !important; padding-right:0px !important;}
         .cajabotones{ padding:0px !important; margin: 0px !important}

        .tcalertas {width:99% !important;padding-bottom:0px !important; margin-bottom:0px !important; font-size:12px;}
        .tcalertas tr td{padding-bottom:0px !important; margin-bottom:0px !important;}
        .tcalertas .importes {
            text-wrap:none; vertical-align:top;
            border-left:1px solid #DDDDDD;
            border-right:1px solid #DDDDDD;
            border-bottom:1px solid #DDDDDD;
            background-color: #FAFAFA;
            margin-left:5px !important;
            margin-right:5px !important;
            text-align:right;
            vertical-align:top;
        }
        .tcalertas .importes span { padding-right: 3px !important; }
        #ctl00_MainContent_rpEligible tbody > tr {
            border-bottom: 1px solid transparent;
        }
        .CajasEstado{
            font-size:1.3em;
            font-weight:bold;
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
        .tEstado{
            width:40px !important; height:40px !important; border:1px solid #808080; margin:3px !important; padding:3px !important; border-collapse:inherit; background-color:#fff;border-radius: 6px 0px 0px 0px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Always">
        <ContentTemplate>
            <asp:HiddenField ID="hdnPropietario" runat="server" />
            <asp:HiddenField ID="hdnConductor" runat="server" />
            
            <input name="hdnControlErrors" id="hdnControlJS" runat="server" type="hidden">
            <input name="hdnTipoErrors" id="hndTipoError" runat="server" type="hidden"/>
            <input name="hdnTitulo" id="hdnTitulo" runat="server" type="hidden"/>
            <input name="hdnRedirect" id="hdnRedirect" runat="server" type="hidden"/>
            <input name="hdnReload" id="hdnReload" runat="server" type="hidden"/>
        </ContentTemplate>
     </asp:UpdatePanel>
    <br />
    <div class="container container_summary">
        <div class="row" style="margin-top: -15px !important;">
            <div class="col-md-5 col-sm-5 text-left pd-l-0">
                <h1>Listado de PREPORTES</h1>
            </div>
            <div class="col-md-2 col-sm-2 text-center" style="margin-top: 20px;">
                <div id="CajaEstado1" runat="server" class="col-md-3 col-sm-3 CajasEstado" data-toggle="tooltip" data-placement="bottom" title="Preportes SIN SALIR" style="background-color: #FFFFFF; -webkit-border-radius: 4px 0px 0px 4px; -moz-border-radius: 4px 0px 0px 4px; border-radius: 4px 0px 0px 4px;"><label id="lblFacturado" runat="server" class="FacCobPag" style="margin-top:5px;">&nbsp;</label></div>
                <div id="CajaEstado2" runat="server" class="col-md-3 col-sm-3 CajasEstado" data-toggle="tooltip" data-placement="bottom" title="Preportes Han salido Hoy" style="background-color: #00FFFF;"><label id="Label3" runat="server" class="FacCobPag" style="margin-top:5px;">&nbsp;</label></div>
                <div id="CajaEstado3" runat="server" class="col-md-3 col-sm-3 CajasEstado" data-toggle="tooltip" data-placement="bottom" title="Preportes Han salido pero les faltan datos para ser validados" style="background-color: #ff0000;"><label id="lblCobrado" runat="server" class="FacCobPag" style="margin-top:5px;">&nbsp;</label></div>
                <div id="CajaEstado4" runat="server" class="col-md-3 col-sm-3 CajasEstado" data-toggle="tooltip" data-placement="bottom" title="Preportes listos para ser validados" style="background-color: #848284;-webkit-border-radius: 0px 4px 4px 0px; -moz-border-radius: 0px 4px 4px 0px; border-radius: 0px 4px 4px 0px;"><label id="lblPagado" runat="server" class="FacCobPag" style="margin-top:5px;">&nbsp;</label></div>
            </div>
            <div class="col-md-5 col-sm-5 pd-r-0" style="margin-top: 21px;"">
                <div style="float:right;">
                    <!--<div id="cajabotones" style="float: right; position: absolute; top: 0; z-index: 1; right: 0;">-->
                        <asp:UpdatePanel runat="server" ID="UP_Botones" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="col-md-2 col-sm-2 form-group pd-l-0 pd-r-0">
                                    <a id="btnClearFilters" onclick="LimpiarFiltros()" class="btn btn-fol-forms-grey-med bt-search-fol hvr-grow-shadow" style="margin-top: 0px;" data-toggle="tooltip" data-placement="bottom" title="Limpiar filtros"><span class="fa fa-undo" style="margin-top: 6px;"></span></a>
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <asp:LinkButton ID="btnNuevo" runat="server" CssClass="btn btn-fol-forms-grey-med bt-search-fol hvr-grow-shadow" Text="" data-toggle="tooltip" data-placement="bottom" ToolTip="Añadir nuevo Preporte">Nuevo&nbsp;&nbsp;<span class="fa fa-plus"></span></asp:LinkButton>    
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <asp:LinkButton ID="btnSearch" runat="server" CssClass="form-control btn btn-fol-forms-grey bt-search-fol hvr-grow-shadow" Text="Aceptar" data-toggle="tooltip" data-placement="bottom" ToolTip="Buscar Preportes con los filtros indicados"><span class="fa fa-search"></span>&nbsp;&nbsp;Buscar</asp:LinkButton>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    <!--</div>-->
                </div>
            </div>
        </div>

        <div class="row col-md-12 col-sm-12 pd-l-0 pd-r-0" style="margin-right: -10px !important; margin-left: -10px !important; margin-top:10px !important;">
            <div id="divAgenda" style="position: relative; left: 0px; top: 0px; height: 100%; z-index: 5; right: 0px; margin: 0px auto;">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <table border="0" class="clickable" style="width: 100%;">
                            <tr>
                                <td>
                                    <h3 class="panel-title"><b>FILTROS DE BÚSQUEDA</b></h3>
                                </td>
                                <td class="boton_collapse" style="width: 30px; border-left:1px solid #808080;">
                                    <span class="pull-right"><i class="glyphicon glyphicon-chevron-up"></i></span>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="panel-body" style="display: inline-block; width: 100%; max-height: 650px; overflow-y: auto; background-color: #fff;">
                        <asp:UpdatePanel runat="server" ID="UP_Filtros" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div id="tbl_filters1" class="row" style="margin-left:0px !important; margin-right: 10px !important;margin-top:  10px">
                                    <div class="col-md-7 col-sm-7 col-xs-7 form-group pd-l-0 pd-r-0">
                                        <div class="col-md-9 col-sm-9 col-xs-9 form-group">
                                            <Label class="txtCliente"><i class="fa fa-user"></i> Cliente</Label>
                                            <div class="form-group gutter-0 pd-l-0 pd-r-0">
                                                <div class="col-md-2 col-sm-2 col-xs-2 form-group pd-l-0 pd-r-5">
                                                    <asp:TextBox class="string form-control" id="txtCodCli" runat="server" maxlength="4"  AutoPostBack="true" Text=""></asp:TextBox>
                                                </div>
                                                <div class="col-md-10 col-sm-10 col-xs-10 form-group pd-l-5 pd-r-0">
                                                    <div class="input-group">
                                                        <asp:TextBox class="string form-control" id="txtCliente" runat="server" maxlength="40" Text="" ReadOnly="true"></asp:TextBox>
                                                        <asp:Label id="lbldeleteprescriptor" runat="server" class="input-group-addon btn pd-l-5 pd-r-5" onclick="DeleteCliente();"><span id="ico_delete_cliente" class="fa fa-times"></span></asp:Label>
                                                        <asp:Label id="lblicobuscadorPrescriptor" runat="server" class="input-group-addon btn btn_ico activo" onclick="OpenBuscadorClientes();"><span id="ico_buscador_cliente" class="fa fa-search"></span></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3 col-sm-3 col-xs-3 form-group pd-l-0 pd-r-10">
                                            <label for="txtMatricula"><i class="fa fa-truck"></i> Matrícula</label>
                                            <div class="input-group">
                                                <asp:TextBox class="string form-control" id="txtMatricula" runat="server" maxlength="15" Text=""></asp:TextBox>
                                                <asp:Label id="Label1" runat="server" class="input-group-addon btn pd-l-5 pd-r-5" onclick="DeleteTransportista();"><span id="ico_delete_matricula" class="fa fa-times"></span></asp:Label>
                                                <asp:Label id="Label2" runat="server" class="input-group-addon btn btn_ico activo" onclick="OpenBuscadorTransportistas();"><span id="ico_buscador_matricula" class="fa fa-search"></span></asp:Label>
                                                <asp:HiddenField ID="hndCodTransportista" runat="server" Value="" />
                                            </div>
                                        </div>
                                    </div>
                            
                                    <div class="col-md-5 col-sm-5 col-xs-5 form-group pd-l-0 pd-r-0">
                                        <div class="col-md-7 col-sm-7 col-xs-7 form-group pd-l-0 pd-r-5">
                                            <label for="dllAgencias"><i class="fa fa-th-list"></i> Agencia</label>
                                            <asp:DropDownList runat="server" ID="ddlAgencias" CssClass="form-control selectpicker show-tick" data-width="100%">
                                            
                                            </asp:DropDownList>  
                                        </div>          
                                        <div class="col-md-5 col-sm-5 col-xs-5 form-group pd-l-5 pd-r-5">
                                            <label for="dllTipoPorte"><i class="fa fa-th-list"></i> Estado</label>
                                            <asp:DropDownList runat="server" ID="ddlEstado" CssClass="form-control selectpicker show-tick" data-width="100%">
                                                <asp:ListItem Selected="True" Value="">TODOS</asp:ListItem>
                                                <asp:ListItem Value="SS">Sin Salir</asp:ListItem>
                                                <asp:ListItem Value="SH">Ha salido hoy</asp:ListItem>
                                                <asp:ListItem Value="FD">Ha salido faltan datos</asp:ListItem>
                                                <asp:ListItem Value="LV">Listos para validar</asp:ListItem>
                                            </asp:DropDownList>                                       
                                        </div>                          
                                    </div>
                                </div>

                                <div id="tbl_filters2" class="row" style="margin-left:15px !important; margin-right: 0px !important">
                                    <div class="col-md-4 col-sm-4 col-xs-4 form-group pd-l-0 pd-r-0">
                                        <div class="col-md-6 col-sm-6 col-xs-6 form-group pd-l-0">
                                            <label for="txtFecPrePorte"><i class="fa fa-calendar"></i> Fecha Preporte</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="txtFecPrePorte" runat="server" CssClass="form-control date-picker hasDatepicker"></asp:TextBox>
                                                <label for="date-picker" class="input-group-addon"><span class="fa fa-calendar"></span></label>
                                            </div>
                                        </div>  
                                        <div class="col-md-6 col-sm-6 col-xs-6 form-group pd-l-0 pd-r-5">
                                            <label for="txtFechaPorte"><i class="fa fa-calendar"></i> Fecha PORTE</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="txtFechaPorte" runat="server" CssClass="form-control date-picker hasDatepicker"></asp:TextBox>
                                                <label for="date-picker" class="input-group-addon"><span class="fa fa-calendar"></span></label>
                                            </div>
                                        </div>    
                                        
                                    </div>
                            
                                    <div class="col-md-8 col-sm-8 col-xs-8 form-group pd-l-0 pd-r-10">
                                        <div class="col-md-4 col-sm-4 col-xs-4 form-group pd-l-5 pd-r-5">
                                            <Label class="txtDirCarga"><i class="fa fa-map-marker-alt"></i><i class="fa fa-arrow-right"></i> Origen</Label>
                                            <asp:TextBox class="string form-control" id="txtDirCarga" runat="server" maxlength="30" Text=""></asp:TextBox>                                       
                                        </div>
                                        <div class="col-md-4 col-sm-4 col-xs-4 form-group  pd-l-5 pd-r-5">
                                            <label for="txtDestino"><i class="fa fa-arrow-right"></i><i class="fa fa-map-marker-alt"></i> Destino</label>
                                            <asp:TextBox class="string form-control" id="txtDestino" runat="server" maxlength="30" Text=""></asp:TextBox>
                                        </div>
                                        <div class="col-md-4 col-sm-4 col-xs-4 form-group pd-l-5 pd-r-0">
                                            <label for="txtMercancia"><i class="fa fa-cube"></i> Mercancia</label>
                                            <asp:TextBox class="string form-control" id="txtMercancia" runat="server" maxlength="30" Text=""></asp:TextBox>
                                        </div>
                                        
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
            
        <div class="row pestanas" style="z-index: 1; margin-top: 5px;">
            <div class="pestanas col-md-12 col-sm-12 pd-l-0 pd-r-0">  
                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active pd-l-0 pd-r-0" id="eligible">
                        <asp:UpdatePanel runat="server" ID="UP_Eligible" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div id="ELsortOrder" class="col-md-12 col-sm-12 pd-l-0 pd-r-0 ELsortOrder" runat="server">
                                <div class="col-md-3 col-sm-3 text-center ordenacion selected DecisionExpiryDate" data-field="NORMAL">Fecha Porte - Nº Preporte<i class="fa fa-caret-down"></i></div>
	                            <div class="col-md-3 col-sm-3 text-center ordenacion CustomerName" data-field="FECLIENTE">Fecha Porte - Cliente</div>
	                            <div class="col-md-3 col-sm-3 text-center ordenacion Nombre" data-field="CLIENTEFE">Cliente - Fecha Porte</div>
                                <div class="col-md-3 col-sm-3 text-center ordenacion Marca" data-field="MATFE">Matrícula - Fecha Porte</div>
                            </div>

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
                                <div id="TotalPages_Datos" runat="server" class="col-md-4 col-sm-4 text-center">
                                    <span><asp:Label runat="server" id="lblTotalPages_Datos" text=""></asp:Label></span>
                                </div>
                                <div class="col-md-4 col-sm-4 text-right">
                                    <span><asp:Label runat="server" id="lblEstado" text="" Font-Bold="true"></asp:Label></span>
                                </div>
                            </div>
                            <div class="col-md-12 col-sm-12 pd-l-0 pd-r-0">
                                <asp:DataGrid ID="grPortes" runat="server"
                                ShowHeader="False"
                                GridLines="Horizontal"
                                BorderWidth="0px"
                                AllowSorting="False"
                                AllowPaging="True"
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
                                                    <div class="col-md-4 col-sm-4 col-xs-4 pd-l-0">
                                                        <div class="col-md-2 col-sm-2 pd-l-0 pd-r-10">
                                                            <table id="tEstado" runat="server" class="tEstado" border="0" style="">
                                                            <tr>
                                                                <td style="width:100%; text-align:center; vertical-align:middle;">&nbsp;</td>
                                                            </tr>
                                                            </table>
                                                        </div>
                                                        <div class="col-md-2 col-sm-2 col-xs-2 form-group datos_listado">
                                                            <span style="font-weight:bold">Nº </span><br />
                                                            <asp:Label runat="server" id="lblNumpor" CssClass="" text=''></asp:Label>
                                                        </div>
                                                        <div class="col-md-4 col-sm-4 col-xs-4 form-group datos_listado">
                                                            <span style="font-weight:bold"><i class="fa fa-calendar"></i> Fecha </span><br />
                                                            <asp:Label runat="server" id="lblFechaPorte" CssClass="" text=''></asp:Label>
                                                        </div>
                                                        <div class="col-md-4 col-sm-4 col-xs-4 form-group datos_listado">
                                                            <span style="font-weight:bold"><i class="fa fa-calendar"></i> F. PORTE </span><br />
                                                            <asp:Label runat="server" id="lblFechaEntrega" CssClass="" text=''></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 col-sm-6 col-xs-6">
                                                        <div class="col-md-9 col-sm-9 col-xs-9 form-group datos_listado">
                                                            <span style="font-weight:bold"><i class="fa fa-user"></i> Cliente </span><br />
                                                            <asp:Label runat="server" id="lblCliente" CssClass="" text=''></asp:Label>
                                                        </div>
                                                        <div class="col-md-3 col-sm-3 col-xs-3 form-group datos_listado">
                                                            <span style="font-weight:bold"><i class="fa fa-truck"></i> MATRICULA </span><br />
                                                            <asp:Label runat="server" id="lblMatricula" CssClass="" text=''></asp:Label>
                                                            <asp:HiddenField ID="hdnAUTOPORTE" runat="server" Value="" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-2 col-sm-2 col-xs-2 pd-l-0 pd-r-10" style="margin-left:0px !important">
                                                        <div class="col-md-12 col-sm-12 pd-l-0 pd-r-0" style="text-align:right">            
                                                            <asp:LinkButton ID="btnOpen_Porte" runat="server" CssClass="btn btn-fol btn-fol-forms-grey bt-search-registro hvr-grow-shadow btn-open-delete" data-toggle="tooltip" data-placement="bottom" Text="" ToolTip="Abrir Preporte"><span class="fa fa-search" style="margin-top: 13px;"></span></asp:LinkButton>
                                                            <asp:LinkButton ID="btn_Delete" runat="server" CssClass="btn btn-fol btn-fol-forms-grey bt-search-registro hvr-grow-shadow btn-open-delete" data-toggle="tooltip" data-placement="bottom" Text="" ToolTip="Dar de Baja Preporte"><span class="fa fa-trash" style="margin-top: 13px;"></span></asp:LinkButton>
                                                            <asp:LinkButton ID="btnValidarPorte" runat="server" CssClass="btn btn-fol btn-fol-forms-grey bt-search-registro hvr-grow-shadow btn-open-delete" data-toggle="tooltip" data-placement="bottom" Text="" ToolTip="Validar Preporte"><span class="far fa-check-square" style="margin-top: 13px;font-size:1.3em"></span></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row col-md-12 col-sm-12 pd-l-15 pd-r-5" style="margin-left: 0px !important;margin-top:5px">
                                                    <table class="tcalertas" border="0" style="width:100% !important;">
                                                        <tr>
                                                            <td style="width:35%; text-wrap:inherit;vertical-align:top;">
                                                                <Label for="lbl_ORIGEN" style="font-weight:bold"><i class="fa fa-map-marker-alt"></i><i class="fa fa-arrow-right"></i> Dirección de Carga</Label><br />
                                                                <asp:Label runat="server" id="lbl_ORIGEN" text=""></asp:Label>
                                                            </td>
                                                            <td style="width:35%; text-wrap:inherit;vertical-align:top;">
                                                                <label for="lbl_DESTINO" style="font-weight:bold"><i class="fa fa-arrow-right"></i><i class="fa fa-map-marker-alt"></i> Dirección Destino</label><br />
                                                                <asp:Label runat="server" id="lbl_DESTINO" text=""></asp:Label>
                                                            </td>
                                                            <td style="width:30%; text-wrap:inherit;vertical-align:top;">
                                                                <label for="lbl_MERCANCIA" style="font-weight:bold"><i class="fa fa-cube"></i> MERCANCIA</label><br />
                                                                <asp:Label runat="server" id="lbl_MERCANCIA" text=""></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr><td colspan="3" style="height:1px; background-color:#808080"></td></tr>
                                                        <tr>
                                                            <td style="width:35%; text-wrap:none;vertical-align:top;">
                                                                <label for="lbl_DETALLE_Origen" style="font-weight:bold"><i class="fa fa-info-circle"></i> DETALLE ORIGEN</label><br />
                                                                <asp:Label runat="server" id="lbl_DETALLE_Origen" text=""></asp:Label>
                                                            </td>
                                                            <td style="width:35%; text-wrap:none;vertical-align:top;">
                                                                <label for="lbl_DETALLE_Destino" style="font-weight:bold"><i class="fa fa-info-circle"></i> DETALLE DESTINO</label><br />
                                                                <asp:Label runat="server" id="lbl_DETALLE_Destino" text=""></asp:Label>
                                                            </td>
                                                            <td style="width:30%; text-wrap:none;vertical-align:top;">
                                                                <label for="lbl_DETALLE_Trans" style="font-weight:bold"><i class="fa fa-info-circle"></i> DETALLE Trans.</label><br />
                                                                <asp:Label runat="server" id="lbl_DETALLE_Trans" text=""></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                </Columns>
                                <PagerStyle VerticalAlign="Middle" HorizontalAlign="Center" CssClass="pagerEligible FOLcustom-footer-panel" Mode="NumericPages"></PagerStyle>
                            </asp:DataGrid>
                            </div> 
                            <input id="EL_sort_field" runat="server"  type="hidden" />
                            <input id="EL_sort_order" runat="server" type="hidden" value="asc" />
                        </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
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
        //curruserid = "";
        $(document).keypress(function (e) {
            if (e.keyCode === 13) {
                $("#<%= btnSearch.ClientID%>")[0].click();
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
            $get('UpdateProgress1').style.display = "block";
        }
        function EndRequest(sender, args) {
            $('#ctl00_UpdateProgress1').hide();

            $("#ctl00_MainContent_ddlEstado").selectpicker('refresh');
            $("#ctl00_MainContent_ddlEstado").selectpicker('render');

            ReloadDatepicker();
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

            if ($("#ctl00_MainContent_EL_sort_field").val() != "") {
                if ($("#ctl00_MainContent_EL_sort_order").val() == "DESC") {
                    $(".ELsortOrder").find("." + $("#ctl00_MainContent_EL_sort_field").val()).addClass('selected').append('&nbsp;<i class="fa fa-caret-down"></i>');
                } else {
                    $(".ELsortOrder").find("." + $("#ctl00_MainContent_EL_sort_field").val()).addClass('selected').append('&nbsp;<i class="fa fa-caret-up"></i>');
                }
            }

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

            $('[data-toggle="tooltip"]').tooltip();

            $("#ctl00_MainContent_txtNombre").focus();

            CompruebaErrores();
        });

        function scrollToTop() {
            verticalOffset = typeof (verticalOffset) != 'undefined' ? verticalOffset : 0;
            element = $('body');
            offset = element.offset();
            offsetTop = offset.top;
            $('html, body').animate({ scrollTop: 0 }, 200, 'linear');
        }

        function ActiveSorting() {
            $(document).on('click', ".ordenacion", function (e) {
                $(document).off('click', ".ordenacion");
                e.preventDefault();

                var campo = $(this).attr('data-field');
                var orden = "ASC";

                //si tiene i es que cambiamos la ordenacion
                if ($(this).has('i').length) {
                    if ($(this).find('i').hasClass('fa-caret-down')) {
                        //ordenamos de forma ascendente
                        $(this)
                            .addClass('selected')
                            .find('i').removeClass('fa-caret-down').addClass('fa-caret-up');
                    } else {
                        //ordenamos de forma descendente
                        $(this).find('i').removeClass('fa-caret-up').addClass('fa-caret-down');
                        orden = "DESC";
                    }
                } else {
                    //borramos todos los campos
                    $(this).parent()
                        .find('div').removeClass('selected')
                        .find('i').remove();
                    //ordenamos de forma descendente por el campo que hayan hecho click
                    $(this).addClass('selected').append('&nbsp;<i class="fa fa-caret-up"></i>');
                }

                //colocamos los valores del campo y el orden y simulamos click para el PostBack
                $("#ctl00_MainContent_EL_sort_field").val(campo);
                $("#ctl00_MainContent_EL_sort_order").val(orden);
                
                $("#ctl00_MainContent_btOrdenacion").trigger('click');
            });
        };

        function ReloadDatepicker() {
            $("#ctl00_MainContent_ddlEstado").selectpicker('refresh');
            $("#ctl00_MainContent_ddlEstado").selectpicker('render');

            $("#ctl00_MainContent_ddlAgencias").selectpicker('refresh');
            $("#ctl00_MainContent_ddlAgencias").selectpicker('render');
            
            ActiveSorting();
            /* CALENDARIOS ============================================== */
            $('#ctl00_MainContent_txtFecPrePorte').daterangepicker({
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
                "cancelClass": "btn-cleantxtFecPrePorte"
            }, function(start, end, label) {            
                $('#ctl00_MainContent_txtFecPrePorte').val(start.format('DD/MM/YYYY') + ' - ' + end.format('DD/MM/YYYY'));
                //console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
                //console.log(this);
            });
            /* Acciones de calendarios para reiniciar los input */
            $('.btn-cleantxtFecPrePorte').on('click', function () {
                $("#ctl00_MainContent_txtFecPrePorte").val('');
            });

            $('#ctl00_MainContent_txtFechaPorte').daterangepicker({
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
                "cancelClass": "btn-cleantxtFechaPorte"
            }, function (start, end, label) {
                $('#ctl00_MainContent_txtFechaPorte').val(start.format('DD/MM/YYYY') + ' - ' + end.format('DD/MM/YYYY'));
                //console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
                //console.log(this);
            });
            /* Acciones de calendarios para reiniciar los input */
            $('.btn-cleantxtFechaPorte').on('click', function () {
                $("#ctl00_MainContent_txtFechaPorte").val('');
            });
        };

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
                document.location.href = 'Login.aspx';
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
            $("#<%=hdnPropietario.ClientId%>").val(propietario);
            $("#<%=hdnConductor.ClientId%>").val(conductor);
            $('#BuscadorTransportistas').modal('toggle');
        }
        function DeleteTransportista() {
            $("#<%=txtMatricula.ClientId%>").val("");
            $("#<%=hdnPropietario.ClientID%>").val("");
            $("#<%=hdnConductor.ClientId%>").val("");
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
            $("#txtFecPrePorte").val('');
            $("#txtCliente").val('');
            $("#txtMatricula").val('')
            $("#<%=txtCliente.ClientId%>").val("");
            $("#<%=txtCodCli.ClientId%>").val("");

            $("#<%=txtMatricula.ClientId%>").val("");
            $("#<%=hdnPropietario.ClientID%>").val("");
            $("#<%=hdnConductor.ClientId%>").val("");

            $("#dllAgencias").val('');
            $("#ddlEstado").val('');
            $("#txtFechaPorte").val('');
            $("#txtDirCarga").val('');
            $("#txtDestino").val('');
            $("#txtMercancia").val('');
        }
    </script>
</asp:Content>
