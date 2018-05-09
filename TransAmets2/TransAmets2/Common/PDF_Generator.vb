Imports System.Net
Imports System.Web.Http
Imports System.IO
Imports Microsoft.Reporting.WebForms

Public Class PDF_Generator
    Public Sub New()
        DataSourceName = String.Empty
        DataSourceValue = Nothing
        ReportPath = String.Empty
        FileStorageLocation = String.Empty
    End Sub

    Public Function GetFile(ByVal reportType As String) As Byte()
        Dim warnings As Warning()
        Dim streamIds As String()
        Dim mimeType As String = String.Empty
        Dim encoding As String = String.Empty
        Dim extension As String = String.Empty
        Dim rds As ReportDataSource = New ReportDataSource(DataSourceName, DataSourceValue)
        Dim viewer As ReportViewer = New ReportViewer()
        viewer.ProcessingMode = ProcessingMode.Local
        viewer.LocalReport.ReportEmbeddedResource = ReportPath
        viewer.LocalReport.DataSources.Add(rds)
        Return viewer.LocalReport.Render(reportType, Nothing, mimeType, encoding, extension, streamIds, warnings)
    End Function

    Public Sub AutoSaveFile(ByVal type As ReportType, ByVal fileName As String)
        If Not String.IsNullOrEmpty(DataSourceName) AndAlso DataSourceValue IsNot Nothing AndAlso Not String.IsNullOrEmpty(ReportPath) AndAlso Not String.IsNullOrEmpty(FileStorageLocation) Then
            Dim file As Byte() = GetFile(type.ToString())
            Dim stream As FileStream = New FileStream(FileStorageLocation & "\" & fileName, FileMode.Create, FileAccess.Write)
            stream.Write(file, 0, file.Length)
            stream.Close()
        Else
            'MessageBox.Show("Required information missing before your file can be automatically processed", "Error creating requested file")
        End If
    End Sub

    'Public Sub SendToSaveDialog(ByVal type As ReportType, ByVal fileName As String)
    '    If Not String.IsNullOrEmpty(DataSourceName) AndAlso DataSourceValue IsNot Nothing AndAlso Not String.IsNullOrEmpty(ReportPath) Then
    '        Dim file As Byte() = GetFile(type.ToString())
    '        Dim stream As FileStream
    '        Dim dialog As SaveFileDialog = New SaveFileDialog()
    '        dialog.Filter = "All files (*.*)|*.*"
    '        dialog.RestoreDirectory = True
    '        dialog.FileName = fileName
    '        If dialog.ShowDialog() = DialogResult.OK Then
    '            If (__InlineAssignHelper(stream, CType(dialog.OpenFile(), FileStream))) IsNot Nothing Then
    '                stream.Write(file, 0, file.Length)
    '                stream.Close()
    '            End If
    '        End If
    '    Else
    '        'MessageBox.Show("Required information missing before your file can be processed", "Error creating requested file")
    '    End If
    'End Sub

    Public Property DataSourceName As String

    Public Property DataSourceValue As Object

    Public Property ReportPath As String

    Public Property FileStorageLocation As String

    Public Enum ReportType
        PDF
        Excel
        Word
    End Enum
End Class
