Public Class Login
    Inherits Page

    Public CapaDatos As New CapaDatos
    Public objComun As New Comun
    Private Const CT_DEFAULT_PAGE As String = "Default.aspx"
    'Dim scriptRegisterJS As New ScriptRegisterJS

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Session("idUsuario") = String.Empty
            Session("NombreUsuario") = String.Empty
            Session("TipoUsuario") = String.Empty
            Session("PIN") = String.Empty
            Session("DatosUser") = Nothing

            'txtUser.Value = "amets"
            'txtPassword.Value = "amets"
            Session("ListadoPortes") = Nothing
            Session("ListadoPrePortes") = Nothing
            Session("ListadoFacturas") = Nothing

            Session("Filtros_Portes") = Nothing
            Session("Filtros_PrePortes") = Nothing
            Session("Filtros_Facturas") = Nothing

            Dim urlRaizAplicacion As String = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority)
            Session("UrlRaizAplicacion") = urlRaizAplicacion & Request.ApplicationPath & "/"

        End If
    End Sub

#Region "Controls Events"
    Protected Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
        Dim dt As DataTable

        Try
            dt = CapaDatos.Get_Login(txtUser.Value, txtPassword.Value)
            If dt.Rows.Count > 0 Then
                Session("DatosUser") = dt
                Response.Redirect("principal.aspx", True)
            Else
                MuestraMensaje("El usuario o la contraseña no son correctos.", 1, "ERROR")
            End If
        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        End Try
        'If Session("DatosUser") IsNot Nothing Then

        'End If
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