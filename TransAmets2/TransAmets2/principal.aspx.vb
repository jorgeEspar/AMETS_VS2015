Imports System.Web.Script.Serialization
Imports System.Web.Services

Public Class principal
    Inherits System.Web.UI.Page
    Private CapaDatos As New CapaDatos
    Private objComun As New Comun

    Private msg As String = String.Empty
    Private tituloMsg As String = ""
    Private TablaErrores As DataTable

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

        If Not IsPostBack Then
            If Session("DatosUser") Is Nothing Then
                Response.Redirect("login.aspx", True)
            Else
                Dim hoy As Date = Date.Today
                Dim fecha As Date = hoy.AddMonths(-13)
                Dim fechasdefecto As String = "01/" & Month(fecha).ToString.PadLeft(2, "0") & "/" & Year(fecha) & " - " & Day(hoy).ToString.PadLeft(2, "0") & "/" & Month(hoy).ToString.PadLeft(2, "0") & "/" & Year(hoy)
                txtFechas.Text = fechasdefecto
                hdnFechasDefecto.Value = fechasdefecto
                Carga_Combos()

                Carga_Estadisticas()
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

    Private Sub Carga_Estadisticas()
        Carga_Cobros_Pagos_Pendientes()
        Carga_Grahp1()
        Carga_Grahp2()
        Carga_Grahp3()
    End Sub

    Private Sub Carga_Cobros_Pagos_Pendientes()
        Dim dt As DataTable
        Dim TOTAL_COMPRA As Double = 0
        Dim NUMPORTES_TOTAL_COMPRA As Double = 0
        Dim TOTAL_VENTA As Double = 0
        Dim NUMPORTES_TOTAL_VENTA As Double = 0
        Dim PENDIENTE_COBRO As Double = 0
        Dim NUMPORTES_PENDIENTE_COBRO As Double = 0
        Dim PENDIENTE_PAGO As Double = 0
        Dim NUMPORTES_PENDIENTE_PAGO As Double = 0
        Dim porcen_pendiente_cobro As Double = 0
        Dim porcen_pendiente_pago As Double = 0
        Try
            Dim fechas As String = txtFechas.Text
            Dim Codcli As String = txtCodCli.Text
            Dim matricula As String = txtMatricula.Text
            Dim agencia As String = ddlAgencias.SelectedValue

            dt = CapaDatos.Carga_Cobros_Pagos_Pendientes(fechas, Codcli, matricula, agencia)
            If dt.Rows.Count > 0 Then
                TOTAL_COMPRA = dt.Rows(0).Item("TOTAL_COMPRA")
                NUMPORTES_TOTAL_COMPRA = dt.Rows(0).Item("NUMPORTES_TOTAL_COMPRA")
                TOTAL_VENTA = dt.Rows(0).Item("TOTAL_VENTA")
                NUMPORTES_TOTAL_VENTA = dt.Rows(0).Item("NUMPORTES_TOTAL_VENTA")
                PENDIENTE_COBRO = dt.Rows(0).Item("PENDIENTE_COBRO")
                NUMPORTES_PENDIENTE_COBRO = dt.Rows(0).Item("NUMPORTES_PENDIENTE_COBRO")
                PENDIENTE_PAGO = dt.Rows(0).Item("PENDIENTE_PAGO")
                NUMPORTES_PENDIENTE_PAGO = dt.Rows(0).Item("NUMPORTES_PENDIENTE_PAGO")
            End If

            numtotalcompras.InnerText = FormatNumber(TOTAL_COMPRA, 2)
            'numtotalcompras_bar.Style.Add("width", "100%")
            numtotalcompras2.InnerText = "Total de Portes " & FormatNumber(NUMPORTES_TOTAL_COMPRA, 0)

            numtotalventas.InnerText = FormatNumber(TOTAL_VENTA, 2)
            numtotalventas1.InnerText = "Total de Portes " & FormatNumber(NUMPORTES_TOTAL_VENTA, 0)
            numtotalventas2.InnerText = "Beneficio:  " & FormatNumber(TOTAL_VENTA - TOTAL_COMPRA, 0) & " €"

            importependcobro.InnerText = FormatNumber(PENDIENTE_COBRO, 2)
            porcen_pendiente_cobro = NUMPORTES_PENDIENTE_COBRO * 100 / NUMPORTES_TOTAL_VENTA
            importependcobro2.InnerText = FormatNumber(NUMPORTES_PENDIENTE_COBRO, 0) & " portes pendientes cobro (" & FormatNumber(porcen_pendiente_cobro, 1) & "%)"
            importependcobro_bar.Style.Add("width", FormatNumber(porcen_pendiente_cobro, 1).Replace(",", ".") & "%")
            importependcobro_bar.InnerText = FormatNumber(porcen_pendiente_cobro, 1).Replace(",", ".") & "%"

            importepedpago.InnerText = FormatNumber(PENDIENTE_PAGO, 2)
            porcen_pendiente_pago = NUMPORTES_PENDIENTE_PAGO * 100 / NUMPORTES_TOTAL_COMPRA
            importepedpago2.InnerText = FormatNumber(NUMPORTES_PENDIENTE_PAGO, 0) & " portes pendientes pago (" & FormatNumber(porcen_pendiente_pago, 1) & "%)"
            importependpago_bar.Style.Add("width", FormatNumber(porcen_pendiente_pago, 1).Replace(",", ".") & "%")
            importependpago_bar.InnerText = FormatNumber(porcen_pendiente_pago, 1).Replace(",", ".") & "%"

            UpdatePanel2.Update()
        Catch ex As Exception
            Dim msg As String = "Error: " & ex.Message
        End Try

    End Sub
    Private Sub Carga_Grahp1()
        Dim dt As DataTable
        Dim jsonSerializer = New JavaScriptSerializer()
        Dim Data As String = String.Empty
        Dim dataList1 As List(Of GraphData1) = New List(Of GraphData1)

        Try
            Dim fechas As String = txtFechas.Text
            Dim Codcli As String = txtCodCli.Text
            Dim matricula As String = txtMatricula.Text
            Dim agencia As String = ddlAgencias.SelectedValue

            dt = CapaDatos.Get_NumPortes_LastYear(fechas, Codcli, matricula, agencia)
            If dt.Rows.Count > 0 Then
                For i = 0 To dt.Rows.Count - 1
                    Dim details As GraphData1 = New GraphData1()
                    details.y = objComun.Get_Mes_Letra(dt.Rows(i).Item("MES")) & " - " & dt.Rows(i).Item("YEAR")
                    details.item1 = CLng(dt.Rows(i).Item("Cuantos"))

                    dataList1.Add(details)
                Next
                Data = jsonSerializer.Serialize(dataList1)
            End If
        Catch ex As Exception
            Data = "Error: " & ex.Message
        End Try
        valuesGrahp1.Value = Data
    End Sub

    Private Sub Carga_Grahp2()
        Dim dt As DataTable
        Dim jsonSerializer = New JavaScriptSerializer()
        Dim Data As String = String.Empty
        Dim dataList2 As List(Of GraphData2) = New List(Of GraphData2)

        Try
            Dim fechas As String = txtFechas.Text
            Dim Codcli As String = txtCodCli.Text
            Dim matricula As String = txtMatricula.Text
            Dim agencia As String = ddlAgencias.SelectedValue

            dt = CapaDatos.Get_COMPRAS_VENTAS_LastYear(fechas, Codcli, matricula, agencia)
            If dt.Rows.Count > 0 Then
                For i = 0 To dt.Rows.Count - 1
                    Dim details As GraphData2 = New GraphData2()
                    details.y = objComun.Get_Mes_Letra(dt.Rows(i).Item("MES")) & " - " & dt.Rows(i).Item("YEAR")
                    details.item1 = CDbl(dt.Rows(i).Item("SumaVenta"))
                    details.item2 = CDbl(dt.Rows(i).Item("SumaCompra"))

                    dataList2.Add(details)
                Next
                Data = jsonSerializer.Serialize(dataList2)
            End If
        Catch ex As Exception
            Data = "Error: " & ex.Message
        End Try
        valuesGrahp2.Value = Data
    End Sub

    Private Sub Carga_Grahp3()
        Dim dt As DataTable
        Dim jsonSerializer = New JavaScriptSerializer()
        Dim Data As String = String.Empty
        Dim dataList3 As List(Of GraphData3) = New List(Of GraphData3)
        Dim beneficio As Double

        Try
            Dim fechas As String = txtFechas.Text
            Dim Codcli As String = txtCodCli.Text
            Dim matricula As String = txtMatricula.Text
            Dim agencia As String = ddlAgencias.SelectedValue

            dt = CapaDatos.Get_COMPRAS_VENTAS_LastYear(fechas, Codcli, matricula, agencia)
            If dt.Rows.Count > 0 Then
                For i = 0 To dt.Rows.Count - 1
                    Dim details As GraphData3 = New GraphData3()
                    details.label = objComun.Get_Mes_Letra(dt.Rows(i).Item("MES")) & " - " & dt.Rows(i).Item("YEAR")
                    beneficio = CDbl(dt.Rows(i).Item("SumaVenta")) - CDbl(dt.Rows(i).Item("SumaCompra"))
                    details.value = beneficio

                    dataList3.Add(details)
                Next
                Data = jsonSerializer.Serialize(dataList3)
            End If
        Catch ex As Exception
            Data = "Error: " & ex.Message
        End Try
        valuesGrahp3.Value = Data
    End Sub

    '<System.Web.Services.WebMethod()>
    'Public Shared Function Get_Estadisticas_Portes(ByVal Fecha As String) As String
    '    Dim CapaDatos As New CapaDatos
    '    Dim dt As DataTable
    '    Dim jsonSerializer = New JavaScriptSerializer()
    '    Dim Data As String = String.Empty
    '    Dim dataList1 As List(Of GraphData1) = New List(Of GraphData1)

    '    Try
    '        Dim fechas As String = txtFechas.Text
    '        Dim Codcli As String = txtCliente.Text
    '        Dim matricula As String = txtMatricula.Text
    '        Dim agencia As String = ddlAgencias.SelectedValue
    '        dt = CapaDatos.Get_NumPortes_LastYear(fechas, Codcli, matricula, agencia)
    '        If dt.Rows.Count > 0 Then
    '            For i = 0 To dt.Rows.Count - 1
    '                Dim details As GraphData1 = New GraphData1()
    '                details.y = dt.Rows(i).Item("MES")
    '                details.item1 = CLng(dt.Rows(i).Item("SumaCompra"))

    '                dataList1.Add(details)
    '            Next
    '            Data = jsonSerializer.Serialize(dataList1)
    '        End If
    '    Catch ex As Exception
    '        Data = "Error: " & ex.Message
    '    End Try

    '    'Dim dataList As List(Of GraphData) = New List(Of GraphData) From {New GraphData With {.y = "2011 Q1", .item1 = "2666"}, New GraphData With {.y = "2011 Q2", .item1 = "2778"}, New GraphData With {.y = "2011 Q3", .item1 = "4912"}, New GraphData With {.y = "2011 Q4", .item1 = "3767"}, New GraphData With {.y = "2012 Q1", .item1 = "6810"}, New GraphData With {.y = "2012 Q2", .item1 = "5670"}, New GraphData With {.y = "2012 Q3", .item1 = "4620"}, New GraphData With {.y = "2012 Q4", .item1 = "15073"}, New GraphData With {.y = "2013 Q1", .item1 = "10687"}, New GraphData With {.y = "2013 Q2", .item1 = "8432"}}
    '    Return Data
    'End Function

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

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        Try
            Carga_Estadisticas()
        Catch ex As Exception
            MuestraMensaje(ex.Message, 1, "ERROR")
        Finally
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "asddas", "ActualizaGraficos();", True)
        End Try
    End Sub
#Region "Funciones varias"
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
    Private Class GraphData1
        Public Property y As String
        Public Property item1 As Long
    End Class

    Private Class GraphData2
        Public Property y As String
        Public Property item1 As Double
        Public Property item2 As Double
    End Class

    Private Class GraphData3
        Public Property y As String
        Public Property label As String
        Public Property value As Double
    End Class
End Class
