Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.IO.FileMode
Imports System.Web.UI.WebControls
Imports Microsoft.Reporting.WebForms

Public Class VisorPDF
    Inherits System.Web.UI.Page
    Private CapaDatos As New CapaDatos
    Private objComun As New Comun
    Private DSFactura As New Factura

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim i As Long = 0
        Dim cadena As String = String.Empty
        Dim valor As Double = 0
        Try
            If Not Page.IsPostBack Then
                hdnFilePDF.Value = ""
                Session("DataSourceImpresion") = Nothing

                ReportViewer1.ProcessingMode = ProcessingMode.Local

                Dim localReport As LocalReport
                localReport = ReportViewer1.LocalReport

                '-------------------------------------------------
                'cargar el dataset con el datatable de los datos
                '-------------------------------------------------

                'Create a report data source for the sales order data  
                ''Dim dsSalesOrder As New ReportDataSource()
                ''dsSalesOrder.Name = "SalesOrder"
                ''dsSalesOrder.Value = dataset.Tables("SalesOrder")
                ''localReport.DataSources.Add(dsSalesOrder)

                Dim tipo As String = Request.QueryString("tipo")
                Dim id As String = Request.QueryString("id")

                Select Case tipo
                    Case "fac" ' Impresión de facturas
                        Dim datosempresa As DataTable = CapaDatos.Get_Datos_Empresa()
                        Dim ds As DataSet = CapaDatos.Get_Datos_Factura(id)
                        Dim dt As DataTable = ds.Tables(0)
                        Dim dtportes As DataTable = ds.Tables(1)
                        If dt.Rows.Count = 0 Then
                            MuestraMensaje("La Factura Nº " & id & " no se ha encontrado.", 1, "ERROR")
                        Else
                            If dtportes.Rows.Count = 0 Then
                                MuestraMensaje("No se han encontrado Portes correspondiente a la factura con id=" & id, 1, "ERROR")
                            Else
                                Dim cu As Integer = dtportes.Rows.Count
                                Dim dtValores As DataTable = DSFactura.Tables("DatosFactura")
                                For i = 0 To cu - 1
                                    Dim dr As DataRow = dtValores.NewRow
                                    dr("NombreEmpresa") = datosempresa.Rows(0).Item("RAZONSOCIAL")
                                    dr("DireccionEmpresa") = datosempresa.Rows(0).Item("DIRECCION")
                                    dr("PoblacionEmpresa") = datosempresa.Rows(0).Item("POBLACION")
                                    dr("CodpostalEmpresa") = datosempresa.Rows(0).Item("CODPOSTAL")
                                    cadena = "" & datosempresa.Rows(0).Item("CODPOSTAL")
                                    If cadena <> "" Then
                                        If cadena.Length >= 2 Then
                                            cadena = CapaDatos.Get_DesProvincia(Left(cadena, 2))
                                        End If
                                    End If
                                    dr("ProvinciaEmpresa") = cadena
                                    dr("TelefonoEmpresa") = datosempresa.Rows(0).Item("TELEFONO1")
                                    dr("CIFEmpresa") = datosempresa.Rows(0).Item("CIF")

                                    dr("FechaFactura") = "" & dt.Rows(0).Item("FECHA_FAC")
                                    dr("NumFactura") = dt.Rows(0).Item("NUMFAC")
                                    dr("FechaVencimiento") = "" & dt.Rows(0).Item("FECHA_VTO")
                                    dr("FormaPago") = "" & dt.Rows(0).Item("FORMA_PAGO")
                                    dr("ImporteBase") = dt.Rows(0).Item("BAS_IMPO_FAC")
                                    dr("DesRecargo") = "" & dt.Rows(0).Item("DES_RECARGO")
                                    dr("PorcenRecargo") = dt.Rows(0).Item("REC_EQUIV")
                                    dr("ImporteRecargo") = dt.Rows(0).Item("RECARGO")
                                    dr("DesDescuento") = "" & dt.Rows(0).Item("DES_DESCUENTO")
                                    dr("PorcenDescuento") = "" 'dt.Rows(0).Item("FECHA_FAC")
                                    dr("ImporteDescuento") = dt.Rows(0).Item("DESCUENTO")
                                    cadena = "" & datosempresa.Rows(0).Item("IVA")
                                    If cadena <> "" Then cadena = FormatNumber(cadena, 2)
                                    dr("PorcenIVA") = cadena
                                    dr("ImporteIVA") = dt.Rows(0).Item("IVA_FAC")
                                    dr("ImporteFactura") = dt.Rows(0).Item("IMPORTE_FAC")

                                    dr("NombreCliente") = "" & dt.Rows(0).Item("CLINOM")
                                    cadena = "" & dt.Rows(0).Item("CLIDIR")
                                    dr("DireccionCliente") = cadena
                                    dr("PoblacionCliente") = "" & dt.Rows(0).Item("CLIPOB")
                                    dr("CodPostalCliente") = "" & dt.Rows(0).Item("CLICODPOS")
                                    Dim desprovinciacli As String = "" & dt.Rows(0).Item("PROVINCIA")
                                    If desprovinciacli <> "" Then desprovinciacli = CapaDatos.Get_DesProvincia(desprovinciacli)
                                    dr("ProvinciaCliente") = desprovinciacli
                                    dr("CIFCliente") = "" & dt.Rows(0).Item("CLICIF")

                                    cadena = "" & dt.Rows(0).Item("CLINOM") & vbCrLf & dt.Rows(0).Item("CLIDIR") & vbCrLf & dt.Rows(0).Item("CLIPOB") & vbCrLf & dt.Rows(0).Item("CLICODPOS") & vbCrLf
                                    If dt.Rows(0).Item("CLIPOB").ToString.ToUpper() <> desprovinciacli.ToString.ToUpper() Then
                                        cadena += desprovinciacli.ToUpper() & vbCrLf
                                    End If
                                    cadena += "" & dt.Rows(0).Item("CLICIF")
                                    dr("DireccionCompletaCliente") = cadena

                                    cadena = "" & dtportes.Rows(i).Item("FECHA")
                                    'If cadena <> "" Then cadena = FormatDateTime(cadena, "dd/MM/yyyy").ToString()
                                    dr("FechaPorte") = cadena
                                    cadena = "" & dtportes.Rows(i).Item("DESTINO")
                                    dr("ConceptoPorte") = cadena
                                    dr("MatriculaPorte") = "" & dtportes.Rows(i).Item("MATRICULA")
                                    cadena = "" & dtportes.Rows(i).Item("PESO").ToString()
                                    If cadena = "" Or cadena = "0" Then cadena = "--"
                                    dr("MetrosPorte") = cadena
                                    dr("ImportePorte") = dtportes.Rows(i).Item("VENTA")

                                    dtValores.Rows.Add(dr)
                                Next

                                Session("DataSourceImpresion") = dtValores

                                localReport.ReportPath = Server.MapPath("~" & "/Reports/Factura.rdlc")
                                'Dim dataset As New DataSet("Factura")
                                'DataSet.Tables.Add(dtValores)
                                'If dataset.Tables.Count > 0 Then
                                Dim datasource As New ReportDataSource("DataSet1", dtValores)
                                ReportViewer1.LocalReport.DataSources.Clear()
                                ReportViewer1.LocalReport.DataSources.Add(datasource)

                                'Create a report parameter for the sales order number   
                                'Dim rpSalesOrderNumber As New ReportParameter()
                                'rpSalesOrderNumber.Name = "SalesOrderNumber"
                                'rpSalesOrderNumber.Values.Add("SO43661")

                                'Set the report parameters for the report  
                                'Dim parameters() As ReportParameter = {rpSalesOrderNumber}
                                'localReport.SetParameters(parameters)
                                'End If
                                Dim filename As String = "Factura_" & dt.Rows(0).Item("NUMFAC").replace("/", "-") & ".pdf"
                                CreatePDF("Reports/Factura.rdlc", "Facturas", filename)

                                Dim filepath As String = Server.MapPath("~" & "/Documentos/Facturas/") & filename
                                If File.Exists(filepath) = True Then
                                    hdnFilePDF.Value = "Documentos/Facturas/" & filename
                                End If
                            End If
                        End If
                    Case Else
                        MuestraMensaje("No se ha definido el tipo de documento a imprimir.", 1, "ERROR")
                End Select

            End If
        Catch ex As Exception
            MuestraMensaje("Se ha producido el siguiente Error: " & ex.Message, 1, "ERROR")
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

    Private Sub CreatePDF(ByVal fichero_rdlc As String, ByVal carpeta As String, ByVal fileName As String)
        Dim dtValores As DataTable
        If Session("DataSourceImpresion") IsNot Nothing Then
            dtValores = Session("DataSourceImpresion")

            ' Variables
            Dim warnings As Warning() = Nothing
            Dim streamIds As String() = Nothing
            Dim mimeType As String = String.Empty
            Dim Encoding As String = String.Empty
            Dim extension As String = String.Empty

            Dim datasource As New ReportDataSource("DataSet1", dtValores)
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.DataSources.Add(datasource)

            ' Setup the report viewer object And get the array of bytes
            Dim viewer As ReportViewer = New ReportViewer()
            viewer.ProcessingMode = ProcessingMode.Local
            viewer.LocalReport.ReportPath = Server.MapPath("~" & "/" & fichero_rdlc)
            viewer.LocalReport.DataSources.Add(datasource)

            Dim bytes As Byte() = viewer.LocalReport.Render("PDF", Nothing, mimeType, Encoding, extension, streamIds, warnings)

            Dim folder As String = Server.MapPath("~" & "/Documentos")
            If Directory.Exists(folder) = False Then
                Directory.CreateDirectory(folder)
            End If
            folder = folder & "/" & carpeta
            If Directory.Exists(folder) = False Then
                Directory.CreateDirectory(folder)
            End If
            Dim filepath As String = Server.MapPath("~" & "/Documentos/" & carpeta & "/") & fileName
            If File.Exists(filepath) = True Then
                File.Delete(filepath)
            End If

            Dim fs As FileStream = New FileStream(filepath, FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()

            If File.Exists(filepath) = True Then
                Process.Start(filepath)
                Response.ContentType = "Application/pdf"
                Response.WriteFile(filepath)
                Response.End()
            End If

            ' Now that you have all the bytes representing the PDF report, buffer it And send it to the client.
            'Response.Buffer = True
            'Response.Clear()
            'Response.ContentType = mimeType
            'Response.AddHeader("content-disposition", "attachment; filename=" + fileName + "." + extension)
            'Response.BinaryWrite(bytes) ' create the file
            'Response.Flush() ' send it To the client To download
        End If
    End Sub
End Class