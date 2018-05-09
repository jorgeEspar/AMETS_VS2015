Public Class Precio
    Inherits System.Web.UI.Page
    Private CapaDatos As New CapaDatos
    Private objComun As New Comun

    Private msg As String = String.Empty
    Private tituloMsg As String = ""
    Private TablaErrores As DataTable

    Public Precio_id As Long = 0
    Public Precio_Numpre As Long = 0
    Public Nuevo As Boolean = False
    Public Baja As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnControlJS.Value = "" ' Inicializamos los mensajes de errores
        msg = ""
        Try
            If Not IsPostBack Then
                hndBaja.Value = "0"

                If Session("DatosUser") Is Nothing Then
                    Response.Redirect("login.aspx", True)
                Else
                    If Request.QueryString("id") IsNot Nothing Then
                        If Request.QueryString("id") <> "" Then
                            Precio_id = CLng(Request.QueryString("id"))
                            hdnPrecioId.Value = Request.QueryString("id")
                        End If
                    End If
                    If Request.QueryString("P") IsNot Nothing Then
                        If Request.QueryString("P") <> "" Then
                            Precio_Numpre = CLng(Request.QueryString("P"))
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
                        'txtNumPorte.Text = numporte.ToString
                        txtFecPrecio.Text = DateTime.Now.ToString("dd/MM/yyyy")
                    Else
                        If hdnPrecioId.Value <> "" Then
                            Carga_Porte(hdnPrecioId.Value)
                        End If
                        If Baja = True Then
                            hndBaja.Value = "1"
                            Deshabilitar_Controles()
                        End If
                    End If
                End If

                If Nuevo = True Then
                    lblTituloPag.InnerText = "NUEVO PRECIO"
                Else
                    If Baja = True Then
                        lblTituloPag.InnerText = "BAJA PRECIO [" & Precio_Numpre.ToString() & "]"
                    Else
                        lblTituloPag.InnerText = "MODIFICACIÓN PRECIO [" & Precio_Numpre.ToString() & "]"
                    End If
                End If
            End If
        Catch ex As Exception
            MuestraMensaje("Error: " & ex.Message.ToString(), 1, "ERROR")
        End Try
    End Sub

#Region "Funciones varias"
    Private Sub Carga_Combos()
        Dim dt As DataTable
        Dim msgpagina As String = ""
        Dim items1 As New ListItem
        items1.Text = "TODAS"
        items1.Value = ""
        ddlOrigen.Items.Add(items1)
        ddlDestino.Items.Add(items1)
        ddlTipocam.Items.Add(items1)
        ddlVolumen.Items.Add(items1)

        Try
            dt = CapaDatos.Get_Origen("", "")
            If Not dt Is Nothing Then
                If dt.Rows.Count > 0 Then
                    For Each dr As DataRow In dt.Rows
                        Dim items2 As New ListItem
                        items2.Text = dr.Item("DES_ORIGEN")
                        items2.Value = dr.Item("COD_ORIGEN")
                        ddlOrigen.Items.Add(items2)
                    Next
                End If
                ddlOrigen.SelectedIndex = 0
            End If

            dt = CapaDatos.Get_Destino("", "")
            If Not dt Is Nothing Then
                If dt.Rows.Count > 0 Then
                    For Each dr As DataRow In dt.Rows
                        Dim items2 As New ListItem
                        items2.Text = dr.Item("DES_DESTINO")
                        items2.Value = dr.Item("COD_DESTINO")
                        ddlDestino.Items.Add(items2)
                    Next
                End If
                ddlDestino.SelectedIndex = 0
            End If

            dt = CapaDatos.Get_Tipocami("", "")
            If Not dt Is Nothing Then
                If dt.Rows.Count > 0 Then
                    For Each dr As DataRow In dt.Rows
                        Dim items2 As New ListItem
                        items2.Text = dr.Item("DESCRIPCION")
                        items2.Value = dr.Item("CODIGO")
                        ddlTipocam.Items.Add(items2)
                    Next
                End If
                ddlTipocam.SelectedIndex = 0
            End If

            dt = CapaDatos.Get_volumen("", "")
            If Not dt Is Nothing Then
                If dt.Rows.Count > 0 Then
                    For Each dr As DataRow In dt.Rows
                        Dim items2 As New ListItem
                        items2.Text = dr.Item("DES_VOLUMEN")
                        items2.Value = dr.Item("COD_VOLUMEN")
                        ddlVolumen.Items.Add(items2)
                    Next
                End If
                ddlVolumen.SelectedIndex = 0
            End If

        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        End Try
    End Sub

    Private Sub Deshabilitar_Controles()
        txtFecPrecio.Enabled = False
        txtTns.Disabled = True
        txtCodCli.Enabled = False
        lbldeleteprescriptor.Visible = False
        lblicobuscadorPrescriptor.Visible = False

        txtCompra.Disabled = True
        txtVenta.Disabled = True
        txtSegundaDescarga.Disabled = True

        txtMercancia.ReadOnly = True
        ddlTipocam.Enabled = False
        ddlVolumen.Enabled = False

        ddlOrigen.Enabled = False
        txtDetalleOrigen.ReadOnly = True
        ddlDestino.Enabled = False
        txtDetalleDestino.ReadOnly = True
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
    Private Sub Carga_Porte(ByVal numprecio As Long)
        Dim dt As DataTable
        Dim cadena As String
        Dim fecha As String = String.Empty
        hndAlta.Value = "0"

        Try
            dt = CapaDatos.Get_Precio(numprecio)
            If dt.Rows.Count > 0 Then
                hdnPrecioId.Value = dt.Rows(0).Item("COD_PRECIO")
                cadena = "" & dt.Rows(0).Item("PRE_FECHA")
                txtFecPrecio.Text = cadena
                hdnClienteId.Value = dt.Rows(0).Item("COD_PRE_CLI")
                txtCodCli.Text = dt.Rows(0).Item("COD_PRE_CLI")
                txtCliente.Text = dt.Rows(0).Item("CLINOM")
                txtTns.Value = "" & dt.Rows(0).Item("PRE_TNS").ToString()

                Dim compra As Double = 0
                Dim venta As Double = 0
                cadena = "" & dt.Rows(0).Item("PRE_COMPRA").ToString()
                If cadena <> "" Then
                    compra = CDbl(cadena)
                    txtCompra.Value = FormatNumber(cadena, 2)
                End If
                cadena = "" & dt.Rows(0).Item("PRE_VENTA").ToString()
                If cadena <> "" Then
                    venta = CDbl(cadena)
                    txtVenta.Value = FormatNumber(cadena, 2)
                End If
                cadena = "" & dt.Rows(0).Item("PRE_2DESCARGA").ToString()
                If cadena <> "" Then
                    venta = CDbl(cadena)
                    txtSegundaDescarga.Value = FormatNumber(cadena, 2)
                End If

                txtMercancia.Text = "" & dt.Rows(0).Item("PRE_MERCANCIA").ToString()
                cadena = "" & dt.Rows(0).Item("PRE_TIPOCAM").ToString()
                If cadena <> "" Then
                    ddlTipocam.SelectedValue = cadena
                End If
                cadena = "" & dt.Rows(0).Item("PRE_VOLUMEN").ToString()
                If cadena <> "" Then
                    ddlVolumen.SelectedValue = cadena
                End If

                cadena = "" & dt.Rows(0).Item("PRE_ORIGEN").ToString()
                If cadena <> "" Then
                    ddlOrigen.SelectedValue = cadena
                End If
                txtDetalleOrigen.Text = "" & dt.Rows(0).Item("DETALLE_ORIGEN")
                cadena = "" & dt.Rows(0).Item("PRE_DESTINO").ToString()
                If cadena <> "" Then
                    ddlDestino.SelectedValue = cadena
                End If
                txtDetalleDestino.Text = "" & dt.Rows(0).Item("DETALLE_DESTINO").ToString()
            Else
                MuestraMensaje("El Precio Nº " & numprecio.ToString() & " no se ha encontrado.", 1, "ERROR")
            End If
        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        End Try
    End Sub

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

                    End If
                End If
            Catch ex As Exception
                MuestraMensaje(ex.Message, 1, "ERROR")
            End Try
        End If
    End Sub

End Class