Public Class facturas_listado
    Inherits System.Web.UI.Page
    Private CapaDatos As New CapaDatos
    Private objComun As New Comun

    Private pagesize As Integer = 10
    Private WSTotalrows As Integer = 100000

    Private msg As String = String.Empty
    Private tituloMsg As String = ""
    Private TablaErrores As DataTable

    Private FiltrosFacturas As New FiltrosFacturas

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
        pagesize = grFacturas.PageSize

        If Not IsPostBack Then
            If Session("DatosUser") Is Nothing Then
                Response.Redirect("login.aspx", True)
            Else
                Dim URL As String = "Factura.aspx?id=&N=S&B=N" ' id=id del porte, N->Nuevo S/N, B-> Baja S/N
                btnNuevo.PostBackUrl = URL

                Session("SortedView") = EL_sort_field.Value
                Session("SortDirection") = EL_sort_order.Value

                NoRegs_Datos.Visible = False

                Dim auxError As String = ReturnedError
                If Not String.IsNullOrEmpty(auxError) Then
                    ClientScript.RegisterStartupScript(Me.GetType, "returnErr", String.Format("ShowWarning('Error', '{0}');",
                                        auxError.Replace(vbCrLf, "").Replace("'", "")), True)
                End If

                'Carga_Combos()

                If Session("Filtros_Facturas") IsNot Nothing Then
                    FiltrosFacturas = Session("Filtros_Facturas")
                    txtNumFac.Text = "" & FiltrosFacturas.NumeroFactura
                    If FiltrosFacturas.FechaHasta <> "" Then
                        txtFecFactura.Text = FiltrosFacturas.FechaDesde & " - " & FiltrosFacturas.FechaHasta
                    End If
                    txtCodCli.Text = "" & FiltrosFacturas.CodCli
                    txtCliente.Text = "" & FiltrosFacturas.NombreCli
                    ddlEstado.SelectedValue = "" & FiltrosFacturas.Estado

                    Carga_Facturas(FiltrosFacturas.Pagina)
                Else
                    Carga_Facturas(1)
                End If

            End If
        End If
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        Try
            NoRegs_Datos.Visible = False

            Session("ListadoFacturas") = Nothing

            grFacturas.CurrentPageIndex = 0

            If txtFecFactura.Text <> "" Then
                If txtFecFactura.Text.IndexOf("-") > -1 Then
                    Dim fechas As String() = txtFecFactura.Text.Split(" - ")
                    FiltrosFacturas.FechaDesde = fechas(0)
                    FiltrosFacturas.FechaHasta = fechas(1)
                Else
                    FiltrosFacturas.FechaDesde = txtFecFactura.Text
                    FiltrosFacturas.FechaHasta = txtFecFactura.Text
                End If
            Else
                FiltrosFacturas.FechaDesde = ""
                FiltrosFacturas.FechaHasta = ""
            End If
            FiltrosFacturas.NumeroFactura = txtNumFac.Text
            FiltrosFacturas.CodCli = txtCodCli.Text
            FiltrosFacturas.NombreCli = txtCliente.Text
            FiltrosFacturas.Estado = ddlEstado.SelectedValue
            FiltrosFacturas.Pagina = 1

            Session("Filtros_Facturas") = FiltrosFacturas

            FiltrosFacturas = Session("Filtros_Facturas")

            Carga_Facturas(1)

        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        Finally
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "asddas", "ReloadDatepicker();", True)
        End Try
    End Sub

    Private Sub Carga_Facturas(ByVal NumPage As Integer)
        Dim MiTabla As DataTable = New DataTable
        Dim cadena As String

        Try
            MiTabla = CapaDatos.Get_ListadoFacturas(txtNumFac.Text, txtFecFactura.Text, txtCodCli.Text, ddlEstado.SelectedValue)

            grFacturas.VirtualItemCount = MiTabla.Rows.Count
            If MiTabla.Rows.Count > 0 Then
                For i = 0 To MiTabla.Rows.Count - 1
                    cadena = "" & MiTabla.Rows(i).Item("CLINOM").ToString.Trim()
                    cadena = cadena.Replace(vbCrLf, " ")
                    MiTabla.Rows(i).Item("CLINOM") = cadena
                Next
            Else
                'NoRegs_Datos.Style.Item("display") = "block"
                NoRegs_Datos.Visible = True
            End If
            grFacturas.CurrentPageIndex = NumPage - 1
            grFacturas.DataSource = MiTabla
            grFacturas.DataBind()

            Session("ListadoFacturas") = MiTabla

            If MiTabla.Rows.Count > 0 Then
                Dim totalfacturas As Double = 0
                Dim totalcobrado As Double = 0
                Dim totalpendiente As Double = 0
                Dim cu As Long = MiTabla.Rows.Count
                For i = 0 To cu - 1
                    totalfacturas += MiTabla.Rows(i).Item("IMPORTE_FAC")
                    cadena = "" & MiTabla.Rows(i).Item("SUMCOBRADO")
                    If cadena <> "" Then
                        totalcobrado += MiTabla.Rows(i).Item("SUMCOBRADO")
                    End If
                Next
                totalpendiente = totalfacturas - totalcobrado
                lblTotalFacturas.Text = FormatNumber(totalfacturas, 2, True, TriState.False, True)
                lblTotalCobrado.Text = FormatNumber(totalcobrado, 2, True, TriState.False, True)
                lblTotalPendienteCobro.Text = FormatNumber(totalpendiente, 2, True, TriState.False, True)

                NoRegs_Datos.Visible = False
                NoRegs_Datos.Style.Item("display") = "none"
                lblTotalRows_Datos.Text = "Mostrando " & (grFacturas.CurrentPageIndex * pagesize + 1) & " a " & IIf((grFacturas.CurrentPageIndex * pagesize + pagesize) < MiTabla.Rows.Count, (grFacturas.CurrentPageIndex * pagesize + pagesize), MiTabla.Rows.Count.ToString()) & " de " & MiTabla.Rows.Count.ToString() & " Portes"
                lblTotalPages_Datos.Text = " Página " & grFacturas.CurrentPageIndex + 1 & " de " & grFacturas.PageCount & ""
                TotalRows_Datos.Visible = True
                TotalPages_Datos.Visible = True
                divTotales.Visible = True
                ELsortOrder.Visible = True
                grFacturas.PagerStyle.Visible = True
                grFacturas.CurrentPageIndex = NumPage - 1
                lblEstado.Text = "Estado Portes: " & ddlEstado.Items(ddlEstado.SelectedIndex).Text
                lblEstado.Visible = True
            Else
                NoRegs_Datos.Visible = True
                NoRegs_Datos.Style.Item("display") = "block"
                grFacturas.PagerStyle.Visible = False
                ELsortOrder.Visible = False
                divTotales.Visible = False
                TotalRows_Datos.Visible = False
                TotalPages_Datos.Visible = False
                lblEstado.Visible = False
                grFacturas.VirtualItemCount = 0
                grFacturas.CurrentPageIndex = 0
            End If

        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        End Try
        ScriptManager.RegisterStartupScript(Me, Me.GetType, "ScrollTop", "scrollToTop();", True)
        UP_Eligible.Update()
    End Sub
    Private Sub grFacturas_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles grFacturas.PageIndexChanged
        Dim dt As DataTable
        Dim msgpagina As String = ""
        Dim TotalPages As String = ""
        pagesize = grFacturas.PageSize

        FiltrosFacturas.Pagina = e.NewPageIndex + 1
        Session("Filtros_Facturas") = FiltrosFacturas

        grFacturas.CurrentPageIndex = e.NewPageIndex
        dt = Session("ListadoFacturas")
        With grFacturas
            .DataSource = dt
            .DataBind()
        End With
        Me.lblTotalPages_Datos.Text = "Página " & grFacturas.CurrentPageIndex + 1 & " de " & grFacturas.PageCount & ""
        If dt.Rows.Count > 0 Then
            msgpagina = "Mostrando " & (grFacturas.CurrentPageIndex * pagesize + 1) & " a " & IIf((grFacturas.CurrentPageIndex * pagesize + pagesize) < dt.Rows.Count, (grFacturas.CurrentPageIndex * pagesize + pagesize), dt.Rows.Count) & " de " & dt.Rows.Count.ToString() & " registros"
            TotalPages = "Página " & grFacturas.CurrentPageIndex + 1 & " de " & grFacturas.PageCount & ""
        End If
        Me.lblTotalRows_Datos.Text = msgpagina
        Me.lblTotalPages_Datos.Text = TotalPages

        ScriptManager.RegisterStartupScript(Me, Me.GetType, "ScrollTop", "scrollToTop();", True)
        UP_Eligible.Update()
    End Sub
    Protected Function SortDataTable(ByVal isPageIndexChanging As Boolean) As DataView
        Dim oDs As DataSet = Session("ListadoFacturas")
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

    Private Sub grFacturas_ItemDataBound(sender As Object, e As DataGridItemEventArgs) Handles grFacturas.ItemDataBound
        Dim cadena As String = String.Empty
        Try
            If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
                Dim drv As System.Data.DataRowView = DirectCast((e.Item.DataItem), System.Data.DataRowView)

                Dim hdnAUTOFAC As HiddenField = DirectCast(e.Item.FindControl("hdnAUTOFAC"), HiddenField)
                hdnAUTOFAC.Value = drv.Row("AUTOFAC")

                Dim lblNumfac As Label = DirectCast(e.Item.FindControl("lblNumfac"), Label)
                lblNumfac.Text = drv.Row("NUMFAC").ToString()

                Dim lblFechaFactura As Label = DirectCast(e.Item.FindControl("lblFechaFactura"), Label)
                cadena = "" & drv.Row("FECHA_FAC")
                If cadena <> "" Then
                    lblFechaFactura.Text = objComun.ConvierteFechaDeMysql(cadena)
                End If

                Dim fechacobro As String = "" & drv.Row("FECHA_COBRO")
                Dim lblFechaCobro As Label = DirectCast(e.Item.FindControl("lblFechaCobro"), Label)
                If fechacobro <> "" Then
                    lblFechaCobro.Text = objComun.ConvierteFechaDeMysql(fechacobro)
                End If
                Dim lblVencimiento As Label = DirectCast(e.Item.FindControl("lblVencimiento"), Label)
                lblVencimiento.Text = "" & drv.Item("FECHA_VTO")

                Dim lblCliente As Label = DirectCast(e.Item.FindControl("lblCliente"), Label)
                cadena = "" & drv.Row("CLINOM").ToString()
                cadena = cadena.Replace(vbCrLf, " - ")
                lblCliente.Text = "[" & drv.Row("CLIENTE_FAC") & "] " & cadena

                Dim lblImporteFac As Label = DirectCast(e.Item.FindControl("lblImporteFac"), Label)
                Dim importe_fac As Double = 0
                Dim cobrado As Double = 0
                Dim restan_cobro As Double = 0
                cadena = "" & drv.Row("IMPORTE_FAC").ToString()
                If cadena <> "" Then
                    importe_fac = CDbl(cadena)
                    cadena = FormatNumber(cadena, 2)
                End If
                lblImporteFac.Text = cadena
                cadena = "" & drv.Row("SUMCOBRADO").ToString()
                If cadena <> "" Then
                    cobrado = CDbl(cadena)
                End If

                If fechacobro <> "" Then
                    cobrado = importe_fac
                Else
                    restan_cobro = importe_fac - cobrado
                End If

                Dim lblImporteCobrado As Label = DirectCast(e.Item.FindControl("lblImporteCobrado"), Label)
                Dim colorobro As String = "#ff0000"
                If cobrado = importe_fac Then
                    colorobro = "#0000ff"
                End If
                lblImporteCobrado.Text = FormatNumber(cobrado, 2)
                lblImporteCobrado.ForeColor = System.Drawing.ColorTranslator.FromHtml(colorobro)

                Dim lblRestan As Label = DirectCast(e.Item.FindControl("lblRestan"), Label)
                Dim colorrestan As String = "#4FB54F"
                If restan_cobro > 0 Then
                    colorrestan = "#ff0000"
                End If
                lblRestan.Text = FormatNumber(restan_cobro, 2)
                lblRestan.ForeColor = System.Drawing.ColorTranslator.FromHtml(colorrestan)

                Dim capaPortesFactra As HtmlGenericControl = DirectCast(e.Item.FindControl("capaPortesFactra"), HtmlGenericControl)
                cadena = "<table class='tcalertas' border='0' style='width:100% !important;'><tr><td>"
                cadena += "" & drv.Row("CONCEPTO_FAC") & "</td></tr></table>"
                capaPortesFactra.InnerHtml = cadena

                Dim btnOpen_Factura As LinkButton = DirectCast(e.Item.FindControl("btnOpen_Factura"), LinkButton)
                Dim URL As String = "Factura.aspx?id=" & drv.Row("AUTOFAC") & "&P=" & drv.Row("NUMFAC") & "&N=N&B=N"
                btnOpen_Factura.PostBackUrl = URL

                Dim btn_Delete As LinkButton = DirectCast(e.Item.FindControl("btn_Delete"), LinkButton)
                URL = "Factura.aspx?id=" & drv.Row("AUTOFAC") & "&P=" & drv.Row("NUMFAC") & "&N=N&B=S"
                btn_Delete.PostBackUrl = URL
            End If
        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        End Try
    End Sub
End Class