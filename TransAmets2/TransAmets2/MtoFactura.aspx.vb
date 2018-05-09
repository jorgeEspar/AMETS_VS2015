Public Class MtoFactura
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
                        End If
                    End If
                    If Request.QueryString("N") IsNot Nothing Then
                        If Request.QueryString("N") = "S" Then Nuevo = True
                        If Request.QueryString("B") = "S" Then Baja = True
                    End If

                    Carga_Combos()

                    'If Nuevo = True Then
                    '    hndAlta.Value = "1"
                    '    Dim numporte As Long = CapaDatos.Get_Num_Portes()
                    '    numporte += 1
                    '    txtNumFactura.Text = numporte.ToString
                    '    txtFecFactura.Text = DateTime.Now.ToString("dd/MM/yyyy")
                    'Else
                    '    If hdnFacturaId.Value <> "" Then
                    '        Carga_Factura(hdnFacturaId.Value)
                    '    End If
                    '    If Baja = True Then
                    '        hndBaja.Value = "1"
                    '        Deshabilitar_Controles()
                    '    End If
                    'End If
                End If

                If Nuevo = True Then
                    lblTituloPag.InnerText = "NUEVA FACTURA"
                    btnBtnImprimir.Visible = False
                Else
                    If Baja = True Then
                        lblTituloPag.InnerText = "BAJA FACTURA [" & NUMERO_FAC.ToString() & "]"
                    Else
                        lblTituloPag.InnerText = "MODIFICACIÓN FACTURA [" & NUMERO_FAC.ToString() & "]"
                    End If
                End If
            End If
        Catch ex As Exception
            MuestraMensaje("Error: " & ex.Message.ToString(), 1, "ERROR")
        End Try
    End Sub

    Private Sub Deshabilitar_Controles()
        txtFecFactura.Enabled = False
        txtFecVencimiento.Enabled = False
        btnBtnImprimir.Visible = False

        txtCodCli.Enabled = False
        lbldeleteprescriptor.Visible = False
        lblicobuscadorPrescriptor.Visible = False
        ddlAgencias.Enabled = False

        txtObservaciones.ReadOnly = True

    End Sub

    Private Sub txtCodCli_TextChanged(sender As Object, e As EventArgs) Handles txtCodCli.TextChanged
        dtPortesSeleccionar = Nothing
        dtPortesFactura = Nothing
        Session("dtPortesSeleccionar") = dtPortesSeleccionar
        Session("dtPortesFactura") = dtPortesFactura

        Dim dt As DataTable
        txtCliente.Text = ""

        If txtCodCli.Text <> "" Then
            CLIENTE_FAC = CInt(txtCodCli.Text)
            dt = CapaDatos.Get_Clientes(CLIENTE_FAC.ToString, "", "")
            If dt.Rows.Count > 0 Then
                txtCliente.Text = dt.Rows(0).Item("CLINOM").replace(vbCrLf, " - ")
            End If
        Else
            CLIENTE_FAC = 0
        End If

        UPCODCLI.Update()
        UP_Filtros_Portes.Update()

        Carga_Portes_Cliente()
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

            'If Not dtPortesFactura Is Nothing Then
            '    totalventa = 0
            '    For i = 0 To dtPortesFactura.Rows.Count - 1
            '        totalventa += dtPortesFactura.Rows(i).Item("VENTA")
            '    Next
            '    lblTotalVenta_Factura.Text = "TOTAL Venta: " & FormatNumber(totalventa, 2) & " €"
            '    lblTotalRows_PortesFactura.Text = FormatNumber(dtPortesFactura.Rows.Count, 0) & " portes en Factura."

            '    If dtPortesSeleccionar.Rows.Count > 0 Then
            '        NoRegs_Datos_Portes.Visible = False
            '    Else
            '        NoRegs_Datos_Portes.Visible = True
            '    End If

            '    grPortesFactura.DataSource = dtPortesFactura
            '    grPortesFactura.DataBind()
            'End If

            ''Actualiza_Datos_Economicos()

        Catch ex As Exception
            MuestraMensaje("Error al actualizar los Portes incluidos en la factura o los Cálculos de la Factura.<br/>" & ex.Message, 1, "ERROR")
        End Try

        UP_Filtros_Portes.Update()
        'UP_Portes_Factura.Update()

        'UP_Datos_Economicos.Update()
    End Sub
    'Protected Sub grSelPortes_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grSelPortes.RowDataBound
    '    Dim cadena As String = String.Empty
    '    Dim valor As Double
    '    Try
    '        If e.Row.RowType = DataControlRowType.DataRow Then
    '            Dim hdnPAGADO As HiddenField = DirectCast(e.Row.FindControl("hdnPAGADO"), HiddenField)
    '            Dim lblNumpor As Label = DirectCast(e.Row.FindControl("lblNumpor"), Label)
    '            If hdnPAGADO.Value = "NO" Then
    '                lblNumpor.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FF0000")
    '                lblNumpor.ToolTip = "Porte NO Pagado"
    '            Else
    '                lblNumpor.ForeColor = System.Drawing.ColorTranslator.FromHtml("#4FB54F")
    '                lblNumpor.ToolTip = "Porte PAGADO"
    '            End If

    '            Dim lblVENTA As Label = DirectCast(e.Row.FindControl("lblVENTA"), Label)
    '            cadena = lblVENTA.Text
    '            cadena = cadena.Replace(".", "")
    '            cadena = cadena.Replace(",", ".")
    '            valor = CDbl(cadena)
    '            lblVENTA.Text = FormatNumber(valor, 2, TriState.UseDefault, TriState.False, TriState.True)
    '        End If
    '    Catch ex As Exception
    '        MuestraMensaje("Error al cargar los Portes del Cliente.<br/>" & ex.Message, 1, "ERROR")
    '    End Try
    'End Sub

    'Protected Sub grPortesFactura_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grPortesFactura.RowDataBound
    '    Dim cadena As String = String.Empty
    '    Dim valor As Double
    '    Try
    '        If e.Row.RowType = DataControlRowType.DataRow Then
    '            Dim hdnPAGADO As HiddenField = DirectCast(e.Row.FindControl("hdnPAGADO"), HiddenField)
    '            Dim lblNumpor As Label = DirectCast(e.Row.FindControl("lblNumpor"), Label)
    '            If hdnPAGADO.Value = "NO" Then
    '                lblNumpor.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FF0000")
    '                lblNumpor.ToolTip = "Porte NO Pagado"
    '            Else
    '                lblNumpor.ForeColor = System.Drawing.ColorTranslator.FromHtml("#4FB54F")
    '                lblNumpor.ToolTip = "Porte PAGADO"
    '            End If

    '            Dim lblVENTA As Label = DirectCast(e.Row.FindControl("lblVENTA"), Label)
    '            cadena = lblVENTA.Text
    '            cadena = cadena.Replace(".", "")
    '            cadena = cadena.Replace(",", ".")
    '            valor = CDbl(cadena)
    '            lblVENTA.Text = FormatNumber(valor, 2, TriState.UseDefault, TriState.False, TriState.True)
    '        End If
    '    Catch ex As Exception
    '        MuestraMensaje("Error al cargar los Portes del Cliente.<br/>" & ex.Message, 1, "ERROR")
    '    End Try
    'End Sub
#Region "Funciones varias"
    Private Sub Carga_Combos()
        Dim dt As DataTable
        Dim msgpagina As String = ""
        Dim items1 As New ListItem
        items1.Text = "Seleccione"
        items1.Value = ""
        ''ddlAgencias.Items.Add(items1)

        Try
            dt = CapaDatos.Get_Agencias_Trans("", "")
            If Not dt Is Nothing Then
                If dt.Rows.Count > 0 Then
                    For Each dr As DataRow In dt.Rows
                        Dim items2 As New ListItem
                        items2.Text = dr.Item("NOMBRE_COOP")
                        items2.Value = dr.Item("AUTOCOOP")
                        ''ddlAgencias.Items.Add(items2)
                    Next
                End If
                ''ddlAgencias.SelectedIndex = 0
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

    Protected Sub grSelPortes_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grSelPortes.RowCommand
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
                    'ActualizaPortesFactura()
                End If
            End If
        Catch ex As Exception
            MuestraMensaje("Error al añadir el Porte a la lista de Portes Factura.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub

    Public Sub btnAdd_Porte_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim CommandName As String = btn.CommandName
        Dim CommandArgument As String = btn.CommandArgument
    End Sub

#End Region
End Class