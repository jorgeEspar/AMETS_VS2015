﻿Public Class Buscador_Clientes
    Inherits System.Web.UI.Page
    Private msg As String = String.Empty
    Private tituloMsg As String = ""
    Private TablaErrores As DataTable

    Public CapaDatos As New CapaDatos
    Private objComun As New Comun
    Private pagesize As Integer = 50
    Private WSTotalrows As Integer = 100000

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnControlJS.Value = "" ' Inicializamos los mensajes de errores
        msg = ""

        'Introducir aquí el código de usuario para inicializar la página
        Response.Expires = 0
        Response.Cache.SetNoStore()
        Response.AppendHeader("Pragma", "no-cache")

        If Not Page.IsPostBack Then
            pagesize = gcDatosBuscador.PageSize
            NoRegs.Visible = False

            Session("SortByBuscador") = "Descripcion ASC"
            Session("SortExpression") = "Descripcion"
            GridViewSortExpression = "Descripcion"
            Session("SortDirection") = "ASC"
            GridViewSortDirection = SortDirection.Ascending

            'btSearch.Attributes.Add("onClick", "var srResult = controlarFiltros();return srResult;")
            'btSearch.Attributes.Add("onKeyPress", "var srResult = controlarFiltros();return srResult;")

            'If Request.QueryString("empty") = "S" Then

            'Else
            '    FillData(1)
            'End If
            'FillData(1)

            txtCodigo.Focus()
        Else
            'ScriptManager.RegisterStartupScript(Me, Page.GetType, "Script", "pageLoad();", True)
        End If
    End Sub


#Region "Controls Events"
    Private Function Get_DatosBuscador(ByVal codigo As String, ByVal descripcion As String, ByVal cifnif As String) As DataTable
        Dim MiTabla As DataTable = New DataTable
        Dim swerror As String = String.Empty

        Try
            MiTabla = CapaDatos.Get_Clientes(codigo, descripcion, cifnif)
            If MiTabla.Rows.Count > 0 Then
                For i = 0 To MiTabla.Rows.Count - 1
                    MiTabla.Rows(i).Item("CLINOM") = MiTabla.Rows(i).Item("CLINOM").ToString.Trim()
                Next
            End If
        Catch ex As Exception
            swerror = "E"
            MuestraMensaje(ex.Message, 1, "ERROR")
        End Try

        If swerror <> "E" Then
            Return MiTabla
        Else
            MiTabla.Clear()
            Return MiTabla
        End If
    End Function

    Private Sub btSearch_Click(sender As Object, e As EventArgs) Handles btSearch.Click
        dtextfiltros.Visible = False

        FillData(1)

    End Sub
#End Region

#Region "Private Methods"
    Private Sub FillData(ByVal pActual As Integer)
        Dim dt As DataTable
        Dim msgpagina As String = ""
        Dim TotalPages As String = ""
        Try
            dt = Get_DatosBuscador(txtCodigo.Text, txtDescripcion.Text, txtCIFNIF.Text)
            Session("dtBuscadorClientes") = dt

            If Not dt Is Nothing Then
                FillGridView(gcDatosBuscador, dt)

                If dt.Rows.Count = 0 Then
                    hiCurrentPage.Value = "0"
                    hiNumTotalPages.Value = "0"
                    noresults.Visible = True
                    lblTotalRows.Visible = False
                    lblTotalPages.Visible = False

                    Me.lblTotalPages.Text = String.Empty
                    Me.lblTotalRows.Text = "Total registros: {0}"
                Else
                    noresults.Visible = False

                    '**************************************************
                    If dt.Rows.Count > 0 Then
                        msgpagina = "Mostrando " & (gcDatosBuscador.PageIndex * pagesize + 1) & " a " & IIf((gcDatosBuscador.PageIndex * pagesize + pagesize) < dt.Rows.Count, (gcDatosBuscador.PageIndex * pagesize + pagesize), dt.Rows.Count) & " de " & dt.Rows.Count.ToString() & " registros"
                        TotalPages = "Página " & gcDatosBuscador.PageIndex + 1 & " de " & gcDatosBuscador.PageCount & ""
                    End If
                    '**************************************************

                    hiCurrentPage.Value = pActual.ToString()
                    If (dt.Rows.Count = 0) Then
                        hiNumTotalPages.Value = "1"
                    Else
                        hiNumTotalPages.Value = gcDatosBuscador.PageCount 'TotalPages
                    End If

                    Me.lblTotalRows.Text = msgpagina
                    Me.lblTotalPages.Text = TotalPages 'String.Format("{0}-{1}", hiCurrentPage.Value.ToString(), hiNumTotalPages.Value.ToString)
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
        'UPanelGrid.Update()
    End Sub

    Private Sub FillGridView(ByRef oGridView As GridView, ByVal oDataSource As DataTable)
        Try
            With oGridView
                .DataSource = oDataSource
                .DataBind()
            End With
            ''LoadItemGridView()
        Catch ex As Exception
            Dim msg As String = ex.Message
        End Try

    End Sub

    ''Private Sub LoadItemGridView()
    ''    For i As Integer = 0 To gcDatosBuscador.Rows.Count - 1
    ''        gcDatosBuscador.Rows.Item(i).Attributes("valorId") = gcDatosBuscador.Rows.Item(i).Cells(1).Text
    ''    Next
    ''End Sub

#End Region

#Region "Properties"
    Private m_strSortExp As String
    Private Function ConvertSortDirectionToSql(ByVal sortDirection As SortDirection) As String
        Dim newSortDirection As String = String.Empty
        Select Case sortDirection
            Case SortDirection.Ascending
                newSortDirection = "ASC"
                Exit Select
            Case SortDirection.Descending
                newSortDirection = "DESC"
                Exit Select
        End Select
        Return newSortDirection
    End Function

    Private Property GridViewSortExpression() As String
        Get
            Return m_strSortExp
        End Get
        Set(ByVal value As String)
            m_strSortExp = value
        End Set
    End Property

    Private Property GridViewSortDirection() As SortDirection
        Get
            If ViewState("sortDirection") Is Nothing Then
                ViewState("sortDirection") = SortDirection.Ascending
            End If
            Return DirectCast(ViewState("sortDirection"), SortDirection)
        End Get
        Set(ByVal value As SortDirection)
            ViewState("sortDirection") = value
        End Set
    End Property
#End Region

#Region "GridView Events"
    Private Sub gcDatosBuscador_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles gcDatosBuscador.PageIndexChanging
        Try
            Dim dt As DataTable
            Dim msgpagina As String = ""
            Dim TotalPages As String = ""
            pagesize = gcDatosBuscador.PageSize

            gcDatosBuscador.PageIndex = e.NewPageIndex
            dt = Session("dtBuscadorClientes")
            With gcDatosBuscador
                .DataSource = dt
                .DataBind()
            End With
            Me.lblTotalPages.Text = "Página " & gcDatosBuscador.PageIndex + 1 & " de " & gcDatosBuscador.PageCount & ""
            If dt.Rows.Count > 0 Then
                msgpagina = "Mostrando " & (gcDatosBuscador.PageIndex * pagesize + 1) & " a " & IIf((gcDatosBuscador.PageIndex * pagesize + pagesize) < dt.Rows.Count, (gcDatosBuscador.PageIndex * pagesize + pagesize), dt.Rows.Count) & " de " & dt.Rows.Count.ToString() & " registros"
                TotalPages = "Página " & gcDatosBuscador.PageIndex + 1 & " de " & gcDatosBuscador.PageCount & ""
            End If
            Me.lblTotalRows.Text = msgpagina
            Me.lblTotalPages.Text = TotalPages 'String.Format("{0}-{1}", hiCurrentPage.Value.ToString(), hiNumTotalPages.Value.ToString)
        Catch ex As Exception
            Dim msg As String = ex.Message
        End Try
    End Sub

    Protected Sub gcDatosBuscador_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles gcDatosBuscador.Sorting
        Try
            Dim Campo As String = e.SortExpression
            'Si ya existe Recuperar el Tipo de Orden del Estado de la Vista 
            If ViewState(Campo) IsNot Nothing Then
                e.SortDirection = ViewState(Campo)
            Else
                e.SortDirection = SortDirection.Descending
            End If

            'Recuperar el tipo de orden
            If e.SortDirection = SortDirection.Descending Then
                e.SortDirection = SortDirection.Ascending
                GridViewSortDirection = SortDirection.Ascending
            Else
                e.SortDirection = SortDirection.Descending
                GridViewSortDirection = SortDirection.Descending
            End If
            GridViewSortExpression = e.SortExpression
            'Guardar el Tipo de Orden en una variable de sesion
            ViewState(Campo) = e.SortDirection

            Session("SortExpression") = GridViewSortExpression
            Session("SortDirection") = ConvertSortDirectionToSql(e.SortDirection)

            'Fill Data
            FillData(Convert.ToInt32(hiCurrentPage.Value))
        Catch ex As Exception
            Dim msg As String = ex.Message
        End Try
    End Sub

    Protected Sub gcDatosBuscador_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gcDatosBuscador.RowDataBound
        Try
            Dim cadena As String
            If e.Row.RowType = DataControlRowType.DataRow Then
                'set hover highlight for the gridview
                e.Row.Attributes.Add("onmouseover", "SetGridViewHoverOn(this);")
                'when mouse leaves the row, change the bg color to its original value   
                e.Row.Attributes.Add("onmouseout", "SetGridViewHoverOff(this);")

                Dim lbl_CODIGO As Label = DirectCast(e.Row.Cells(0).FindControl("lbl_CODIGO"), Label)
                Dim lbl_NOMBRE As Label = DirectCast(e.Row.Cells(1).FindControl("lbl_NOMBRE"), Label)
                cadena = lbl_NOMBRE.Text.ToString().Trim()
                cadena = cadena.Replace("'", "")
                cadena = cadena.Replace("""", "")
                cadena = cadena.Replace(vbCrLf, " - ")
                lbl_NOMBRE.Text = cadena

                cadena = "ReturnDataClient(" & lbl_CODIGO.Text.ToString().Trim() & ",""" & lbl_NOMBRE.Text.ToString() & """);return false;"
                'cadena = cadena.Replace("'", "\'")
                cadena = cadena.Replace(vbCrLf, " - ")
                'cadena = HttpUtility.HtmlEncode(cadena)
                e.Row.Attributes.Add("onClick", cadena)

                e.Row.Attributes.Add("style", "cursor:pointer")
            End If
        Catch ex As Exception
            Dim msg As String = ex.Message
        End Try

    End Sub
#End Region

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

End Class