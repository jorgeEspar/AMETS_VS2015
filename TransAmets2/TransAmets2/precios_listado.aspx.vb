Public Class precios_listado
    Inherits System.Web.UI.Page
    Private CapaDatos As New CapaDatos
    Private objComun As New Comun

    Private pagesize As Integer = 10
    Private WSTotalrows As Integer = 100000

    Private msg As String = String.Empty
    Private tituloMsg As String = ""
    Private TablaErrores As DataTable

    Private FiltrosPrecios As New FiltrosPrecios

    Private ReadOnly Property ReturnedError() As String
        Get
            If Request.QueryString("error") IsNot Nothing Then
                Return HttpUtility.HtmlEncode(HttpUtility.UrlDecode(Request.QueryString("error").ToString)).Replace(vbCr, "<br />").Replace(vbLf, "<br />")
            Else
                Return String.Empty
            End If
        End Get
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim swbuscar_precios As Boolean = False
        hdnControlJS.Value = "" ' Inicializamos los mensajes de errores
        NoRegs_Datos.Visible = False

        msg = ""
        pagesize = grPrecios.PageSize

        If Not IsPostBack Then
            If Session("DatosUser") Is Nothing Then
                Response.Redirect("login.aspx", True)
            Else
                Dim URL As String = "Precio.aspx?id=&N=S&B=N" ' id=id del porte, N->Nuevo S/N, B-> Baja S/N
                btnNuevo.PostBackUrl = URL

                Session("SortedView") = EL_sort_field.Value
                Session("SortDirection") = EL_sort_order.Value

                NoRegs_Datos.Visible = False

                Dim auxError As String = ReturnedError
                If Not String.IsNullOrEmpty(auxError) Then
                    ClientScript.RegisterStartupScript(Me.GetType, "returnErr", String.Format("ShowWarning('Error', '{0}');",
                                        auxError.Replace(vbCrLf, "").Replace("'", "")), True)
                End If

                Carga_Combos()

                If Request.QueryString("codcli") IsNot Nothing Then ' codigo origen
                    If Request.QueryString("codcli") <> "" Then
                        swbuscar_precios = True
                        FiltrosPrecios.CodCli = CLng(Request.QueryString("codcli"))
                    End If
                End If
                If Request.QueryString("co") IsNot Nothing Then ' codigo origen
                    If Request.QueryString("co") <> "" Then
                        swbuscar_precios = True
                        FiltrosPrecios.CodOrigen = CLng(Request.QueryString("co"))
                    End If
                End If
                If Request.QueryString("ol") IsNot Nothing Then ' origen libre
                    If Request.QueryString("ol") <> "" Then
                        swbuscar_precios = True
                        FiltrosPrecios.DirCarga = Request.QueryString("ol")
                    End If
                End If
                If Request.QueryString("cd") IsNot Nothing Then ' codigo destino
                    If Request.QueryString("cd") <> "" Then
                        swbuscar_precios = True
                        FiltrosPrecios.CodDestino = CLng(Request.QueryString("cd"))
                    End If
                End If
                If Request.QueryString("dl") IsNot Nothing Then ' destino libre
                    If Request.QueryString("dl") <> "" Then
                        swbuscar_precios = True
                        FiltrosPrecios.DirDestino = Request.QueryString("dl")
                    End If
                End If
                If swbuscar_precios = True Then Session("Filtros_Precios") = Nothing

                If Session("Filtros_Precios") IsNot Nothing Or swbuscar_precios = True Then
                    If Session("Filtros_Precios") IsNot Nothing Then FiltrosPrecios = Session("Filtros_Precios")

                    If FiltrosPrecios.FechaHasta <> "" Then
                        txtFecPrecio.Text = FiltrosPrecios.FechaDesde & " - " & FiltrosPrecios.FechaHasta
                    End If
                    txtCodCli.Text = "" & FiltrosPrecios.CodCli
                    txtCliente.Text = "" & FiltrosPrecios.NombreCli
                    txtDirCarga.Text = "" & FiltrosPrecios.DirCarga
                    txtDestino.Text = "" & FiltrosPrecios.DirDestino
                    txtMercancia.Text = "" & FiltrosPrecios.Mercancia
                    txtTns.Text = "" & FiltrosPrecios.Peso
                    ddlOrigen.SelectedValue = "" & FiltrosPrecios.CodOrigen
                    ddlDestino.SelectedValue = "" & FiltrosPrecios.CodDestino
                    ddlTipocam.SelectedValue = "" & FiltrosPrecios.TipoCamion
                    ddlVolumen.SelectedValue = "" & FiltrosPrecios.Volumen

                    If swbuscar_precios = True Then
                        BuscaDescripcionCliente()
                        FiltrosPrecios.NombreCli = txtCliente.Text
                        Session("Filtros_Precios") = FiltrosPrecios
                        Carga_Portes(1)
                    Else
                        Carga_Portes(FiltrosPrecios.Pagina)
                    End If

                End If

            End If
        End If
    End Sub

    Private Sub Carga_Combos()
        Dim dt As DataTable
        Dim msgpagina As String = ""
        Dim items1 As New ListItem
        items1.Text = "TODAS"
        items1.Value = ""

        Dim itemsx2 As New ListItem
        itemsx2.Text = "TODAS"
        itemsx2.Value = ""
        Dim itemsx3 As New ListItem
        itemsx3.Text = "TODAS"
        itemsx3.Value = ""
        Dim itemsx4 As New ListItem
        itemsx4.Text = "TODAS"
        itemsx4.Value = ""

        ddlOrigen.Items.Add(items1)
        ddlDestino.Items.Add(itemsx2)
        ddlTipocam.Items.Add(itemsx3)
        ddlVolumen.Items.Add(itemsx4)

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

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        Try
            NoRegs_Datos.Visible = False

            Session("ListadoPortes") = Nothing

            grPrecios.CurrentPageIndex = 0

            If txtFecPrecio.Text <> "" Then
                If txtFecPrecio.Text.IndexOf("-") > -1 Then
                    Dim fechas As String() = txtFecPrecio.Text.Split(" - ")
                    FiltrosPrecios.FechaDesde = fechas(0)
                    FiltrosPrecios.FechaHasta = fechas(1)
                Else
                    FiltrosPrecios.FechaDesde = txtFecPrecio.Text
                    FiltrosPrecios.FechaHasta = txtFecPrecio.Text
                End If
            Else
                FiltrosPrecios.FechaDesde = ""
                FiltrosPrecios.FechaHasta = ""
            End If

            FiltrosPrecios.CodCli = txtCodCli.Text
            FiltrosPrecios.NombreCli = txtCliente.Text
            FiltrosPrecios.DirCarga = txtDirCarga.Text
            FiltrosPrecios.DirDestino = txtDestino.Text
            FiltrosPrecios.Mercancia = txtMercancia.Text
            FiltrosPrecios.Peso = txtTns.Text
            FiltrosPrecios.CodOrigen = ddlOrigen.SelectedValue
            FiltrosPrecios.CodDestino = ddlDestino.SelectedValue
            FiltrosPrecios.TipoCamion = ddlTipocam.SelectedValue
            FiltrosPrecios.Volumen = ddlVolumen.SelectedValue
            FiltrosPrecios.Pagina = 1

            Session("Filtros_Precios") = FiltrosPrecios

            FiltrosPrecios = Session("Filtros_Precios")

            Carga_Portes(1)

        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        Finally
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "asddas", "ReloadDatepicker();", True)
        End Try
    End Sub

    Private Sub Carga_Portes(ByVal NumPage As Integer)
        Dim MiTabla As DataTable = New DataTable
        Dim cadena As String

        Try
            MiTabla = CapaDatos.Get_ListadoPrecios(txtFecPrecio.Text, txtCodCli.Text, ddlOrigen.SelectedValue, txtDirCarga.Text, ddlDestino.SelectedValue, txtDestino.Text, txtMercancia.Text, txtTns.Text, ddlTipocam.SelectedValue, ddlVolumen.SelectedValue)

            grPrecios.VirtualItemCount = MiTabla.Rows.Count
            If MiTabla.Rows.Count > 0 Then
                For i = 0 To MiTabla.Rows.Count - 1
                    cadena = "" & MiTabla.Rows(i).Item("CLINOM").ToString.Trim()
                    cadena = cadena.Replace(vbCrLf, " ")
                    MiTabla.Rows(i).Item("CLINOM") = cadena
                Next
                grPrecios.CurrentPageIndex = NumPage - 1
                grPrecios.DataSource = MiTabla
                grPrecios.DataBind()
            Else
                'NoRegs_Datos.Style.Item("display") = "block"
                NoRegs_Datos.Visible = True
            End If

            Session("ListadoPortes") = MiTabla

            If MiTabla.Rows.Count > 0 Then
                NoRegs_Datos.Visible = False
                NoRegs_Datos.Style.Item("display") = "none"
                lblTotalRows_Datos.Text = "Mostrando " & (grPrecios.CurrentPageIndex * pagesize + 1) & " a " & IIf((grPrecios.CurrentPageIndex * pagesize + pagesize) < MiTabla.Rows.Count, (grPrecios.CurrentPageIndex * pagesize + pagesize), MiTabla.Rows.Count.ToString()) & " de " & MiTabla.Rows.Count.ToString() & " Portes"
                lblTotalPages_Datos.Text = " Página " & grPrecios.CurrentPageIndex + 1 & " de " & grPrecios.PageCount & ""
                TotalRows_Datos.Visible = True
                TotalPages_Datos.Visible = True
                ELsortOrder.Visible = True
                grPrecios.PagerStyle.Visible = True
                grPrecios.CurrentPageIndex = NumPage - 1
                'lblEstado.Text = "Estado Portes: " & ddlEstado.Items(ddlEstado.SelectedIndex).Text
            Else
                NoRegs_Datos.Visible = True
                NoRegs_Datos.Style.Item("display") = "block"
                grPrecios.PagerStyle.Visible = False
                ELsortOrder.Visible = False
                TotalRows_Datos.Visible = False
                TotalPages_Datos.Visible = False
                grPrecios.VirtualItemCount = 0
                grPrecios.CurrentPageIndex = 0
            End If

        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        End Try
        ScriptManager.RegisterStartupScript(Me, Me.GetType, "ScrollTop", "scrollToTop();", True)
        UP_Eligible.Update()
    End Sub
    Private Sub grPrecios_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles grPrecios.PageIndexChanged
        Dim dt As DataTable
        Dim msgpagina As String = ""
        Dim TotalPages As String = ""
        pagesize = grPrecios.PageSize

        FiltrosPrecios.Pagina = e.NewPageIndex + 1
        Session("Filtros_Precios") = FiltrosPrecios

        grPrecios.CurrentPageIndex = e.NewPageIndex
        dt = Session("ListadoPortes")
        With grPrecios
            .DataSource = dt
            .DataBind()
        End With
        Me.lblTotalPages_Datos.Text = "Página " & grPrecios.CurrentPageIndex + 1 & " de " & grPrecios.PageCount & ""
        If dt.Rows.Count > 0 Then
            msgpagina = "Mostrando " & (grPrecios.CurrentPageIndex * pagesize + 1) & " a " & IIf((grPrecios.CurrentPageIndex * pagesize + pagesize) < dt.Rows.Count, (grPrecios.CurrentPageIndex * pagesize + pagesize), dt.Rows.Count) & " de " & dt.Rows.Count.ToString() & " registros"
            TotalPages = "Página " & grPrecios.CurrentPageIndex + 1 & " de " & grPrecios.PageCount & ""
        End If
        Me.lblTotalRows_Datos.Text = msgpagina
        Me.lblTotalPages_Datos.Text = TotalPages

        ScriptManager.RegisterStartupScript(Me, Me.GetType, "ScrollTop", "scrollToTop();", True)
        UP_Eligible.Update()
    End Sub
    Protected Function SortDataTable(ByVal isPageIndexChanging As Boolean) As DataView
        Dim oDs As DataSet = Session("ListadoPortes")
        Dim pdataTable As DataTable = oDs.Tables("Valores")

        If Not pdataTable Is Nothing Then

            Dim pdataView As New DataView(pdataTable)

            If isPageIndexChanging Then
                pdataView.Sort = String.Format("{0} {1}", EL_sort_field.Value, EL_sort_order.Value)
            Else
                pdataView.Sort = String.Format("{0} {1}", EL_sort_field.Value, EL_sort_order.Value)
            End If
            Return pdataView
        Else
            Return New DataView()
        End If
    End Function

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

    Private Sub BuscaDescripcionCliente()
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
                        MuestraMensaje("Hay más de un Cliente con el código indicado", 1, "ERROR")
                    Else
                        txtCliente.Text = MiTabla.Rows(0).Item("CLINOM")
                    End If
                End If
            Catch ex As Exception
                MuestraMensaje(ex.Message, 1, "ERROR")
            End Try
        End If
        UP_Filtros.Update()
    End Sub
    Private Sub txtCodCli_TextChanged(sender As Object, e As EventArgs) Handles txtCodCli.TextChanged
        BuscaDescripcionCliente()
    End Sub

    Private Sub grPrecios_ItemDataBound(sender As Object, e As DataGridItemEventArgs) Handles grPrecios.ItemDataBound
        Dim cadena As String = String.Empty
        Try
            If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
                Dim drv As System.Data.DataRowView = DirectCast((e.Item.DataItem), System.Data.DataRowView)

                Dim hdnCOD_PRECIO As HiddenField = DirectCast(e.Item.FindControl("hdnCOD_PRECIO"), HiddenField)
                hdnCOD_PRECIO.Value = drv.Row("COD_PRECIO")

                Dim lblCOD_PRECIO As Label = DirectCast(e.Item.FindControl("lblCOD_PRECIO"), Label)
                lblCOD_PRECIO.Text = drv.Row("COD_PRECIO").ToString()

                Dim lblFechaPrecio As Label = DirectCast(e.Item.FindControl("lblFechaPrecio"), Label)
                cadena = "" & drv.Row("PRE_FECHA")
                If cadena <> "" Then
                    lblFechaPrecio.Text = objComun.ConvierteFechaDeMysql(cadena)
                End If

                Dim lblCliente As Label = DirectCast(e.Item.FindControl("lblCliente"), Label)
                cadena = "" & drv.Row("CLINOM").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                lblCliente.Text = cadena

                Dim lblCompra As Label = DirectCast(e.Item.FindControl("lblCompra"), Label)
                cadena = "" & drv.Row("PRE_COMPRA").ToString()
                If cadena = "" Then cadena = "0.00"
                lblCompra.Text = FormatNumber(cadena, 2, TriState.UseDefault, TriState.False, TriState.True)

                Dim lblVenta As Label = DirectCast(e.Item.FindControl("lblVenta"), Label)
                cadena = "" & drv.Row("PRE_VENTA").ToString()
                If cadena = "" Then cadena = "0.00"
                lblVenta.Text = FormatNumber(cadena, 2, TriState.UseDefault, TriState.False, TriState.True)

                Dim lblSegundaDescarga As Label = DirectCast(e.Item.FindControl("lblSegundaDescarga"), Label)
                cadena = "" & drv.Row("PRE_2DESCARGA").ToString()
                If cadena = "" Then cadena = "0.00"
                lblSegundaDescarga.Text = FormatNumber(cadena, 2, TriState.UseDefault, TriState.False, TriState.True)

                Dim lbl_ORIGEN As Label = DirectCast(e.Item.FindControl("lbl_ORIGEN"), Label)
                cadena = "" & drv.Row("DES_ORIGEN").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                lbl_ORIGEN.Text = cadena

                Dim lblDetalleOrigen As Label = DirectCast(e.Item.FindControl("lblDetalleOrigen"), Label)
                cadena = "" & drv.Row("DETALLE_ORIGEN").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                If cadena.Length > 155 Then cadena = cadena.Substring(0, 155) & " ..."
                lblDetalleOrigen.Text = cadena

                Dim lbl_DESTINO As Label = DirectCast(e.Item.FindControl("lbl_DESTINO"), Label)
                cadena = "" & drv.Row("DES_DESTINO").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                lbl_DESTINO.Text = cadena

                Dim lblDetalleDestino As Label = DirectCast(e.Item.FindControl("lblDetalleDestino"), Label)
                cadena = "" & drv.Row("DETALLE_DESTINO").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                If cadena.Length > 155 Then cadena = cadena.Substring(0, 155) & " ..."
                lblDetalleDestino.Text = cadena

                Dim lbl_MERCANCIA As Label = DirectCast(e.Item.FindControl("lbl_MERCANCIA"), Label)
                cadena = "" & drv.Row("PRE_MERCANCIA").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                If cadena.Length > 155 Then cadena = cadena.Substring(0, 155) & " ..."
                lbl_MERCANCIA.Text = cadena

                Dim lblPeso As Label = DirectCast(e.Item.FindControl("lblPeso"), Label)
                cadena = "" & drv.Row("PRE_TNS").ToString()
                lblPeso.Text = cadena

                Dim lblTipoCamion As Label = DirectCast(e.Item.FindControl("lblTipoCamion"), Label)
                cadena = "" & drv.Row("DES_TIPOCAMI").ToString()
                lblTipoCamion.Text = cadena

                Dim lblVolumen As Label = DirectCast(e.Item.FindControl("lblVolumen"), Label)
                cadena = "" & drv.Row("DES_VOLUMEN").ToString()
                lblVolumen.Text = cadena

                Dim btnOpen_Precio As LinkButton = DirectCast(e.Item.FindControl("btnOpen_Precio"), LinkButton)
                Dim URL As String = "Precio.aspx?id=" & drv.Row("COD_PRECIO") & "&P=" & drv.Row("COD_PRECIO") & "&N=N&B=N"
                btnOpen_Precio.PostBackUrl = URL

                Dim btn_Delete As LinkButton = DirectCast(e.Item.FindControl("btn_Delete"), LinkButton)
                URL = "Precio.aspx?id=" & drv.Row("COD_PRECIO") & "&P=" & drv.Row("COD_PRECIO") & "&N=N&B=S"
                btn_Delete.PostBackUrl = URL
            End If
        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        End Try
    End Sub
End Class