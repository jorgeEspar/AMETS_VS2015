Public Class FacturasX
    Inherits System.Web.UI.Page
    Private CapaDatos As New CapaDatos
    Private objComun As New Comun

    Private msg As String = String.Empty
    Private tituloMsg As String = ""
    Private TablaErrores As DataTable

    Public AUTOFAC As Long = 0
    Public NUMERO_FAC As Long = 0
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
                Session("dtPortesSeleccionar") = Nothing
                Session("dtPortesFactura") = Nothing
                hndAlta.Value = "0"
                hndBaja.Value = "0"

                Nuevo = True
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
                            NUMERO_FAC = CLng(Request.QueryString("P"))
                        End If
                    End If
                    If Request.QueryString("N") IsNot Nothing Then
                        If Request.QueryString("N") = "S" Then Nuevo = True
                        If Request.QueryString("B") = "S" Then Baja = True
                    End If

                    'Carga_Combos()

                    If Nuevo = True Then
                        hndAlta.Value = "1"
                        Dim numporte As Long = CapaDatos.Get_Num_Portes()
                        numporte += 1
                        ''txtNumFactura.Text = numporte.ToString
                        ''txtFecFactura.Text = DateTime.Now.ToString("dd/MM/yyyy")
                    Else
                        If hdnFacturaId.Value <> "" Then
                            ''Carga_Factura(hdnFacturaId.Value)
                        End If
                        If Baja = True Then
                            hndBaja.Value = "1"
                            'Deshabilitar_Controles()
                        End If
                    End If
                End If

                If Nuevo = True Then
                    lblTituloPag.InnerText = "NUEVA FACTURA"
                    ''btnBtnImprimir.Visible = False
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
    Private Sub txtCodCli_TextChanged(sender As Object, e As EventArgs) Handles txtCodCli.TextChanged
        dtPortesSeleccionar = Nothing
        dtPortesFactura = Nothing
        Session("dtPortesSeleccionar") = Nothing
        Session("dtPortesFactura") = Nothing

        Dim dt As DataTable
        txtCliente.Text = ""
        ''gr_Portes_Factura.DataSource = ""
        ''gr_Portes_Factura.DataBind()

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
        ''UP_Filtros_Portes.Update()
        UPanelPortesSel.Update()
        ''UP_Portes_Factura.Update()

        Carga_Portes_Cliente()
    End Sub
    Private Sub Carga_Portes_Cliente()
        Dim i As Long
        Dim cadena As String
        NoRegs_Datos.Visible = False
        Session("dtPortesSeleccionar") = Nothing

        If txtCodCli.Text = "" Then
            txtCliente.Text = ""
        Else
            Dim MiTabla As DataTable = New DataTable
            Dim swerror As String = String.Empty

            Try
                ''MiTabla = CapaDatos.Get_Portes_Cliente_Factura(txtCodCli.Text, ddlTipoPorte.SelectedValue, txtHastaFechaPortes.Text, txtMatricula.Text, ddlAgencias.SelectedValue)
                MiTabla = CapaDatos.Get_Portes_Cliente_Factura(txtCodCli.Text, "", "", "", "")
                dtPortesSeleccionar = MiTabla
                Session("dtPortesSeleccionar") = dtPortesSeleccionar
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

                            'MiTabla.Rows(i).Item("FECHA") =
                            MiTabla.Rows(i).Item("DESTINO") = "" & MiTabla.Rows(i).Item("DESTINO").replace(vbCrLf, "<br/>")
                            MiTabla.Rows(i).Item("DESIGNACION") = "" & MiTabla.Rows(i).Item("DESIGNACION").replace(vbCrLf, "<br/>")

                            totalventa += MiTabla.Rows(i).Item("VENTA")
                        Next
                        lblTotalVenta.Text = "TOTAL Venta: " & FormatNumber(totalventa, 2) & " €"
                        lblTotalRows_Datos.Text = FormatNumber(MiTabla.Rows.Count, 0) & " portes seleccionados."

                        grSelPortes.DataSource = MiTabla
                        grSelPortes.DataBind()

                    End If
                End If
            Catch ex As Exception
                MuestraMensaje(ex.Message, 1, "ERROR")
            End Try
        End If
        'UPCODCLI.Update()
        ''UP_Filtros_Portes.Update()
        UPanelPortesSel.Update()
        'UPanelSelPortes.Update()
    End Sub

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
    Private Sub Deshabilitar_Controles()
        ''txtFecFactura.Enabled = False
        ''txtFecVencimiento.Enabled = False
        ''btnBtnImprimir.Visible = False

        txtCodCli.Enabled = False
        lbldeleteprescriptor.Visible = False
        lblicobuscadorPrescriptor.Visible = False

        'btnAdd_Agenda.Visible = False

        ''ddlAgencias.Enabled = False

        ''txtObservaciones.ReadOnly = True

    End Sub
#End Region
End Class