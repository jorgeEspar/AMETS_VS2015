Public Class preportes_listado
    Inherits System.Web.UI.Page
    Private CapaDatos As New CapaDatos
    Private objComun As New Comun

    Private pagesize As Integer = 10
    Private WSTotalrows As Integer = 100000

    Private msg As String = String.Empty
    Private tituloMsg As String = ""
    Private TablaErrores As DataTable

    Private FiltrosPrePortes As New FiltrosPrePortes
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
        hdnControlJS.Value = "" ' Inicializamos los mensajes de errores
        NoRegs_Datos.Visible = False

        msg = ""
        pagesize = grPortes.PageSize

        If Not IsPostBack Then
            If Session("DatosUser") Is Nothing Then
                Response.Redirect("login.aspx", True)
            Else
                Dim URL As String = "Preporte.aspx?id=&N=S&B=N" ' id=id del porte, N->Nuevo S/N, B-> Baja S/N
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

                If Session("Filtros_PrePortes") IsNot Nothing Then
                    FiltrosPrePortes = Session("Filtros_PrePortes")
                    If FiltrosPrePortes.FechaHasta <> "" Then
                        txtFecPrePorte.Text = FiltrosPrePortes.FechaDesde & " - " & FiltrosPrePortes.FechaHasta
                    End If
                    If FiltrosPrePortes.FechaEntregaHasta <> "" Then
                        txtFechaPorte.Text = FiltrosPrePortes.FechaEntregaDesde & " - " & FiltrosPrePortes.FechaEntregaHasta
                    End If
                    txtCodCli.Text = "" & FiltrosPrePortes.CodCli
                    txtCliente.Text = "" & FiltrosPrePortes.NombreCli
                    txtMatricula.Text = "" & FiltrosPrePortes.Matricula
                    ddlAgencias.SelectedValue = "" & FiltrosPrePortes.CodAgencia
                    txtDirCarga.Text = "" & FiltrosPrePortes.DirCarga
                    txtDestino.Text = "" & FiltrosPrePortes.DirDestino
                    txtMercancia.Text = "" & FiltrosPrePortes.Mercancia
                    ddlEstado.SelectedValue = "" & FiltrosPrePortes.Estado
                Else
                    CargaFiltrosCampos()
                End If

                Carga_Portes(FiltrosPrePortes.Pagina)
            End If
        End If
    End Sub

    Private Sub Carga_Combos()
        Dim dt As DataTable
        Dim msgpagina As String = ""
        Dim items1 As New ListItem
        items1.Text = "TODAS"
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

    Private Sub CargaFiltrosCampos()
        If txtFecPrePorte.Text <> "" Then
            If txtFecPrePorte.Text.IndexOf("-") > -1 Then
                Dim fechas As String() = txtFecPrePorte.Text.Split(" - ")
                FiltrosPrePortes.FechaDesde = fechas(0)
                FiltrosPrePortes.FechaHasta = fechas(1)
            Else
                FiltrosPrePortes.FechaDesde = txtFecPrePorte.Text
                FiltrosPrePortes.FechaHasta = txtFecPrePorte.Text
            End If
        Else
            FiltrosPrePortes.FechaDesde = ""
            FiltrosPrePortes.FechaHasta = ""
        End If
        If txtFechaPorte.Text <> "" Then
            If txtFechaPorte.Text.IndexOf("-") > -1 Then
                Dim fechasentrega As String() = txtFechaPorte.Text.Split(" - ")
                FiltrosPrePortes.FechaEntregaDesde = fechasentrega(0)
                FiltrosPrePortes.FechaEntregaHasta = fechasentrega(1)
            Else
                FiltrosPrePortes.FechaEntregaDesde = txtFechaPorte.Text
                FiltrosPrePortes.FechaEntregaHasta = txtFechaPorte.Text
            End If
        Else
            FiltrosPrePortes.FechaEntregaDesde = ""
            FiltrosPrePortes.FechaEntregaHasta = ""
        End If
        FiltrosPrePortes.CodCli = txtCodCli.Text
        FiltrosPrePortes.NombreCli = txtCliente.Text
        FiltrosPrePortes.Matricula = txtMatricula.Text
        FiltrosPrePortes.CodAgencia = ddlAgencias.SelectedValue
        FiltrosPrePortes.DirCarga = txtDirCarga.Text
        FiltrosPrePortes.DirDestino = txtDestino.Text
        FiltrosPrePortes.Mercancia = txtMercancia.Text
        FiltrosPrePortes.Estado = ddlEstado.SelectedValue
        FiltrosPrePortes.Pagina = 1

        Session("Filtros_PrePortes") = FiltrosPrePortes
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        Try
            NoRegs_Datos.Visible = False

            Session("ListadoPrePortes") = Nothing

            grPortes.CurrentPageIndex = 0

            CargaFiltrosCampos()

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
            MiTabla = CapaDatos.Get_ListadoPrePortes(txtFecPrePorte.Text, txtCodCli.Text, txtMatricula.Text, ddlAgencias.SelectedValue, txtFechaPorte.Text, txtDirCarga.Text, txtDestino.Text, txtMercancia.Text, ddlEstado.SelectedValue)

            grPortes.VirtualItemCount = MiTabla.Rows.Count
            If MiTabla.Rows.Count > 0 Then
                For i = 0 To MiTabla.Rows.Count - 1
                    cadena = "" & MiTabla.Rows(i).Item("CLINOM").ToString.Trim()
                    cadena = cadena.Replace(vbCrLf, " ")
                    MiTabla.Rows(i).Item("CLINOM") = cadena
                Next
                grPortes.CurrentPageIndex = NumPage - 1
                grPortes.DataSource = MiTabla
                grPortes.DataBind()
            Else
                'NoRegs_Datos.Style.Item("display") = "block"
                NoRegs_Datos.Visible = True
            End If

            Session("ListadoPrePortes") = MiTabla

            If MiTabla.Rows.Count > 0 Then
                NoRegs_Datos.Visible = False
                NoRegs_Datos.Style.Item("display") = "none"
                lblTotalRows_Datos.Text = "Mostrando " & (grPortes.CurrentPageIndex * pagesize + 1) & " a " & IIf((grPortes.CurrentPageIndex * pagesize + pagesize) < MiTabla.Rows.Count, (grPortes.CurrentPageIndex * pagesize + pagesize), MiTabla.Rows.Count.ToString()) & " de " & MiTabla.Rows.Count.ToString() & " Portes"
                lblTotalPages_Datos.Text = " Página " & grPortes.CurrentPageIndex + 1 & " de " & grPortes.PageCount & ""
                TotalRows_Datos.Visible = True
                TotalPages_Datos.Visible = True
                ELsortOrder.Visible = True
                grPortes.PagerStyle.Visible = True
                grPortes.CurrentPageIndex = NumPage - 1
                lblEstado.Text = "Estado Preportes: " & ddlEstado.Items(ddlEstado.SelectedIndex).Text
            Else
                NoRegs_Datos.Visible = True
                NoRegs_Datos.Style.Item("display") = "block"
                grPortes.PagerStyle.Visible = False
                ELsortOrder.Visible = False
                TotalRows_Datos.Visible = False
                TotalPages_Datos.Visible = False
                grPortes.VirtualItemCount = 0
                grPortes.CurrentPageIndex = 0
            End If

        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        End Try
        ScriptManager.RegisterStartupScript(Me, Me.GetType, "ScrollTop", "scrollToTop();", True)
        UP_Eligible.Update()
    End Sub
    Private Sub grPortes_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles grPortes.PageIndexChanged
        Dim dt As DataTable
        Dim msgpagina As String = ""
        Dim TotalPages As String = ""
        pagesize = grPortes.PageSize

        FiltrosPrePortes.Pagina = e.NewPageIndex + 1
        Session("Filtros_PrePortes") = FiltrosPrePortes

        grPortes.CurrentPageIndex = e.NewPageIndex
        dt = Session("ListadoPrePortes")
        With grPortes
            .DataSource = dt
            .DataBind()
        End With
        Me.lblTotalPages_Datos.Text = "Página " & grPortes.CurrentPageIndex + 1 & " de " & grPortes.PageCount & ""
        If dt.Rows.Count > 0 Then
            msgpagina = "Mostrando " & (grPortes.CurrentPageIndex * pagesize + 1) & " a " & IIf((grPortes.CurrentPageIndex * pagesize + pagesize) < dt.Rows.Count, (grPortes.CurrentPageIndex * pagesize + pagesize), dt.Rows.Count) & " de " & dt.Rows.Count.ToString() & " registros"
            TotalPages = "Página " & grPortes.CurrentPageIndex + 1 & " de " & grPortes.PageCount & ""
        End If
        Me.lblTotalRows_Datos.Text = msgpagina
        Me.lblTotalPages_Datos.Text = TotalPages

        ScriptManager.RegisterStartupScript(Me, Me.GetType, "ScrollTop", "scrollToTop();", True)
        UP_Eligible.Update()
    End Sub

    Protected Function SortDataTable(ByVal isPageIndexChanging As Boolean) As DataView
        Dim oDs As DataSet = Session("ListadoPrePortes")
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

    Private Sub txtCodCli_TextChanged(sender As Object, e As EventArgs) Handles txtCodCli.TextChanged
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

    Private Sub grPortes_ItemDataBound(sender As Object, e As DataGridItemEventArgs) Handles grPortes.ItemDataBound
        Dim cadena As String = String.Empty
        Try
            If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
                Dim drv As System.Data.DataRowView = DirectCast((e.Item.DataItem), System.Data.DataRowView)

                Dim hdnAUTOPORTE As HiddenField = DirectCast(e.Item.FindControl("hdnAUTOPORTE"), HiddenField)
                hdnAUTOPORTE.Value = drv.Row("PREPORTE")

                Dim lblNumpor As Label = DirectCast(e.Item.FindControl("lblNumpor"), Label)
                lblNumpor.Text = drv.Row("PREPORTE").ToString()

                Dim lblFechaPorte As Label = DirectCast(e.Item.FindControl("lblFechaPorte"), Label)
                cadena = "" & drv.Row("FECHA")
                If cadena <> "" Then
                    lblFechaPorte.Text = objComun.ConvierteFechaDeMysql(cadena)
                End If

                Dim lblFechaEntrega As Label = DirectCast(e.Item.FindControl("lblFechaEntrega"), Label)
                cadena = "" & drv.Row("FECHA_PORTE")
                If cadena <> "" Then
                    lblFechaEntrega.Text = objComun.ConvierteFechaDeMysql(cadena)
                End If

                Dim lblCliente As Label = DirectCast(e.Item.FindControl("lblCliente"), Label)
                cadena = "" & drv.Row("CLINOM").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                lblCliente.Text = cadena

                Dim lblMatricula As Label = DirectCast(e.Item.FindControl("lblMatricula"), Label)
                lblMatricula.Text = drv.Row("MATRICULA").ToString()
                lblMatricula.ToolTip = "" & drv.Row("CONDUCTOR").ToString()

                Dim lbl_ORIGEN As Label = DirectCast(e.Item.FindControl("lbl_ORIGEN"), Label)
                cadena = "" & drv.Row("DES_ORIGEN").ToString()
                If cadena = "" Then cadena = "" & drv.Row("ORIGEN_LIBRE").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                If cadena.Length > 155 Then cadena = cadena.Substring(0, 155) & " ..."
                lbl_ORIGEN.Text = cadena

                Dim lbl_DESTINO As Label = DirectCast(e.Item.FindControl("lbl_DESTINO"), Label)
                cadena = "" & drv.Row("DES_DESTINO").ToString()
                If cadena = "" Then cadena = "" & drv.Row("DESTINO_LIBRE").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                If cadena.Length > 155 Then cadena = cadena.Substring(0, 155) & " ..."
                lbl_DESTINO.Text = cadena

                Dim lbl_MERCANCIA As Label = DirectCast(e.Item.FindControl("lbl_MERCANCIA"), Label)
                cadena = "" & drv.Row("MERCANCIA").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                If cadena.Length > 155 Then cadena = cadena.Substring(0, 155) & " ..."
                lbl_MERCANCIA.Text = cadena

                Dim lbl_DETALLE_Origen As Label = DirectCast(e.Item.FindControl("lbl_DETALLE_Origen"), Label)
                cadena = "" & drv.Row("DETALLE_ORIGEN").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                If cadena.Length > 155 Then cadena = cadena.Substring(0, 155) & " ..."
                lbl_DETALLE_Origen.Text = cadena

                Dim lbl_DETALLE_Destino As Label = DirectCast(e.Item.FindControl("lbl_DETALLE_Destino"), Label)
                cadena = "" & drv.Row("DETALLE_DESTINO").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                If cadena.Length > 155 Then cadena = cadena.Substring(0, 155) & " ..."
                lbl_DETALLE_Destino.Text = cadena

                Dim lbl_DETALLE_Trans As Label = DirectCast(e.Item.FindControl("lbl_DETALLE_Trans"), Label)
                cadena = "" & drv.Row("DETALLE_TRANS").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                If cadena.Length > 155 Then cadena = cadena.Substring(0, 155) & " ..."
                lbl_DETALLE_Trans.Text = cadena

                Dim compra As Double = 0
                Dim venta As Double = 0
                Dim lblCompra As Label = DirectCast(e.Item.FindControl("lblCompra"), Label)
                cadena = "" & drv.Row("COMPRA").ToString()
                If cadena <> "" Then
                    compra = CDbl(cadena)
                    lblCompra.Text = FormatNumber(cadena, 2)
                End If
                Dim lblVenta As Label = DirectCast(e.Item.FindControl("lblVenta"), Label)
                cadena = "" & drv.Row("VENTA").ToString()
                If cadena <> "" Then
                    venta = CDbl(cadena)
                    lblVenta.Text = FormatNumber(cadena, 2)
                End If

                Dim btnOpen_Porte As LinkButton = DirectCast(e.Item.FindControl("btnOpen_Porte"), LinkButton)
                Dim URL As String = "Preporte.aspx?id=" & drv.Row("PREPORTE") & "&N=N&B=N"
                btnOpen_Porte.PostBackUrl = URL

                Dim btn_Delete As LinkButton = DirectCast(e.Item.FindControl("btn_Delete"), LinkButton)
                URL = "Preporte.aspx?id=" & drv.Row("PREPORTE") & "&N=N&B=S"
                btn_Delete.PostBackUrl = URL

                Dim caso As Integer = 1
                Dim hoy As Date = Today

                Dim fecha_compra As Date = Nothing
                cadena = "" & drv.Row("FECHA_COMPRA")
                If cadena <> "" Then fecha_compra = CDate(cadena)

                Dim fecha_porte As Date = Nothing
                cadena = "" & drv.Row("FECHA_PORTE")
                If cadena <> "" Then fecha_porte = CDate(cadena)

                Dim matricula As String
                matricula = "" & drv.Row("MATRICULA")
                If matricula = "" Or fecha_compra = Nothing Then
                    caso = 1
                Else
                    If (fecha_porte <> Nothing And fecha_porte >= hoy) Or (fecha_compra <> Nothing And fecha_compra = hoy) Then
                        caso = 2
                    Else
                        If drv.Row("REALIZADO") = 0 Then caso = 3 Else caso = 4
                    End If
                End If

                Dim tablaColorEstado As HtmlTable = DirectCast(e.Item.FindControl("tEstado"), HtmlTable)
                Dim colorfondo As String
                Select Case caso
                    Case 1 ' Blanco
                        colorfondo = "#fff"
                        'tablaColorEstado.BgColor = System.Drawing.ColorTranslator.FromHtml(colorfondo)
                        tablaColorEstado.Style.Add(HtmlTextWriterStyle.BackgroundColor, "#fff")
                    Case 2
                        tablaColorEstado.Style.Add(HtmlTextWriterStyle.BackgroundColor, "#00FFFF")
                    Case 3
                        tablaColorEstado.Style.Add(HtmlTextWriterStyle.BackgroundColor, "#FF0000")
                    Case 4
                        tablaColorEstado.Style.Add(HtmlTextWriterStyle.BackgroundColor, "#848284")
                    Case Else
                        tablaColorEstado.Style.Add(HtmlTextWriterStyle.BackgroundColor, "#FFF")
                End Select
            End If
        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        End Try
    End Sub

End Class