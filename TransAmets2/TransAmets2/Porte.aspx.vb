Public Class Porte
    Inherits System.Web.UI.Page
    Private CapaDatos As New CapaDatos
    Private objComun As New Comun

    Private msg As String = String.Empty
    Private tituloMsg As String = ""
    Private TablaErrores As DataTable

    Public Porte_id As Long = 0
    Public Porte_Numpor As Long = 0
    Public Nuevo As Boolean = False
    Public Baja As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnControlJS.Value = "" ' Inicializamos los mensajes de errores
        msg = ""
        Try
            If Not IsPostBack Then
                hndBaja.Value = "0"
                cajaEstado.Visible = False

                If Session("DatosUser") Is Nothing Then
                    Response.Redirect("login.aspx", True)
                Else
                    If Request.QueryString("id") IsNot Nothing Then
                        If Request.QueryString("id") <> "" Then
                            Porte_id = CLng(Request.QueryString("id"))
                            hdnPorteId.Value = Request.QueryString("id")
                        End If
                    End If
                    If Request.QueryString("P") IsNot Nothing Then
                        If Request.QueryString("P") <> "" Then
                            Porte_Numpor = CLng(Request.QueryString("P"))
                        End If
                    End If
                    If Request.QueryString("N") IsNot Nothing Then
                        If Request.QueryString("N") = "S" Then Nuevo = True
                        If Request.QueryString("B") = "S" Then Baja = True
                    End If

                    Carga_Combos()

                    If Nuevo = True Then
                        Dim numporte As Long = CapaDatos.Get_Num_Portes()
                        numporte += 1
                        txtNumPorte.Text = numporte.ToString
                        txtFecPorte.Text = DateTime.Now.ToString("dd/MM/yyyy")
                    Else
                        If hdnPorteId.Value <> "" Then
                            Carga_Porte(hdnPorteId.Value)
                            cajaEstado.Visible = True
                        End If
                        If Baja = True Then
                            hndBaja.Value = "1"
                            Deshabilitar_Controles()
                        End If
                    End If
                End If

                If Nuevo = True Then
                    lblTituloPag.InnerText = "NUEVO PORTE"
                Else
                    If Baja = True Then
                        lblTituloPag.InnerText = "BAJA PORTE [" & Porte_Numpor.ToString() & "]"
                    Else
                        lblTituloPag.InnerText = "MODIFICACIÓN PORTE [" & Porte_Numpor.ToString() & "]"
                    End If
                End If
            End If
        Catch ex As Exception
            MuestraMensaje("Error: " & ex.Message.ToString(), 1, "ERROR")
        End Try
    End Sub
    Private Sub Deshabilitar_Controles()
        txtFecPorte.Enabled = False
        txtFecEntrega.Enabled = False
        btnBtnBusPrecios.Visible = False
        txtTns.Disabled = True
        ddlVolumen.Enabled = False
        txtCompra.Disabled = True
        txtVenta.Disabled = True

        txtCodCli.Enabled = False
        lbldeleteprescriptor.Visible = False
        lblicobuscadorPrescriptor.Visible = False
        lblicoAddCliente.Visible = False
        txtDircargaLibre.ReadOnly = True
        btnAdd_Agenda.Visible = False

        txtMatricula.ReadOnly = True
        lblDeleteMatricula.Visible = False
        lblicobuscadorMatricula.Visible = False
        lblicoAddMatricula.Visible = False
        ddlAgencias.Enabled = False

        txtDetalle.ReadOnly = True
        txtMercancia.ReadOnly = True
        txtDestino.ReadOnly = True
        txtDetalleDestino.ReadOnly = True
        txtObservaciones.ReadOnly = True
        txtIncidencias.ReadOnly = True
        txtLineasFactura.ReadOnly = True

        txtSuplidos.ReadOnly = True
        txtImporteSuplido.Disabled = True
        ddlIvaSuplido.Enabled = False

        If gcDirCarga.Rows.Count > 0 Then
            For Each gcDirCarga1 As GridViewRow In gcDirCarga.Rows
                Dim rd As RadioButton = gcDirCarga1.FindControl("rd_DirCarga_id")
                rd.Enabled = False
            Next
        End If

    End Sub
    Private Sub Carga_Porte(ByVal numporte As Long)
        Dim dt As DataTable
        Dim cadena As String
        Dim fechacobro As String = String.Empty
        Dim fechapago As String = String.Empty
        Dim factura As String = String.Empty

        hndAlta.Value = "0"

        Try
            dt = CapaDatos.Get_Datos_Porte(numporte)
            If dt.Rows.Count > 0 Then
                txtNumPorte.Text = dt.Rows(0).Item("NUMPOR")
                cadena = dt.Rows(0).Item("FECHA")
                txtFecPorte.Text = cadena
                hdnClienteId.Value = dt.Rows(0).Item("CODCLI")
                hndDirCliente_id.Value = dt.Rows(0).Item("CODDIRCAR")
                hndMatricula.Value = dt.Rows(0).Item("MATRICULA")

                cadena = "" & dt.Rows(0).Item("FECHA_ENTREGA").ToString()
                txtFecEntrega.Text = cadena
                txtTns.Value = "" & dt.Rows(0).Item("PESO").ToString()

                cadena = "" & dt.Rows(0).Item("VOLUMEN").ToString()
                If cadena <> "" Then
                    ddlVolumen.SelectedValue = cadena
                End If
                Dim compra As Double = 0
                Dim venta As Double = 0
                cadena = "" & dt.Rows(0).Item("COMPRA").ToString()
                If cadena <> "" Then
                    compra = CDbl(cadena)
                    txtCompra.Value = FormatNumber(cadena, 2)
                End If
                cadena = "" & dt.Rows(0).Item("VENTA").ToString()
                If cadena <> "" Then
                    venta = CDbl(cadena)
                    txtVenta.Value = FormatNumber(cadena, 2)
                End If
                Dim saldo As Double = venta - compra
                txtSaldo.Value = FormatNumber(saldo, 2)

                txtCodCli.Text = dt.Rows(0).Item("CODCLI").ToString()
                txtCliente.Text = "" & dt.Rows(0).Item("CLINOM").ToString()
                txtDircargaLibre.Text = "" & dt.Rows(0).Item("DIRCARGA").ToString()

                Carga_Dir_Cliente(txtCodCli.Text)
                If gcDirCarga.Rows.Count > 0 Then
                    If dt.Rows(0).Item("CODDIRCAR").ToString() <> "" Then
                        For i = 0 To gcDirCarga.Rows.Count - 1
                            Dim dircargaid As HiddenField = gcDirCarga.Rows(i).FindControl("hnd_Dircarga_id")
                            If dircargaid.Value = dt.Rows(0).Item("CODDIRCAR").ToString() Then
                                Dim rd As RadioButton = gcDirCarga.Rows(i).FindControl("rd_DirCarga_id")
                                rd.Checked = True
                                UPanelDirCarga.Update()
                                UP_Cliente.Update()
                                Exit For
                            End If
                        Next
                    End If
                End If

                txtMatricula.Text = "" & dt.Rows(0).Item("MATRICULA").ToString()
                hndCodTransportista.Value = "" & dt.Rows(0).Item("MATRICULA").ToString()
                txtConductor.Text = "" & dt.Rows(0).Item("CONDUCTOR").ToString()
                txtPropietario.Text = "" & dt.Rows(0).Item("PROPIETARIO").ToString()
                cadena = "" & dt.Rows(0).Item("CODP_AGENCIA").ToString()
                If cadena <> "" Then
                    If ddlAgencias.Items.Count > 0 Then
                        For i = 0 To ddlAgencias.Items.Count - 1
                            If ddlAgencias.Items(i).Value = cadena Then
                                ddlAgencias.Items(i).Selected = True
                                Exit For
                            End If
                        Next
                    End If
                End If

                txtDetalle.Text = "" & dt.Rows(0).Item("DETALLE_TRANS").ToString()
                txtMercancia.Text = "" & dt.Rows(0).Item("MERCANCIA").ToString()
                txtDestino.Text = "" & dt.Rows(0).Item("DESTINO").ToString()
                txtDetalleDestino.Text = "" & dt.Rows(0).Item("DETALLE_DESTINO").ToString()
                txtObservaciones.Text = "" & dt.Rows(0).Item("DESIGNACION").ToString()
                txtIncidencias.Text = "" & dt.Rows(0).Item("INCIDENCIAS").ToString()
                txtLineasFactura.Text = "" & dt.Rows(0).Item("LINEASFACTU").ToString()

                txtSuplidos.Text = "" & dt.Rows(0).Item("SUPLIDOS").ToString()
                cadena = "" & dt.Rows(0).Item("IMPORTESUP").ToString()
                If cadena <> "" Then
                    txtImporteSuplido.Value = FormatNumber(cadena, 2)
                End If
                cadena = "" & dt.Rows(0).Item("IVASUP").ToString()
                If cadena = "" Then
                    ddlIvaSuplido.SelectedValue = cadena
                End If

                cadena = "" & dt.Rows(0).Item("FEPAGO").ToString()
                txtFechaPago.Text = cadena
                txtNumRecibo.Text = "" & dt.Rows(0).Item("RECIBO").ToString()
                cadena = "" & dt.Rows(0).Item("FECOBRO").ToString()
                txtFechaCobro.Text = cadena
                txtNumFactura.Text = "" & dt.Rows(0).Item("FACTURA").ToString()

                factura = "" & dt.Rows(0).Item("FACTURA").ToString()
                fechapago = "" & dt.Rows(0).Item("FEPAGO").ToString()
                fechacobro = "" & dt.Rows(0).Item("FECOBRO").ToString()
                If factura <> "" Then
                    dFacturado.Attributes.Add("style", "background-color:#00BC00")
                Else
                    dFacturado.Attributes.Add("style", "background-color:#FF0000")
                End If

                If fechacobro <> "" Then
                    dCobrado.Attributes.Add("style", "background-color:#00BC00")
                Else
                    dCobrado.Attributes.Add("style", "background-color:#FF0000")
                End If

                If fechapago <> "" Then
                    dPagado.Attributes.Add("style", "background-color:#00BC00")
                Else
                    dPagado.Attributes.Add("style", "background-color:#FF0000")
                End If
            Else
                MuestraMensaje("El porte Nº " & numporte.ToString() & " no se ha encontrado.", 1, "ERROR")
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
            'Dim itemsA1 As New ListItem
            'itemsA1.Text = "Seleccione"
            'itemsA1.Value = ""
            'ddlOrigen.Items.Add(itemsA1)
            dt = CapaDatos.Get_Origen("", "")
            If Not dt Is Nothing Then
                If dt.Rows.Count > 0 Then
                    For Each dr As DataRow In dt.Rows
                        Dim itemsA2 As New ListItem
                        itemsA2.Text = dr.Item("DES_ORIGEN")
                        itemsA2.Value = dr.Item("COD_ORIGEN")
                        ddlOrigen.Items.Add(itemsA2)
                    Next
                End If
                ddlOrigen.SelectedIndex = 0
            End If
            Dim itemsA3 As New ListItem
            itemsA3.Text = "Seleccione"
            itemsA3.Value = ""
            ddlDestino.Items.Add(itemsA3)
            dt = CapaDatos.Get_Destino("", "")
            If Not dt Is Nothing Then
                If dt.Rows.Count > 0 Then
                    For Each dr As DataRow In dt.Rows
                        Dim itemsA4 As New ListItem
                        itemsA4.Text = dr.Item("DES_DESTINO")
                        itemsA4.Value = dr.Item("COD_DESTINO")
                        ddlDestino.Items.Add(itemsA4)
                    Next
                End If
                ddlDestino.SelectedIndex = 0
            End If

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

            Dim items3 As New ListItem
            items3.Text = "Seleccione"
            items3.Value = ""
            ddlVolumen.Items.Add(items3)
            dt = CapaDatos.Get_volumen("", "")
            If Not dt Is Nothing Then
                If dt.Rows.Count > 0 Then
                    For Each dr As DataRow In dt.Rows
                        Dim items4 As New ListItem
                        items4.Text = dr.Item("DES_VOLUMEN")
                        items4.Value = dr.Item("COD_VOLUMEN")
                        ddlVolumen.Items.Add(items4)
                    Next
                End If
                ddlVolumen.SelectedIndex = 0
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

#Region "Campos Clientes - txtCodCli, Buscador Cliente -> cargar Direcciones Carga Cliente"
    Private Sub txtCodCli_TextChanged(sender As Object, e As EventArgs) Handles txtCodCli.TextChanged
        Carga_Dir_Cliente(txtCodCli.Text)
    End Sub

    Private Sub Carga_Dir_Cliente(ByVal codcli As Long)
        If txtCodCli.Text = "" Then
            txtCliente.Text = ""
        Else
            Dim MiTabla As DataTable = New DataTable
            Dim swerror As String = String.Empty

            Try
                MiTabla = CapaDatos.Get_Clientes(txtCodCli.Text, "", "")
                If MiTabla.Rows.Count > 0 Then
                    If MiTabla.Rows.Count > 1 Then
                        txtCliente.Text = ""
                        hndDirCliente_id.Value = ""
                        MuestraMensaje("Hay más de un Cliente con el código indicado", 1, "ERROR")
                    Else
                        txtCliente.Text = MiTabla.Rows(0).Item("CLINOM")

                        MiTabla = CapaDatos.Get_ClienteDirCarga(txtCodCli.Text)
                        gcDirCarga.DataSource = MiTabla
                        gcDirCarga.DataBind()

                    End If
                End If
            Catch ex As Exception
                MuestraMensaje(ex.Message, 1, "ERROR")
            End Try
        End If
        UP_Cliente.Update()
    End Sub
    Private Sub gcDirCarga_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gcDirCarga.RowDataBound
        Try
            Dim cadena As String = String.Empty
            If e.Row.RowType = DataControlRowType.DataRow Then

            End If
        Catch ex As Exception
            MuestraMensaje("Error al cargar las direcciones carga del Cliente.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub

    Private Sub gcDirCarga_RowCreated(sender As Object, e As GridViewRowEventArgs) Handles gcDirCarga.RowCreated
        Try
            Dim cadena As String = String.Empty
            If e.Row.RowType = DataControlRowType.DataRow Then
                'Dim rd As HtmlInputRadioButton = e.Row.FindControl("rd_DirCarga_id")
                'rd.Name = "rd_GDirCarga"

                'UPanelDirCarga.Update()
                'UP_Cliente.Update()
            End If
        Catch ex As Exception
            MuestraMensaje("Error al cargar las direcciones carga del Cliente.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub

    Public Sub rd_DirCarga_id_CheckedChanged(sender As Object, e As System.EventArgs)
        Dim rowIndex As Integer = 0
        Dim i As Long = 0
        Dim cadena As String = String.Empty
        Dim poblacion As String = String.Empty
        Dim provincia As String = String.Empty
        Try
            For Each gcDirCarga1 As GridViewRow In gcDirCarga.Rows
                Dim rd As RadioButton = gcDirCarga1.FindControl("rd_DirCarga_id")
                rd.Checked = False
            Next

            Dim rdg As RadioButton = CType(sender, RadioButton)
            Dim gvRow As GridViewRow = CType(rdg.NamingContainer, GridViewRow)
            rowIndex = gvRow.DataItemIndex
            rdg.Checked = True

            Dim dircargaid As HiddenField = gvRow.FindControl("hnd_Dircarga_id")
            hndDirCliente_id.Value = dircargaid.Value

            Dim lbl_POBLACION As HiddenField = gvRow.FindControl("lbl_POBLACION")
            poblacion = lbl_POBLACION.Value
            Dim lbl_PROVINCIA As HiddenField = gvRow.FindControl("lbl_PROVINCIA")
            provincia = lbl_PROVINCIA.Value

            For i = 0 To ddlOrigen.Items.Count - 1
                If UCase(ddlOrigen.Items(i).Text = UCase(provincia)) Then
                    ddlOrigen.SelectedIndex = i
                    Exit For
                End If
            Next
            If UCase(poblacion) <> UCase(provincia) Then
                If txtDircargaLibre.Text = "" And poblacion <> "" Then
                    txtDircargaLibre.Text = poblacion
                End If

            End If

            UPanelDirCarga.Update()
            UP_Cliente.Update()
        Catch ex As Exception
            MuestraMensaje("Error al cargar las direcciones carga del Cliente.<br/>" & ex.Message, 1, "ERROR")
        End Try
    End Sub

#End Region
End Class