Public Class SiteMaster
    Inherits MasterPage
    Private ObjComun As New Comun

    Public RootURL As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        RootURL = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + ResolveUrl("~/")

        Get_Datos_Usuario()

    End Sub
    Protected Sub btnLogOut_ServerClick(sender As Object, e As EventArgs) Handles btnLogoff.Click

        Session.Abandon()
        ''FormsAuthentication.SignOut()
        ''FormsAuthentication.RedirectToLoginPage()

        'ScriptManager.RegisterClientScriptBlock(Me, GetType(Page), "cerrar", "CloseWindow();", True)
        Response.Redirect("~/Login.aspx", True)
    End Sub

    Protected Sub Get_Datos_Usuario()
        If Session("DatosUser") IsNot Nothing Then
            GetLogin()
        End If

    End Sub

    Protected Sub GetLogin()
        Dim urlEntrada As String = String.Empty
        Dim dt As DataTable
        Dim idUsuario As String = ""
        Dim Nombreusuario As String = "Prueba usuario"
        Dim PIN_User As String = String.Empty
        Dim TipoUsuario As String = ""
        Try
            If Session("DatosUser") IsNot Nothing Then
                dt = Session("DatosUser")
                idUsuario = dt.Rows(0).Item("id")
                Nombreusuario = dt.Rows(0).Item("nombre")
                TipoUsuario = dt.Rows(0).Item("tipoacceso")
                PIN_User = dt.Rows(0).Item("pin")
            End If
            'if (!String.IsNullOrEmpty((String)Request.Form["scwentrada"]))

            hdnUserName.Value = Nombreusuario
        Catch ex As Exception
            Response.Redirect("login.aspx", True)
        End Try

        Session("idUsuario") = idUsuario
        Session("NombreUsuario") = Nombreusuario
        Session("TipoUsuario") = TipoUsuario
    End Sub
End Class