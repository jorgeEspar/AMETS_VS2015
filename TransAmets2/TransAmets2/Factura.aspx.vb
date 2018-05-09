Imports System.IO
Imports System.Net.Mail

Public Class Factura1
    Inherits System.Web.UI.Page
    Private CapaDatos As New CapaDatos
    Private objComun As New Comun

    Private msg As String = String.Empty
    Private tituloMsg As String = ""
    Private TablaErrores As DataTable

    Public AUTOFAC As Long = 0
    Public NUMERO_FAC As String = 0
    Public NUMFAC As String = String.Empty
    Public CLIENTE_FAC As Integer = 0
    Public Nuevo As Boolean = False
    Public Baja As Boolean = False

    Dim dtPortesSeleccionar As DataTable
    Dim dtPortesFactura As DataTable

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnControlJS.Value = "" ' Inicializamos los mensajes de errores
        msg = ""
        Try
            If Not IsPostBack Then
                Session("dtPortesSeleccionar") = dtPortesSeleccionar
                Session("dtPortesFactura") = dtPortesFactura
                hndAlta.Value = "0"
                hndBaja.Value = "0"

                Nuevo = False
                Baja = False

                If Session("DatosUser") Is Nothing Then
                    Response.Redirect("login.aspx", True)
                Else
                    If Request.QueryString("id") IsNot Nothing Then
                        If Request.QueryString("id") <> "" Then
                            AUTOFAC = CLng(Request.QueryString("id"))
                            hdnFacturaId.Value = Request.QueryString("id")
                        End If
                    End If
                    If Request.QueryString("P") IsNot Nothing Then
                        If Request.QueryString("P") <> "" Then
                            NUMERO_FAC = Request.QueryString("P")
                            hdnNUMFAC.Value = NUMERO_FAC
                        End If
                    End If
                    If Request.QueryString("N") IsNot Nothing Then
                        If Request.QueryString("N") = "S" Then Nuevo = True
                        If Request.QueryString("B") = "S" Then Baja = True
                    End If

                    Carga_Combos()

                    If Nuevo = True Then
                        hndAlta.Value = "1"
                        Dim numporte As Long = CapaDatos.Get_Num_Portes()
                        numporte += 1
                        txtNumFactura.Text = numporte.ToString
                        txtFecFactura.Text = DateTime.Now.ToString("dd/MM/yyyy")
                    Else
                        If hdnFacturaId.Value <> "" Then
                            Carga_Factura(hdnFacturaId.Value)
                            If txtFecCobro.Text.Trim() <> "" Then
                                Deshabilitar_Controles(True)
                            End If
                        End If
                        If Baja = True Then
                            hndBaja.Value = "1"
                            Deshabilitar_Controles(True)
                        End If
                    End If
                End If

                btnEmail.Visible = False
                btnOpenFactura.Visible = False
                btnBtnImprimir.Visible = False

                If Nuevo = True Then
                    lblTituloPag.InnerText = "NUEVA FACTURA"
                Else
                    Dim filename As String = "Factura_" & NUMERO_FAC.ToString().Replace("/", "-") & ".pdf"
                    Dim filepath As String = Server.MapPath("~" & "/Documentos/Facturas/") & filename
                    If File.Exists(filepath) = True Then
                        hdnFilePDF.Value = "Documentos/Facturas/" & filename
                    End If

                    If Baja = True Then
                        lblTituloPag.InnerText = "BAJA FACTURA [" & NUMERO_FAC.ToString() & "]"
                    Else
                        btnBtnImprimir.Visible = True

                        lblTituloPag.InnerText = "MODIFICACIÓN FACTURA [" & NUMERO_FAC.ToString() & "]"
                        If File.Exists(filepath) = True Then
                            btnEmail.Visible = True
                            btnOpenFactura.Visible = True
                        End If
                    End If

                    If txtFecCobro.Text.Trim() <> "" Then
                        lblTituloPag.InnerText = "CONSULTA FACTURA [" & NUMERO_FAC.ToString() & "]"
                        divPortesClientePend.Style.Add("display", "none")
                        btnGuardar.Visible = False
                    End If
                End If
            End If
        Catch ex As Exception
            MuestraMensaje("Error: " & ex.Message.ToString(), 1, "ERROR")
        End Try
    End Sub
    Private Sub Deshabilitar_Controles(ByVal todos As Boolean)
        txtFecFactura.Enabled = False
        txtFecVencimiento.Enabled = False
        btnBtnImprimir.Visible = False

        txtCodCli.Enabled = False
        lbldeleteprescriptor.Visible = False
        lblicobuscadorPrescriptor.Visible = False

        'btnAdd_Agenda.Visible = False

        ddlAgencias.Enabled = False

        chkRecargo.Disabled = True
        txtRecargo.Enabled = False
        chkDescuento.Disabled = True
        txtDescuento.Enabled = False
        chkIVA.Disabled = True

        tbl_CobrosFactura.Style.Add("display", "none")

        txtFormaPago.ReadOnly = True
        txtObservaciones.ReadOnly = True

        'divPortesClientePend.Style.Add("display", "none")

    End Sub
    Private Sub Carga_Factura(ByVal AUTOFAC As Long)
        Dim dt As DataTable
        Dim cadena As String
        Dim valor As Double
        Dim fechacobro As String = String.Empty
        Dim fechapago As String = String.Empty
        Dim factura As String = String.Empty

        hndAlta.Value = "0"

        Try
            dt = CapaDatos.Get_Datos_Factura(AUTOFAC, "")
            If dt.Rows.Count > 0 Then
                txtCodCli.Text = dt.Rows(0).Item("CLIENTE_FAC").ToString()
                txtCliente.Text = "" & dt.Rows(0).Item("CLINOM").ToString()
                hdnClienteId.Value = dt.Rows(0).Item("CLIENTE_FAC")
                hdnClienteEmail.Value = "" & dt.Rows(0).Item("EMAIL")
                txtEmailCliente.Text = hdnClienteEmail.Value

                txtNumFactura.Text = "" & dt.Rows(0).Item("NUMERO").ToString()
                hdnNUMFAC.Value = "" & dt.Rows(0).Item("NUMFAC").ToString()
                txtFecFactura.Text = "" & dt.Rows(0).Item("FECHA_FAC")
                txtFecVencimiento.Text = "" & dt.Rows(0).Item("FECHA_VTO")

                fechacobro = "" & dt.Rows(0).Item("FECHA_COBRO")
                txtFecCobro.Text = fechacobro
                If fechacobro <> "" Then
                    txtFecCobro.BackColor = System.Drawing.ColorTranslator.FromHtml("#01B101")
                    txtFecCobro.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FFFFFF")
                Else
                    txtFecCobro.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFFFF")
                    txtFecCobro.ForeColor = System.Drawing.ColorTranslator.FromHtml("#000000")
                End If

                txtFormaPago.Text = "" & dt.Rows(0).Item("FORMA_PAGO").ToString()
                txtObservaciones.Text = "" & dt.Rows(0).Item("OBSERVACIONES_FAC").ToString()

                Carga_Portes_Factura(True)
                If fechacobro = "" Then
                    Carga_Portes_Cliente()
                Else
                    ActualizaPortesFactura()
                End If

                Dim BAS_IMPO_FAC As Double = dt.Rows(0).Item("BAS_IMPO_FAC")

                cadena = txtVenta.Text
                If cadena <> "" Then
                    cadena = cadena.Replace(".", "")
                    cadena = cadena.Replace(",", ".")
                    valor = CDbl(cadena)
                    If BAS_IMPO_FAC <> valor Then
                        txtVenta.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FF0000")
                        txtVenta.ToolTip = "En BBDD: " & FormatNumber(BAS_IMPO_FAC, 2).ToString()
                        'txtVenta.Style.Add("color", "#FF0000")
                    End If
                End If

                Dim porciento As Double = 0
                Dim imp_porcentaje As Double = 0
                cadena = "" & dt.Rows(0).Item("REC_EQUIV")
                porciento = 0
                If cadena <> "" Then
                    imp_porcentaje = CDbl(cadena)
                    If imp_porcentaje > 0 Then
                        porciento = imp_porcentaje / BAS_IMPO_FAC * 100
                        chkRecargo.Checked = True
                    End If
                    txtRecargo.Text = FormatNumber(porciento, 2)
                End If

                cadena = "" & dt.Rows(0).Item("DESCUENTO")
                porciento = 0
                If cadena <> "" Then
                    imp_porcentaje = CDbl(cadena)
                    If imp_porcentaje > 0 Then
                        porciento = imp_porcentaje / BAS_IMPO_FAC * 100
                        chkDescuento.Checked = True
                    End If
                    txtDescuento.Text = FormatNumber(porciento, 2)
                End If

                cadena = "" & dt.Rows(0).Item("IVA_FAC")
                porciento = 0
                If cadena <> "" Then
                    imp_porcentaje = CDbl(cadena)
                    If imp_porcentaje > 0 Then
                        porciento = imp_porcentaje / BAS_IMPO_FAC * 100
                        chkIVA.Checked = True
                    End If
                    txtIVA.Text = FormatNumber(porciento, 2)
                End If

                Actualiza_Datos_Economicos()
                UP_Datos_Economicos.Update()

            Else
                MuestraMensaje("La Factura Nº " & AUTOFAC.ToString() & " no se ha encontrado.", 1, "ERROR")
            End If
        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        End Try
    End Sub

#Region "Funciones varias"
    Private Sub Carga_Combos()
        Dim dt As DataTable
        Dim msgpagina As String = ""
        Dim items1 As New ListItem
        items1.Text = "Seleccione"
        items1.Value = ""
        ddlAgencias.Items.Add(items1)

        Try
            dt = CapaDatos.Get_Agencias_Trans("", "")
            If Not dt Is Nothing Then
                If dt.Rows.Count > 0 Then
                    For Each dr As DataRow In dt.Rows
                        Dim items2 As New ListItem
                        items2.Text = dr.Item("NOMBRE_COOP")
                        items2.Value = dr.Item("AUTOCOOP")
                        ddlAgencias.Items.Add(items2)
                    Next
                End If
                ddlAgencias.SelectedIndex = 0
            End If
        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        End Try
    End Sub

    Private Sub MuestraMensaje(ByVal mensaje As String, ByVal tipo As Integer, Optional titulo As String = "", Optional redirect As String = "")
        mensaje = mensaje.Replace("<br/>", "\n")
        mensaje = mensaje.Replace("<br />", "\n")
        hdnControlJS.Value = mensaje
        Select Case tipo
            Case 1
                hndTipoError.Value = "ERROR" ' color ROJO
                If titulo = "" Then titulo = "ERROR"
            Case 2
                hndTipoError.Value = "AVISO" ' color AMARILLO
                If titulo = "" Then titulo = "AVISO"
            Case 3
                hndTipoError.Value = "OK" ' color VERDE
                If titulo = "" Then titulo = "MENSAJE"
            Case Else
                hndTipoError.Value = "MENSAJE" ' color AZUL
                If titulo = "" Then titulo = "MENSAJE"
        End Select
        hdnTitulo.Value = titulo
        hdnRedirect.Value = redirect
    End Sub
#End Region

#Region "Campos Clientes - txtCodCli, Buscador Cliente -> cargar Portes Cliente"
    Private Sub txtMatricula_TextChanged(sender As Object, e As EventArgs) Handles txtMatricula.TextChanged
        Dim dt As DataTable
        txtConductor.Text = ""
        If txtMatricula.Text <> "" Then
            dt = CapaDatos.Get_Transportistas(txtMatricula.Text, "", "")
            If dt.Rows.Count > 0 Then
                txtConductor.Text = dt.Rows(0).Item("CONDUCTOR")
            End If
        End If

        UP_Filtros_Portes.Update()
    End Sub

    Private Sub txtCodCli_TextChanged(sender As Object, e As EventArgs) Handles txtCodCli.TextChanged
        dtPortesSeleccionar = Nothing
        dtPortesFactura = Nothing
        Session("dtPortesSeleccionar") = dtPortesSeleccionar
        Session("dtPortesFactura") = dtPortesFactura

        Dim dt As DataTable
        txtCliente.Text = ""
        grPortesFactura.DataSource = ""
        grPortesFactura.DataBind()

        If txtCodCli.Text <> "" Then
            CLIENTE_FAC = CInt(txtCodCli.Text)
            dt = CapaDatos.Get_Clientes(CLIENTE_FAC.ToString, "", "")
            If dt.Rows.Count > 0 Then
                txtCliente.Text = dt.Rows(0).Item("CLINOM").replace(vbCrLf, " - ")
                hdnClienteEmail.Value = "" & dt.Rows(0).Item("EMAIL")
                txtEmailCliente.Text = hdnClienteEmail.Value
            End If
        Else
            CLIENTE_FAC = 0
        End If

        UPCODCLI.Update()
        UP_Filtros_Portes.Update()
        UP_Portes_Factura.Update()

        Carga_Portes_Cliente()
    End Sub

    Private Sub Carga_Cobros_Factura()
        Try
            Dim dt As DataTable = CapaDatos.Get_Cobros_Factura(AUTOFAC, "")
            Session("dtCobrosFactura") = dt
            If dt.Rows.Count > 0 Then
                NoRegs_Cobros_Factura.Visible = False
            Else
                NoRegs_Cobros_Factura.Visible = True
            End If

            grCobrosFactura.DataSource = dt
            grCobrosFactura.DataBind()
        Catch ex As Exception
            MuestraMensaje("Error al cargar los Cobros de la Factura.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub
    Private Sub Carga_Factura_Emails()
        Try
            Dim dt As DataTable = CapaDatos.Get_Factura_Emails(AUTOFAC)
            If dt.Rows.Count > 0 Then
                NoRegs_FacturaEmails.Visible = False
            Else
                NoRegs_FacturaEmails.Visible = True
            End If
            grFacturaEmails.DataSource = dt
            grFacturaEmails.DataBind()
        Catch ex As Exception
            MuestraMensaje("Error al cargar los envíos de la Factura por email.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub
    Private Sub Carga_Portes_Factura(ByVal Inicial As Boolean)
        If Inicial = True Then
            dtPortesFactura = CapaDatos.Get_Portes_Factura(AUTOFAC)
            Dim col As DataColumn
            col = New DataColumn("ESTADO", GetType(String))
            dtPortesFactura.Columns.Add(col)

            Dim fepago As String
            Dim estado As String
            Dim cadena As String
            For i = 0 To dtPortesFactura.Rows.Count - 1
                estado = "NO"
                fepago = "" & dtPortesFactura.Rows(i).Item("FEPAGO")
                If fepago <> "" Then estado = "SI"
                dtPortesFactura.Rows(i).Item("ESTADO") = estado

                cadena = "" & dtPortesFactura.Rows(i).Item("DESTINO")
                If cadena <> "" Then
                    dtPortesFactura.Rows(i).Item("DESTINO") = "" & dtPortesFactura.Rows(i).Item("DESTINO").replace(vbCrLf, "<br/>")
                End If
                cadena = "" & dtPortesFactura.Rows(i).Item("DESIGNACION")
                If cadena <> "" Then
                    dtPortesFactura.Rows(i).Item("DESIGNACION") = "" & dtPortesFactura.Rows(i).Item("DESIGNACION").replace(vbCrLf, "<br/>")
                End If
            Next
            Session("dtPortesFactura") = dtPortesFactura
            grPortesFactura.DataSource = dtPortesFactura
            grPortesFactura.DataBind()

            Carga_Cobros_Factura()
            Carga_Factura_Emails()

        Else
            grPortesFactura.DataSource = Session("dtPortesFactura")
            grPortesFactura.DataBind()
        End If

    End Sub
    Private Sub Carga_Portes_Cliente()
        Dim i As Long
        Dim j As Long
        Dim cadena As String = String.Empty
        NoRegs_Datos.Visible = False
        dtPortesSeleccionar = New DataTable
        Session("dtPortesSeleccionar") = dtPortesSeleccionar

        If txtCodCli.Text = "" Then
            txtCliente.Text = ""
        Else
            Dim MiTabla As DataTable = New DataTable
            Dim swerror As String = String.Empty

            Try
                MiTabla = CapaDatos.Get_Portes_Cliente_Factura(txtCodCli.Text, ddlTipoPorte.SelectedValue, txtHastaFechaPortes.Text, txtMatricula.Text, ddlAgencias.SelectedValue)
                If MiTabla.Rows.Count > 0 Then
                    If MiTabla.Rows.Count = 0 Then
                        NoRegs_Datos.Visible = True
                        MuestraMensaje("No hay Portes pendientes facturar del Cliente indicado del Tipo indicado.", 1, "ERROR")
                    Else
                        Dim totalventa As Double = 0

                        Dim col As DataColumn
                        col = New DataColumn("ESTADO", GetType(String))
                        MiTabla.Columns.Add(col)

                        Dim fepago As String
                        Dim estado As String
                        For i = 0 To MiTabla.Rows.Count - 1
                            estado = "NO"
                            fepago = "" & MiTabla.Rows(i).Item("FEPAGO")
                            If fepago <> "" Then estado = "SI"
                            MiTabla.Rows(i).Item("ESTADO") = estado

                            cadena = "" & MiTabla.Rows(i).Item("DESTINO")
                            If cadena <> "" Then
                                MiTabla.Rows(i).Item("DESTINO") = "" & MiTabla.Rows(i).Item("DESTINO").replace(vbCrLf, "<br/>")
                            End If
                            cadena = "" & MiTabla.Rows(i).Item("DESIGNACION")
                            If cadena <> "" Then
                                MiTabla.Rows(i).Item("DESIGNACION") = "" & MiTabla.Rows(i).Item("DESIGNACION").replace(vbCrLf, "<br/>")
                            End If
                            totalventa += MiTabla.Rows(i).Item("VENTA")
                        Next

                        dtPortesFactura = Session("dtPortesFactura")
                        If Not dtPortesFactura Is Nothing Then
                            Dim cu As Long = dtPortesFactura.Rows.Count
                            For i = 0 To cu - 1
                                Dim existe As Boolean = False
                                For j = 0 To MiTabla.Rows.Count - 1
                                    If MiTabla.Rows(j).Item("AUTOPORTE") = dtPortesFactura.Rows(i).Item("AUTOPORTE") Then
                                        MiTabla.Rows(j).Delete()
                                        Exit For
                                    End If
                                Next
                            Next
                        End If
                        lblTotalVenta.Text = "TOTAL Venta: " & FormatNumber(totalventa, 2) & " €"
                        lblTotalRows_Datos.Text = FormatNumber(MiTabla.Rows.Count, 0) & " portes seleccionados."

                        'Session("dtPortesFactura") = MiTabla
                    End If
                End If
            Catch ex As Exception
                MuestraMensaje(ex.Message, 1, "ERROR")
            End Try

            dtPortesSeleccionar = MiTabla
            Session("dtPortesSeleccionar") = dtPortesSeleccionar
            ActualizaPortesFactura()

        End If
        'UPCODCLI.Update()
        UP_Filtros_Portes.Update()
        'UPanelSelPortes.Update()
    End Sub
    Private Sub grSelPortes_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grSelPortes.RowDataBound
        Dim cadena As String = String.Empty
        Dim valor As Double
        Try
            If e.Row.RowType = DataControlRowType.DataRow Then
                Dim hdnPAGADO As HiddenField = DirectCast(e.Row.FindControl("hdnPAGADO"), HiddenField)
                Dim lblNumpor As Label = DirectCast(e.Row.FindControl("lblNumpor"), Label)
                If hdnPAGADO.Value = "NO" Then
                    lblNumpor.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FF0000")
                    lblNumpor.ToolTip = "Porte NO Pagado"
                Else
                    lblNumpor.ForeColor = System.Drawing.ColorTranslator.FromHtml("#4FB54F")
                    lblNumpor.ToolTip = "Porte PAGADO"
                End If

                Dim lblVENTA As Label = DirectCast(e.Row.FindControl("lblVENTA"), Label)
                cadena = lblVENTA.Text
                cadena = cadena.Replace(".", "")
                cadena = cadena.Replace(",", ".")
                valor = CDbl(cadena)
                lblVENTA.Text = FormatNumber(valor, 2, TriState.UseDefault, TriState.False, TriState.True)

                If txtFecCobro.Text.Trim() <> "" Then
                    Dim btnAdd_Porte2 As LinkButton = DirectCast(e.Row.FindControl("btnAdd_Porte2"), LinkButton)
                    btnAdd_Porte2.Visible = False
                End If
            End If
        Catch ex As Exception
            MuestraMensaje("Error al cargar los Portes del Cliente.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub

    Private Sub grPortesFactura_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grPortesFactura.RowDataBound
        Dim cadena As String = String.Empty
        Dim valor As Double
        Try
            If e.Row.RowType = DataControlRowType.DataRow Then
                Dim hdnPAGADO As HiddenField = DirectCast(e.Row.FindControl("hdnPAGADO"), HiddenField)
                Dim lblNumpor As Label = DirectCast(e.Row.FindControl("lblNumpor"), Label)
                If hdnPAGADO.Value = "NO" Then
                    lblNumpor.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FF0000")
                    lblNumpor.ToolTip = "Porte NO Pagado"
                Else
                    lblNumpor.ForeColor = System.Drawing.ColorTranslator.FromHtml("#4FB54F")
                    lblNumpor.ToolTip = "Porte PAGADO"
                End If

                Dim lblVENTA As Label = DirectCast(e.Row.FindControl("lblVENTA"), Label)
                cadena = lblVENTA.Text
                cadena = cadena.Replace(".", "")
                cadena = cadena.Replace(",", ".")
                valor = CDbl(cadena)
                lblVENTA.Text = FormatNumber(valor, 2, TriState.UseDefault, TriState.False, TriState.True)

                If txtFecCobro.Text.Trim() <> "" Then
                    Dim btnDelete_Porte As LinkButton = DirectCast(e.Row.FindControl("btnDelete_Porte"), LinkButton)
                    btnDelete_Porte.Visible = False
                End If
            End If
        Catch ex As Exception
            MuestraMensaje("Error al cargar los Portes del Cliente.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub

    Private Sub grCobrosFactura_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grCobrosFactura.RowDataBound
        Dim cadena As String = String.Empty
        Dim valor As Double
        Try
            If e.Row.RowType = DataControlRowType.DataRow Then
                Dim lblCOBRO As Label = DirectCast(e.Row.FindControl("lblCOBRO"), Label)
                cadena = lblCOBRO.Text
                cadena = cadena.Replace(".", "")
                cadena = cadena.Replace(",", ".")
                valor = CDbl(cadena)
                lblCOBRO.Text = FormatNumber(valor, 2, TriState.UseDefault, TriState.False, TriState.True)

                If txtFecCobro.Text.Trim() <> "" Then
                    Dim btnModCobroFactura As LinkButton = DirectCast(e.Row.FindControl("btnModCobroFactura"), LinkButton)
                    btnModCobroFactura.Visible = False

                    Dim btnDeleteCobroFactura As LinkButton = DirectCast(e.Row.FindControl("btnDeleteCobroFactura"), LinkButton)
                    btnDeleteCobroFactura.Visible = False
                End If
            End If

        Catch ex As Exception
            MuestraMensaje("Error al cargar los Portes del Cliente.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub

    Private Sub grFacturaEmails_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grFacturaEmails.RowDataBound
        Try
            If e.Row.RowType = DataControlRowType.DataRow Then
                If txtFecCobro.Text.Trim() <> "" Then
                    Dim btnDelete_FacturaEmail As LinkButton = DirectCast(e.Row.FindControl("btnDelete_FacturaEmail"), LinkButton)
                    btnDelete_FacturaEmail.Visible = False
                End If
            End If
        Catch ex As Exception
            MuestraMensaje("Error al cargar los Portes del Cliente.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub
    'Private Sub grSelPortes_RowCreated(sender As Object, e As GridViewRowEventArgs) Handles grSelPortes.RowCreated
    '    Try
    '        Dim cadena As String = String.Empty
    '        If e.Row.RowType = DataControlRowType.DataRow Then
    '            'Dim rd As HtmlInputRadioButton = e.Row.FindControl("rd_DirCarga_id")
    '            'rd.Name = "rd_GDirCarga"

    '            'UPanelDirCarga.Update()
    '            'UPanelSelPortes.Update()
    '        End If
    '    Catch ex As Exception
    '        MuestraMensaje("Error al cargar las direcciones carga del Cliente.<br/>" & ex.Message, 1, "ERROR")
    '    End Try
    'End Sub
#End Region

    Private Sub ActualizaPortesFactura()
        Dim totalventa As Double = 0
        Try
            dtPortesSeleccionar = Session("dtPortesSeleccionar")
            dtPortesFactura = Session("dtPortesFactura")

            If Not dtPortesSeleccionar Is Nothing Then
                For i = 0 To dtPortesSeleccionar.Rows.Count - 1
                    totalventa += dtPortesSeleccionar.Rows(i).Item("VENTA")
                Next
                lblTotalVenta.Text = "TOTAL Venta: " & FormatNumber(totalventa, 2) & " €"
                lblTotalRows_Datos.Text = FormatNumber(dtPortesSeleccionar.Rows.Count, 0) & " portes seleccionados."

                If dtPortesSeleccionar.Rows.Count > 0 Then
                    NoRegs_Datos.Visible = False
                Else
                    NoRegs_Datos.Visible = True
                End If

                grSelPortes.DataSource = dtPortesSeleccionar
                grSelPortes.DataBind()
            End If

            If Not dtPortesFactura Is Nothing Then
                totalventa = 0
                For i = 0 To dtPortesFactura.Rows.Count - 1
                    totalventa += dtPortesFactura.Rows(i).Item("VENTA")
                Next
                lblTotalVenta_Factura.Text = "TOTAL Venta: " & FormatNumber(totalventa, 2) & " €"
                lblTotalRows_PortesFactura.Text = FormatNumber(dtPortesFactura.Rows.Count, 0) & " portes en Factura."

                If dtPortesFactura.Rows.Count > 0 Then
                    NoRegs_Datos_Portes.Visible = False
                Else
                    NoRegs_Datos_Portes.Visible = True
                End If

                grPortesFactura.DataSource = dtPortesFactura
                grPortesFactura.DataBind()
            End If

            Actualiza_Datos_Economicos()

        Catch ex As Exception
            MuestraMensaje("Error al actualizar los Portes incluidos en la factura o los Cálculos de la Factura.<br/>" & ex.Message, 1, "ERROR")
        End Try

        UP_Filtros_Portes.Update()
        UP_Portes_Factura.Update()

        UP_Datos_Economicos.Update()
    End Sub
    Private Sub Actualiza_Datos_Economicos()
        Try
            dtPortesFactura = Session("dtPortesFactura")
            Dim TotalCompra As Double = 0
            Dim TotalVenta As Double = 0
            Dim TotalFactura As Double = 0
            Dim recargo As Double = 0 : Dim ImpRecargo As Double = 0
            Dim descuento As Double = 0 : Dim ImpDescuento As Double = 0
            Dim iva As Double = 0 : Dim ImpIVA As Double = 0
            Dim TotalCobrado As Double = 0
            Dim TotalPendienteCobro As Double = 0
            Dim i As Long
            If Not dtPortesFactura Is Nothing Then
                Dim cu As Long = dtPortesFactura.Rows.Count
                Dim cadena As String = String.Empty
                Dim valor As Double = 0
                If cu > 0 Then
                    For i = 0 To cu - 1
                        cadena = "" & dtPortesFactura.Rows(i).Item("COMPRA")
                        If cadena <> "" Then
                            valor = CDbl(cadena)
                            TotalCompra += valor
                        End If
                        cadena = "" & dtPortesFactura.Rows(i).Item("VENTA")
                        If cadena <> "" Then
                            valor = CDbl(cadena)
                            TotalVenta += valor
                        End If
                    Next

                    If chkRecargo.Checked = True Then
                        cadena = Trim(txtRecargo.Text)
                        If cadena <> "" Then
                            cadena.Replace(".", "")
                            cadena.Replace(",", ".")
                            valor = CDbl(cadena)
                            ImpRecargo = TotalVenta * valor / 100
                        End If
                    End If

                    If chkDescuento.Checked = True Then
                        cadena = Trim(txtDescuento.Text)
                        If cadena <> "" Then
                            cadena.Replace(".", "")
                            cadena.Replace(",", ".")
                            valor = CDbl(cadena)
                            ImpDescuento = TotalVenta * valor / 100
                        End If
                    End If

                    If chkIVA.Checked = True Then
                        cadena = Trim(txtIVA.Text)
                        If cadena <> "" Then
                            cadena.Replace(".", "")
                            cadena.Replace(",", ".")
                            valor = CDbl(cadena)
                            ImpIVA = TotalVenta * valor / 100
                        End If
                    End If
                End If
            End If

            TotalFactura = TotalVenta + ImpRecargo - ImpDescuento + ImpIVA

            txtCompra.Value = FormatNumber(TotalCompra, 2, TriState.UseDefault, TriState.False, TriState.True)
            txtVenta.Text = FormatNumber(TotalVenta, 2, TriState.UseDefault, TriState.False, TriState.True)

            'txtRecargo.Text = FormatNumber(recargo, 2, TriState.UseDefault, TriState.False, TriState.True)
            txtImpRecargo.Text = FormatNumber(ImpRecargo, 2, TriState.UseDefault, TriState.False, TriState.True)

            'txtDescuento.Text = FormatNumber(descuento, 2, TriState.UseDefault, TriState.False, TriState.True)
            txtImpDescuento.Text = FormatNumber(ImpDescuento, 2, TriState.UseDefault, TriState.False, TriState.True)

            'txtIVA.Text = FormatNumber(iva, 2, TriState.UseDefault, TriState.False, TriState.True)
            txtImpIVA.Text = FormatNumber(ImpIVA, 2, TriState.UseDefault, TriState.False, TriState.True)

            txtTotalFactura.Text = FormatNumber(TotalFactura, 2, TriState.UseDefault, TriState.False, TriState.True)


            If Not Session("dtCobrosFactura") Is Nothing Then
                Dim dtCobros As DataTable = Session("dtCobrosFactura")
                Dim cu As Long = dtCobros.Rows.Count
                Dim cadena As String = String.Empty
                Dim valor As Double = 0
                If cu > 0 Then
                    For i = 0 To cu - 1
                        cadena = "" & dtCobros.Rows(i).Item("IMPORTE_COBRO")
                        If cadena <> "" Then
                            valor = CDbl(cadena)
                            TotalCobrado += valor
                        End If
                    Next
                End If
            End If
            txtTotalCobrado.Text = FormatNumber(TotalCobrado, 2, TriState.UseDefault, TriState.False, TriState.True)
            If TotalCobrado > 0 Then
                txtTotalCobrado.BackColor = System.Drawing.ColorTranslator.FromHtml("#01B101")
                txtTotalCobrado.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FFFFFF")
            Else
                txtTotalCobrado.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFFFF")
                txtTotalCobrado.ForeColor = System.Drawing.ColorTranslator.FromHtml("#000000")
            End If

            If txtFecCobro.Text.Trim() <> "" Then

            Else
                TotalPendienteCobro = TotalFactura - TotalCobrado

                If TotalPendienteCobro > 0 Then
                    txtTotalPendiente.BackColor = System.Drawing.ColorTranslator.FromHtml("#FF0000")
                    txtTotalPendiente.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FFFFFF")
                Else
                    txtTotalPendiente.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFFFFF")
                    txtTotalPendiente.ForeColor = System.Drawing.ColorTranslator.FromHtml("#000000")
                End If
            End If
            txtTotalPendiente.Text = FormatNumber(TotalPendienteCobro, 2, TriState.UseDefault, TriState.False, TriState.True)

            UPCobrosFactura.Update()
            UP_Datos_Economicos.Update()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub btnAdd_Porte_Click(sender As Object, e As CommandEventArgs) 'Handles btnAdd_Porte.Click
        Dim btnAdd_Porte1 As LinkButton = CType(sender, LinkButton) 'get clicked button
        Dim row As GridViewRow = CType(btnAdd_Porte1.NamingContainer, GridViewRow) 'get clicked button row
        Dim RecID As Integer = row.Cells(1).Text

    End Sub

    Public Sub grSelPortes_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grSelPortes.RowCommand
        'Public Sub grSelPortes_RowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        Try
            If (e.CommandName = "AddPorte") Then
                Dim autoporte As String = e.CommandArgument.ToString()
                Dim existe As Boolean = False
                If autoporte <> "" Then
                    dtPortesSeleccionar = Session("dtPortesSeleccionar")
                    dtPortesFactura = Session("dtPortesFactura")

                    If Not dtPortesSeleccionar Is Nothing Then
                        Dim cu As Long = dtPortesSeleccionar.Rows.Count
                        For i = 0 To cu - 1
                            If dtPortesSeleccionar.Rows(i).Item("AUTOPORTE").ToString() = autoporte Then
                                existe = False
                                If Not dtPortesFactura Is Nothing Then
                                    For j = 0 To dtPortesFactura.Rows.Count - 1
                                        If dtPortesFactura.Rows(j).Item("AUTOPORTE").ToString() = autoporte Then
                                            existe = True
                                            Exit For
                                        End If
                                    Next
                                Else
                                    dtPortesFactura = dtPortesSeleccionar.Clone
                                End If
                                If existe = False Then
                                    'dtPortesFactura.Rows.Add(dtPortesSeleccionar.Rows(i))
                                    dtPortesFactura.ImportRow(dtPortesSeleccionar.Rows(i))
                                    dtPortesSeleccionar.Rows(i).Delete()
                                    dtPortesSeleccionar.AcceptChanges()
                                End If
                                Exit For
                            End If
                        Next
                    End If
                    Session("dtPortesSeleccionar") = dtPortesSeleccionar
                    Session("dtPortesFactura") = dtPortesFactura
                    ActualizaPortesFactura()
                End If
            End If
        Catch ex As Exception
            MuestraMensaje("Error al añadir el Porte a la lista de Portes Factura.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub

    Public Sub grCobrosFactura_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grCobrosFactura.RowCommand
        Dim i As Long = 0
        Dim j As Long = 0
        Try
            Select Case e.CommandName
                Case "DeleteFacturaEmail"


            End Select
        Catch ex As Exception
            MuestraMensaje("Error al añadir el Porte a la lista de Portes Factura.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub
    Public Sub grFacturaEmails_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grFacturaEmails.RowCommand
        Dim i As Long = 0
        Dim j As Long = 0
        Try
            Select Case e.CommandName
                Case "ModCobroFactura"

                Case "DeleteCobroFactura"

            End Select
        Catch ex As Exception
            MuestraMensaje("Error al añadir el Porte a la lista de Portes Factura.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub
    Public Sub grPortesFactura_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grPortesFactura.RowCommand
        Dim i As Long = 0
        Dim j As Long = 0
        Try
            If (e.CommandName = "DeletePorte") Then
                Dim autoporte As String = e.CommandArgument.ToString()
                Dim existe As Boolean = False
                If autoporte <> "" Then
                    dtPortesSeleccionar = Session("dtPortesSeleccionar")
                    dtPortesFactura = Session("dtPortesFactura")

                    If Not dtPortesFactura Is Nothing Then
                        Dim cu As Long = dtPortesFactura.Rows.Count
                        For i = 0 To cu - 1
                            If dtPortesFactura.Rows(i).Item("AUTOPORTE").ToString() = autoporte Then
                                existe = False
                                If Not dtPortesSeleccionar Is Nothing Then
                                    For j = 0 To dtPortesSeleccionar.Rows.Count - 1
                                        If dtPortesSeleccionar.Rows(j).Item("AUTOPORTE").ToString() = autoporte Then
                                            existe = True
                                            Exit For
                                        End If
                                    Next
                                Else
                                    dtPortesSeleccionar = dtPortesFactura.Clone
                                End If
                                If existe = False Then
                                    'dtPortesFactura.Rows.Add(dtPortesSeleccionar.Rows(i))
                                    dtPortesSeleccionar.ImportRow(dtPortesFactura.Rows(i))
                                    dtPortesFactura.Rows(i).Delete()
                                    dtPortesFactura.AcceptChanges()

                                    Dim dtPortesSeleccionar_sort As New DataView(dtPortesSeleccionar)
                                    dtPortesSeleccionar_sort.Sort = "FECHA, NUMPOR"
                                    dtPortesSeleccionar = dtPortesSeleccionar_sort.ToTable()
                                End If
                                Exit For
                            End If
                        Next
                    End If
                    Session("dtPortesSeleccionar") = dtPortesSeleccionar
                    Session("dtPortesFactura") = dtPortesFactura
                    ActualizaPortesFactura()
                End If
            End If
        Catch ex As Exception
            MuestraMensaje("Error al añadir el Porte a la lista de Portes Factura.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub

    Private Sub btnRecalcularFactura_ServerClick(sender As Object, e As EventArgs) Handles btnRecalcularFactura.ServerClick
        Try
            Actualiza_Datos_Economicos()
        Catch ex As Exception
            MuestraMensaje("Error al añadir el Porte a la lista de Portes Factura.<br/>" & ex.Message, 1, "ERROR")
        End Try

    End Sub

    Public Sub btnCapaEnvioEmailAceptar_Click(sender As Object, e As EventArgs) Handles btnCapaEnvioEmailAceptar.Click
        Dim cadena As String = String.Empty
        Dim direccion As String = String.Empty
        If txtEmailCliente.Text = "" Then
            MuestraMensaje("No ha indicado la cuenta de email del destinatario a la que enviar la factura.", 1, "ERROR")
        Else
            Try
                NUMERO_FAC = hdnNUMFAC.Value
                Dim dtsmtp As DataTable = CapaDatos.Get_Datos_SMTP()
                If dtsmtp.Rows.Count > 0 Then
                    Dim SendFrom As MailAddress = New MailAddress(dtsmtp.Rows(0).Item("smtp_cuenta"), "AMETS - Empresa de Transportes")
                    Dim SendTo As MailAddress = New MailAddress(txtEmailCliente.Text)

                    Dim MyMessage As MailMessage = New MailMessage(SendFrom, SendTo)

                    MyMessage.Subject = "Envío de la Factura " & NUMERO_FAC

                    Dim textomensaje As String = String.Empty
                    Dim dtEmpresa As DataTable = CapaDatos.Get_Datos_Empresa()

                    textomensaje = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">"
                    textomensaje += "<HTML><HEAD><TITLE>AMETS Operador de Transportes, S.L.</TITLE>"
                    textomensaje += "<meta content = ""text/html; charset=utf-8"" http-equiv=""Content-Type""><META HTTP-EQUIV=""CACHE-CONTROL"" CONTENT=""NO-CACHE""><META HTTP-EQUIV=""refresh"" CONTENT=""15"">"
                    textomensaje += "<style type=""text/css"">.auto-style1 { height: 46px; }.verde{font-family: Verdana; font-size: 9pt; color: #00b050; }.nolink {color: #00b050; text-decoration: none;} </style>"
                    textomensaje += "</HEAD>"
                    textomensaje += "<body style=""font-size: 10pt; font-family: Verdana, Helvetica, sans-serif; color: #00b050"">"
                    textomensaje += "<table style=""width:100%; font-size:10pt; font-family: Verdana, Helvetica, sans-serif; color:#00b050"" width=""500"" cellspacing=""0"" cellpadding=""0"">"
                    textomensaje += "<tbody>"
                    textomensaje += "<tr><td><span style=""font-size:10pt; color:#000; font-family:Verdana;"">Adjunto recibe la Factura " & NUMERO_FAC & " correspondiente a los servicios prestados e indicados en la factura.<br/><br/>Reciba un cordial saludo.<br/><br/></span></td></tr>"
                    textomensaje += "<tr><td><img src=""http://www.appinternet.com/amets_trans.png"" border=""0"" alt=""Logo AMETS"" style=""display:block;width:169px; height:auto; border:0;"" width=""169"" border=""0"" /></td></tr>"
                    textomensaje += "<tr>"
                    textomensaje += "<td style=""padding:0; line-height:27px; vertical-align:top; font-family:Verdana; font-size:14pt;"" valign=""top"">"
                    textomensaje += "<strong><span style=""font-size:10pt; color:#00b050; font-family:Verdana;"">" & dtEmpresa.Rows(0).Item("RAZONSOCIAL") & "</span></strong>"
                    textomensaje += "</td>"
                    textomensaje += "</tr>"
                    textomensaje += "<tr>"
                    textomensaje += "<td style=""padding:0; line-height:18px; vertical-align:top; font-family:Verdana; font-size:10pt;"" valign=""top"">"
                    textomensaje += "<span style=""font-size:9pt; color:#00b050; font-family:Verdana;"">Dpto. administración</span>"
                    textomensaje += "</td>"
                    textomensaje += "</tr>"
                    textomensaje += "<tr><td style=""padding-top: 5px; padding-bottom: 5px; padding-left: 0; padding-right: 0; line-height: 18px; border-bottom: 1px solid #00b050; vertical-align: top;"" valign=""top"" class=""auto-style1 verde"">"
                    textomensaje += "<table style=""white-space: nowrap;vertical-align:top;margin:0px;padding:0px;"" border=""0"" nowrap><tr><td style=""white-space: nowrap;vertical-align:top;"">"
                    textomensaje += "<span class=""verde""><img alt=""location-icon"" style=""border 0; height: 14px; width: 14px"" src=""http://www.appinternet.com/font-awesome_4-7-0_map-marker.png"" width=""14"" height=""14"" border=""0"">&nbsp;&nbsp;"
                    textomensaje += "</span></td><td style=""vertical-align:top;""><span class=""verde nolink"">"
                    cadena = "" & dtEmpresa.Rows(0).Item("DIRECCION")
                    cadena = cadena.Replace(vbCrLf, "<br/>")
                    cadena = cadena.Replace("ª", "&ordf;")
                    cadena = cadena.Replace("C/", "C&#173;/")
                    textomensaje += " " & cadena & "<br />"

                    Dim poblacion As String = "" & dtEmpresa.Rows(0).Item("POBLACION")
                    direccion = poblacion
                    cadena = "" & dtEmpresa.Rows(0).Item("CODPOSTAL")
                    If cadena <> "" Then direccion += ", " & cadena
                    If cadena.Length >= 2 Then
                        cadena = CapaDatos.Get_DesProvincia(cadena.Substring(0, 2))
                        If cadena <> "" Then
                            If cadena.ToUpper() <> poblacion.ToUpper() Then
                                direccion += " - " & cadena
                            End If
                        End If
                    End If
                    textomensaje += " " & direccion
                    textomensaje += "</span></td></tr>"

                    cadena = "" & dtEmpresa.Rows(0).Item("CIF")
                    If cadena <> "" Then
                        textomensaje += "<tr><td colspan=""2""><span class=""verde"">"
                        textomensaje += "CIF: " & cadena
                        textomensaje += "</span></td></tr>"
                    End If

                    textomensaje += "</table></td></tr>"
                    textomensaje += "<tr>"
                    textomensaje += "<td style=""padding-top: 5px; padding-bottom: 0; padding-left: 0; padding-right: 0; line-height: 18px; vertical-align: top;"" valign=""top"">"
                    cadena = "" & dtEmpresa.Rows(0).Item("MOVIL")
                    If cadena <> "" Then
                        cadena = "+34 " & cadena
                        textomensaje += "<span class=""verde""><img alt=""mobile-icon"" style=""border: 0; height: 12px; width: 12px"" src=""http://www.appinternet.com/font-awesome_4-7-0_mobile.png"" width=""12"" height=""12"" border=""0"">&nbsp;&nbsp;" & cadena & "</span><br>"
                    End If
                    cadena = "" & dtEmpresa.Rows(0).Item("TELEFONO1")
                    If cadena <> "" Then
                        cadena = "+34 " & cadena
                        textomensaje += "<span class=""verde""><img alt=""phone-icon"" style=""border: 0; height: 12px; width: 12px"" src=""http://www.appinternet.com/font-awesome_4-7-0_phone.png"" width=""12"" height=""12"" border=""0"">&nbsp;&nbsp;" & cadena & "</span><br>"
                    End If
                    cadena = "" & dtEmpresa.Rows(0).Item("TELEFONO2")
                    If cadena <> "" Then
                        cadena = "+34 " & cadena
                        textomensaje += "<span class=""verde""><img alt=""phone-icon"" style=""border: 0; height: 12px; width: 12px"" src=""http://www.appinternet.com/font-awesome_4-7-0_phone.png"" width=""12"" height=""12"" border=""0"">&nbsp;&nbsp;" & cadena & "</span><br>"
                    End If
                    cadena = "" & dtEmpresa.Rows(0).Item("FAX")
                    If cadena <> "" Then
                        cadena = "+34 " & cadena
                        textomensaje += "<span class=""verde""><img alt=""phone-icon"" style=""border: 0; height: 12px; width: 12px"" src=""http://www.appinternet.com/font-awesome_4-7-0_fax.png"" width=""12"" height=""12"" border=""0"">&nbsp;&nbsp;" & cadena & "</span><br>"
                    End If
                    cadena = "" & dtEmpresa.Rows(0).Item("EMAIL")
                    If cadena <> "" Then
                        textomensaje += "<span class=""verde nolink""><img alt=""email-icon"" style=""border: 0; height: 12px; width: 12px"" src=""http://www.appinternet.com/font-awesome_4-7-0_email.png"" width=""12"" height=""12"" border=""0"">&nbsp;&nbsp;" & cadena & "</span><br>"
                    End If
                    cadena = "" & dtEmpresa.Rows(0).Item("WEB")
                    If cadena <> "" Then
                        textomensaje += "<span class=""verde nolink""><img alt=""website-icon"" style=""border: 0; height: 12px; width: 12px"" src=""http://www.appinternet.com/font-awesome_4-7-0_www.png"" width=""12"" height=""12"" border=""0"">&nbsp;&nbsp;<a href=""" & cadena & """ target=""_blank"" class=""verde nolink"">" & cadena & "</a></span>"
                    End If
                    textomensaje += "</td>"
                    textomensaje += "</tr>"
                    textomensaje += "<tr><td style=""padding-top:5px; padding-bottom:0; padding-left:0; padding-right:0; vertical-align:top;color:#00b050;"" valign=""top""></td></tr>"

                    textomensaje += "<tr><td><img width=""114"" height=""46"" id=""m_-2807576784857550522Imagen_x0020_1"" src=""http://www.appinternet.com/QAP.gif"" alt=""30344"" class=""CToWUd""></td></tr>"

                    textomensaje += "</tbody>"
                    textomensaje += "</table>"
                    textomensaje += "</BODY>"
                    textomensaje += "</HTML>"

                    MyMessage.Body = textomensaje
                    MyMessage.IsBodyHtml = True

                    Dim filename As String = "Factura_" & NUMERO_FAC.ToString().Replace("/", "-") & ".pdf"
                    Dim filepath As String = Server.MapPath("~" & "/Documentos/Facturas/") & filename
                    If File.Exists(filepath) = True Then
                        Dim attachFile As New Attachment(filepath)
                        MyMessage.Attachments.Add(attachFile)
                    End If

                    Dim smtp As New SmtpClient()
                    smtp.Host = dtsmtp.Rows(0).Item("smtp_host") '"smtp.live.com"
                    If dtsmtp.Rows(0).Item("smtp_puerto") <> "" Then
                        smtp.Port = dtsmtp.Rows(0).Item("smtp_puerto")
                    End If
                    smtp.Credentials = New System.Net.NetworkCredential(dtsmtp.Rows(0).Item("smtp_usuario"), dtsmtp.Rows(0).Item("smtp_password"))
                    smtp.EnableSsl = False
                    smtp.Send(MyMessage)

                    Dim msg As String = CapaDatos.Graba_EnvioEmail_Factura(NUMERO_FAC.ToString(), txtEmailCliente.Text)

                    MuestraMensaje("El email con la factura se ha enviado correctamente.", 3, "ENVÍO FACTURA POR EMAIL")
                Else
                    MuestraMensaje("No existen datos de configuración del serividor de envío de emails.<br/>", 1, "ERROR")
                End If
            Catch ex As Exception
                MuestraMensaje("Error al enviar el email con la factura.<br/>" & ex.Message, 1, "ERROR")
            End Try
        End If
    End Sub

    Private Sub btnGuardar_ServerClick(sender As Object, e As EventArgs) Handles btnGuardar.ServerClick
        Dim msg As String
        Try
            msg = Valida_Formulario()
            If msg <> "" Then
                MuestraMensaje("Error al Guardar la factura.<br/>Error: " & msg, 1, "ERROR")
            End If
        Catch ex As Exception
            MuestraMensaje("Error al Guardar la factura.<br/>Error: " & ex.Message, 1, "ERROR")
        End Try
    End Sub

    Private Function Valida_Formulario() As String
        Dim msg As String = String.Empty
        Try


        Catch ex As Exception
            msg = ex.Message
        End Try
        Return msg
    End Function

    Public Sub btnGuardarCobro_Click(sender As Object, e As EventArgs) Handles btnGuardarCobro.Click

        Carga_Cobros_Factura()

        UPCobrosFactura.Update()
    End Sub
    Public Sub btnAddCobro_Click(sender As Object, e As EventArgs) Handles btnAddCobro.Click
        txtImporteCobro.Text = ""
        txtFechaCobro.Text = ""
        btnAddCobro.Visible = False
        btnCancelarCobro.Visible = True
        btnGuardarCobro.Visible = True

        Dim cadena As String = String.Empty
        Dim valor As Double = 0
        Dim totalfactura As Double = 0
        Dim TotalCobrado As Double = 0
        If txtTotalFactura.Text <> "" Then
            cadena = txtTotalFactura.Text
            cadena.Replace(".", "")
            cadena.Replace(",", ".")
            totalfactura = CDbl(cadena)
            If Not Session("dtCobrosFactura") Is Nothing Then
                Dim dtCobros As DataTable = Session("dtCobrosFactura")
                Dim cu As Long = dtCobros.Rows.Count
                If cu > 0 Then
                    For i = 0 To cu - 1
                        cadena = "" & dtCobros.Rows(i).Item("IMPORTE_COBRO")
                        If cadena <> "" Then
                            valor = CDbl(cadena)
                            TotalCobrado += valor
                        End If
                    Next
                End If
            End If
            totalfactura = totalfactura - TotalCobrado
            txtImporteCobro.Text = FormatNumber(totalfactura, 2, TriState.UseDefault, TriState.False, TriState.True)
        End If

        txtFechaCobro.Text = Date.Now.ToString("dd/MM/yyyy")
        UPCobrosFactura.Update()
    End Sub
    Public Sub btnCancelarCobro_Click(sender As Object, e As EventArgs) Handles btnCancelarCobro.Click
        txtImporteCobro.Text = ""
        txtFechaCobro.Text = ""
        btnCancelarCobro.Visible = False
        btnGuardarCobro.Visible = False
        btnAddCobro.Visible = True

        UPCobrosFactura.Update()
    End Sub
End Class