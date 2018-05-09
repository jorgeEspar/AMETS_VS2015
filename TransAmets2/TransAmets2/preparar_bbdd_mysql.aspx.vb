Public Class preparar_bbdd_mysql
    Inherits System.Web.UI.Page
    Private CapaDatos As New CapaDatos
    Private objComun As New Comun

    Private msg As String = String.Empty
    Private tituloMsg As String = ""
    Private TablaErrores As DataTable

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnControlJS.Value = "" ' Inicializamos los mensajes de errores
        msg = ""
        Try
            If Not IsPostBack Then
                If Session("DatosUser") Is Nothing Then
                    Response.Redirect("login.aspx", True)
                Else

                End If
            End If
        Catch ex As Exception
            MuestraMensaje("Error: " & ex.Message.ToString(), 1, "ERROR")
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

    Private Sub btnGenerar_ServerClick(sender As Object, e As EventArgs) Handles btnGenerar.ServerClick
        Dim msg As String
        Try
            msg = CapaDatos.Prepara_BBDD_MYsql()
            If msg <> "" Then
                MuestraMensaje("Error: " & msg, 1, "ERROR")
            Else
                MuestraMensaje("El proceso ha concluido satisfactoriamente.", 3, "PREPARAR BBDD")
            End If

        Catch ex As Exception
            MuestraMensaje("Error: " & ex.Message.ToString(), 1, "ERROR")
        End Try
    End Sub
End Class