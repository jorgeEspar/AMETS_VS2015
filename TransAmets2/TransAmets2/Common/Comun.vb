Imports System
Imports System.Reflection
Imports System.Xml.Serialization
Imports System.Xml
Imports System.IO
Imports System.Text
Imports System.Drawing
Imports MySql.Data.MySqlClient

'============================================================================================================
'                               HISTORIAL DE LAS ACTUALIZACIONES
'                               --------------------------------
'
'   Fecha       Autor       Función/Sub             Descripción de la actualización
'   ----------  ----------  -------------------     --------------------------------------------------------------
'   2006-02-06  ???                                 Creado
'
'
'
'============================================================================================================

Public Class ErroresLlamadaAS400
    Inherits Exception
    Public Sub New()
    End Sub

    Public Sub New(message As String)
        MyBase.New(message)
    End Sub

    Public Sub New(message As String, inner As Exception)
        MyBase.New(message, inner)
    End Sub
End Class

Public Class FiltrosPrecios
    Private _FechaDesde As String = String.Empty
    Private _FechaHasta As String = String.Empty
    Private _CodCli As String = String.Empty
    Private _NombreCli As String = String.Empty
    Private _Matricula As String = String.Empty
    Private _CodAgencia As String = String.Empty
    Private _CodOrigen As String = String.Empty
    Private _CodDestino As String = String.Empty
    Private _DirCarga As String = String.Empty
    Private _DirDestino As String = String.Empty
    Private _Mercancia As String = String.Empty
    Private _Peso As String = String.Empty
    Private _TipoCamion As String = String.Empty
    Private _Volumen As String = String.Empty
    Private _Pagina As Integer = 1

    Public Sub New()
    End Sub
    Property Pagina() As Integer
        Get
            Return _Pagina
        End Get
        Set(ByVal value As Integer)
            _Pagina = value
        End Set
    End Property
    Property FechaDesde() As String
        Get
            Return _FechaDesde
        End Get
        Set(ByVal value As String)
            _FechaDesde = value
        End Set
    End Property
    Property FechaHasta() As String
        Get
            Return _FechaHasta
        End Get
        Set(ByVal value As String)
            _FechaHasta = value
        End Set
    End Property
    Property CodCli() As String
        Get
            Return _CodCli
        End Get
        Set(ByVal value As String)
            _CodCli = value
        End Set
    End Property
    Property NombreCli() As String
        Get
            Return _NombreCli
        End Get
        Set(ByVal value As String)
            _NombreCli = value
        End Set
    End Property
    Property Matricula() As String
        Get
            Return _Matricula
        End Get
        Set(ByVal value As String)
            _Matricula = value
        End Set
    End Property
    Property CodAgencia() As String
        Get
            Return _CodAgencia
        End Get
        Set(ByVal value As String)
            _CodAgencia = value
        End Set
    End Property
    Property CodOrigen() As String
        Get
            Return _CodOrigen
        End Get
        Set(ByVal value As String)
            _CodOrigen = value
        End Set
    End Property
    Property CodDestino() As String
        Get
            Return _CodDestino
        End Get
        Set(ByVal value As String)
            _CodDestino = value
        End Set
    End Property
    Property DirCarga() As String
        Get
            Return _DirCarga
        End Get
        Set(ByVal value As String)
            _DirCarga = value
        End Set
    End Property
    Property DirDestino() As String
        Get
            Return _DirDestino
        End Get
        Set(ByVal value As String)
            _DirDestino = value
        End Set
    End Property
    Property Mercancia() As String
        Get
            Return _Mercancia
        End Get
        Set(ByVal value As String)
            _Mercancia = value
        End Set
    End Property
    Property Peso() As String
        Get
            Return _Peso
        End Get
        Set(ByVal value As String)
            _Peso = value
        End Set
    End Property
    Property TipoCamion() As String
        Get
            Return _TipoCamion
        End Get
        Set(ByVal value As String)
            _TipoCamion = value
        End Set
    End Property
    Property Volumen() As String
        Get
            Return _Volumen
        End Get
        Set(ByVal value As String)
            _Volumen = value
        End Set
    End Property
End Class
Public Class FiltrosPrePortes
    Private _FechaDesde As String = String.Empty
    Private _FechaHasta As String = String.Empty
    Private _FechaEntregaDesde As String = String.Empty
    Private _FechaEntregaHasta As String = String.Empty
    Private _CodCli As String = String.Empty
    Private _NombreCli As String = String.Empty
    Private _Matricula As String = String.Empty
    Private _CodAgencia As String = String.Empty
    Private _DirCarga As String = String.Empty
    Private _DirDestino As String = String.Empty
    Private _Mercancia As String = String.Empty
    Private _Estado As String = String.Empty
    Private _Pagina As Integer = 1

    Public Sub New()
    End Sub
    Property Pagina() As Integer
        Get
            Return _Pagina
        End Get
        Set(ByVal value As Integer)
            _Pagina = value
        End Set
    End Property
    Property FechaDesde() As String
        Get
            Return _FechaDesde
        End Get
        Set(ByVal value As String)
            _FechaDesde = value
        End Set
    End Property
    Property FechaHasta() As String
        Get
            Return _FechaHasta
        End Get
        Set(ByVal value As String)
            _FechaHasta = value
        End Set
    End Property
    Property FechaEntregaDesde() As String
        Get
            Return _FechaEntregaDesde
        End Get
        Set(ByVal value As String)
            _FechaEntregaDesde = value
        End Set
    End Property
    Property FechaEntregaHasta() As String
        Get
            Return _FechaEntregaHasta
        End Get
        Set(ByVal value As String)
            _FechaEntregaHasta = value
        End Set
    End Property
    Property CodCli() As String
        Get
            Return _CodCli
        End Get
        Set(ByVal value As String)
            _CodCli = value
        End Set
    End Property
    Property NombreCli() As String
        Get
            Return _NombreCli
        End Get
        Set(ByVal value As String)
            _NombreCli = value
        End Set
    End Property
    Property Matricula() As String
        Get
            Return _Matricula
        End Get
        Set(ByVal value As String)
            _Matricula = value
        End Set
    End Property
    Property CodAgencia() As String
        Get
            Return _CodAgencia
        End Get
        Set(ByVal value As String)
            _CodAgencia = value
        End Set
    End Property
    Property DirCarga() As String
        Get
            Return _DirCarga
        End Get
        Set(ByVal value As String)
            _DirCarga = value
        End Set
    End Property
    Property DirDestino() As String
        Get
            Return _DirDestino
        End Get
        Set(ByVal value As String)
            _DirDestino = value
        End Set
    End Property
    Property Mercancia() As String
        Get
            Return _Mercancia
        End Get
        Set(ByVal value As String)
            _Mercancia = value
        End Set
    End Property
    Property Estado() As String
        Get
            Return _Estado
        End Get
        Set(ByVal value As String)
            _Estado = value
        End Set
    End Property
End Class
Public Class FiltrosPortes
    Private _FechaDesde As String = String.Empty
    Private _FechaHasta As String = String.Empty
    Private _FechaEntregaDesde As String = String.Empty
    Private _FechaEntregaHasta As String = String.Empty
    Private _CodCli As String = String.Empty
    Private _NombreCli As String = String.Empty
    Private _Matricula As String = String.Empty
    Private _CodAgencia As String = String.Empty
    Private _DirCarga As String = String.Empty
    Private _DirDestino As String = String.Empty
    Private _Mercancia As String = String.Empty
    Private _Estado As String = String.Empty
    Private _Pagina As Integer = 1

    Public Sub New()
    End Sub
    Property Pagina() As Integer
        Get
            Return _Pagina
        End Get
        Set(ByVal value As Integer)
            _Pagina = value
        End Set
    End Property
    Property FechaDesde() As String
        Get
            Return _FechaDesde
        End Get
        Set(ByVal value As String)
            _FechaDesde = value
        End Set
    End Property
    Property FechaHasta() As String
        Get
            Return _FechaHasta
        End Get
        Set(ByVal value As String)
            _FechaHasta = value
        End Set
    End Property
    Property FechaEntregaDesde() As String
        Get
            Return _FechaEntregaDesde
        End Get
        Set(ByVal value As String)
            _FechaEntregaDesde = value
        End Set
    End Property
    Property FechaEntregaHasta() As String
        Get
            Return _FechaEntregaHasta
        End Get
        Set(ByVal value As String)
            _FechaEntregaHasta = value
        End Set
    End Property
    Property CodCli() As String
        Get
            Return _CodCli
        End Get
        Set(ByVal value As String)
            _CodCli = value
        End Set
    End Property
    Property NombreCli() As String
        Get
            Return _NombreCli
        End Get
        Set(ByVal value As String)
            _NombreCli = value
        End Set
    End Property
    Property Matricula() As String
        Get
            Return _Matricula
        End Get
        Set(ByVal value As String)
            _Matricula = value
        End Set
    End Property
    Property CodAgencia() As String
        Get
            Return _CodAgencia
        End Get
        Set(ByVal value As String)
            _CodAgencia = value
        End Set
    End Property
    Property DirCarga() As String
        Get
            Return _DirCarga
        End Get
        Set(ByVal value As String)
            _DirCarga = value
        End Set
    End Property
    Property DirDestino() As String
        Get
            Return _DirDestino
        End Get
        Set(ByVal value As String)
            _DirDestino = value
        End Set
    End Property
    Property Mercancia() As String
        Get
            Return _Mercancia
        End Get
        Set(ByVal value As String)
            _Mercancia = value
        End Set
    End Property
    Property Estado() As String
        Get
            Return _Estado
        End Get
        Set(ByVal value As String)
            _Estado = value
        End Set
    End Property
End Class

Public Class FiltrosFacturas
    Private _NumeroFactura As String = String.Empty
    Private _FechaDesde As String = String.Empty
    Private _FechaHasta As String = String.Empty
    Private _CodCli As String = String.Empty
    Private _NombreCli As String = String.Empty
    Private _Estado As String = String.Empty
    Private _Pagina As Integer = 1

    Public Sub New()
    End Sub
    Property Pagina() As Integer
        Get
            Return _Pagina
        End Get
        Set(ByVal value As Integer)
            _Pagina = value
        End Set
    End Property
    Property NumeroFactura() As String
        Get
            Return _NumeroFactura
        End Get
        Set(ByVal value As String)
            _NumeroFactura = value
        End Set
    End Property
    Property FechaDesde() As String
        Get
            Return _FechaDesde
        End Get
        Set(ByVal value As String)
            _FechaDesde = value
        End Set
    End Property
    Property FechaHasta() As String
        Get
            Return _FechaHasta
        End Get
        Set(ByVal value As String)
            _FechaHasta = value
        End Set
    End Property
    Property CodCli() As String
        Get
            Return _CodCli
        End Get
        Set(ByVal value As String)
            _CodCli = value
        End Set
    End Property
    Property NombreCli() As String
        Get
            Return _NombreCli
        End Get
        Set(ByVal value As String)
            _NombreCli = value
        End Set
    End Property
    Property Estado() As String
        Get
            Return _Estado
        End Get
        Set(ByVal value As String)
            _Estado = value
        End Set
    End Property
End Class
Public Class Comun
    Inherits System.Web.UI.Page

    Public usr As String = String.Empty
    Public pwd As String = String.Empty



#Region "Gestión de los desplegables"

    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' Procedimiento que a partir de una tabla llena un desplegable.
    ''' </summary>
    ''' <param name="tabla">DataTable</param>
    ''' <param name="combo">DropDownList</param>
    ''' <remarks>
    ''' </remarks>
    ''' <history>
    ''' 	[Tecnoconsulting]	06/02/2006	Created
    ''' </history>
    ''' -----------------------------------------------------------------------------
    Public Overloads Sub PintaCombo(ByVal tabla As DataTable, ByVal combo As DropDownList, Optional ByVal opDefecto As String = "", Optional ByVal separacion As String = "", Optional ByVal valorDefecto As String = "", Optional ByVal primeraOpcion As Boolean = True)
        Dim opciones As Integer = tabla.Rows.Count
        If Not opciones = 1 Then
            If separacion = "" Then
                separacion = "---------------"
            End If
            If opDefecto = "" Then
                'opDefecto = escribeTexto("seleccioneUnaOpcion")
            End If
        End If

        combo.DataSource = tabla
        If tabla.Rows.Count > 0 Then
            combo.DataValueField = tabla.Columns(0).ColumnName
            combo.DataTextField = tabla.Columns(1).ColumnName
        End If
        combo.DataBind()

        If primeraOpcion And opciones > 1 Then
            combo.Items.Insert(0, separacion & " " & opDefecto & " " & separacion)
            If valorDefecto = "" Then
                combo.Items(0).Value = ""
            Else
                combo.Items(0).Value = valorDefecto
            End If
        End If

    End Sub

    Public Overloads Sub PintaCombo(ByVal tabla As DataTable, ByVal combo As DropDownList, ByVal primeraOpcion As Boolean, Optional ByVal opDefecto As String = "", Optional ByVal separacion As String = "", Optional ByVal valorDefecto As String = "")
        If primeraOpcion Then
            If separacion = "" Then
                separacion = "---------------"
            End If
            If opDefecto = "" Then
                'opDefecto = escribeTexto("seleccioneUnaOpcion")
            End If
        End If

        combo.DataSource = tabla
        If tabla.Rows.Count > 0 Then
            combo.DataValueField = tabla.Columns(0).ColumnName
            combo.DataTextField = tabla.Columns(1).ColumnName
        End If
        combo.DataBind()

        If primeraOpcion Then
            combo.Items.Insert(0, separacion & " " & opDefecto & " " & separacion)
            If valorDefecto = "" Then
                combo.Items(0).Value = ""
            Else
                combo.Items(0).Value = valorDefecto
            End If
        End If

    End Sub

    Public Overloads Sub PintaComboTodos(ByVal tabla As DataTable, ByVal combo As DropDownList, Optional ByVal opDefecto As String = "", Optional ByVal separacion As String = "", Optional ByVal valorDefecto As String = "", Optional ByVal primeraOpcion As Boolean = True)
        Dim opciones As Integer = tabla.Rows.Count
        If separacion = "" Then
            separacion = "---------------"
        End If
        If opDefecto = "" Then
            'opDefecto = escribeTexto("Todos")
        End If

        combo.DataSource = tabla
        If tabla.Rows.Count > 0 Then
            combo.DataValueField = tabla.Columns(0).ColumnName
            combo.DataTextField = tabla.Columns(1).ColumnName
        End If
        combo.DataBind()

        If primeraOpcion And opciones > 1 Then
            combo.Items.Insert(0, separacion & " " & opDefecto & " " & separacion)
            If valorDefecto = "" Then
                combo.Items(0).Value = ""
            Else
                combo.Items(0).Value = valorDefecto
            End If
        End If


    End Sub


    '''///////////////////////////////////////////////////////////////////////////////////
    ''' Archivo     : Comun.vb                             //
    ''' Application : Comun                                        //
    ''' Description : CargarComboDia carga el combo que se le pasa como parametro con los 
    ''' dias del 1 al 31                                                                   //
    ''' Parametros  :  cbo->combo a cargar, todos boolean para incluir si se incluye la clausula todos o no, 
    ''' valortodos es el valor que devolvera el combo con la seleccion de todos                                                                  //
    ''' Retorno     :  el combo cargado                                                 //
    ''' Historial   :                                                                   //
    '''     Creado 19/03/2007                               //
    '''///////////////////////////////////////////////////////////////////////////////////

    Public Sub CargarComboDia(ByVal cbo As System.Web.UI.WebControls.DropDownList, ByVal todos As Boolean, ByVal valortodos As String)
        Dim i As Integer
        'If todos Then
        '    cbo.Items.Add(New System.Web.UI.WebControls.ListItem("31", valortodos))
        'End If
        For i = 1 To 31
            cbo.Items.Add(New System.Web.UI.WebControls.ListItem(i, formatearcadena(i.ToString, 2, "0")))
        Next
    End Sub

    '''///////////////////////////////////////////////////////////////////////////////////
    ''' Archivo     : Comun.vb                             //
    ''' Application : Comun                                        //
    ''' Description : CargarComboMes carga el combo que se le pasa como parametro con los 
    ''' meses                                                                  //
    ''' Parametros  :  cbo->combo a cargar, todos boolean para incluir si se incluye la clausula todos o no, 
    ''' valortodos es el valor que devolvera el combo con la seleccion de todos                                                                  //
    ''' Retorno     :  el combo cargado                                                 //
    ''' Historial   :                                                                   //
    '''     Creado 19/03/2007                               //
    '''///////////////////////////////////////////////////////////////////////////////////

    Public Sub CargarComboMes(ByVal cbo As System.Web.UI.WebControls.DropDownList, ByVal todos As Boolean, ByVal valortodos As String)
        'Rellenamos el combo de meses
        'If todos Then
        '   cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Diciembre}", valortodos))
        'End If
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Enero}", "01"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Febrero}", "02"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Marzo}", "03"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Abril}", "04"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Mayo}", "05"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Junio}", "06"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Julio}", "07"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Agosto}", "08"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Septiembre}", "09"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Octubre}", "10"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Noviembre}", "11"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Diciembre}", "12"))
    End Sub


    '''///////////////////////////////////////////////////////////////////////////////////
    ''' Archivo     : Comun.vb                             //
    ''' Application : Comun                                        //
    ''' Description : CargarComboAnio carga el combo que se le pasa como parametro con los 
    ''' años dentro del rago [añoactual-rango,añoactual+rango]                                                                 //
    ''' Parametros  :  cbo->combo a cargar, rango entero,todos boolean para incluir si se incluye la clausula todos o no, 
    ''' valortodos es el valor que devolvera el combo con la seleccion de todos                                                                  //
    ''' Retorno     :  el combo cargado                                                 //
    ''' Historial   :                                                                   //
    '''     Creado 19/03/2007                               //
    '''///////////////////////////////////////////////////////////////////////////////////

    Public Sub CargarComboAnio(ByVal cbo As System.Web.UI.WebControls.DropDownList, ByVal rango As Integer, ByVal todos As Boolean, ByVal valortodos As String)
        Dim i As Integer
        Dim iInityear As Integer
        Dim iFinallyear As Integer
        'If todos Then
        '    cbo.Items.Add(New System.Web.UI.WebControls.ListItem("9999", valortodos))
        'End If
        iInityear = Now.Year - rango
        iFinallyear = Now.Year + rango
        For i = iInityear To iFinallyear
            cbo.Items.Add(i)
        Next
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("9999", "9999"))
        cbo.SelectedValue = Now.Year
    End Sub

    '''///////////////////////////////////////////////////////////////////////////////////
    ''' Archivo     : Comun.vb                             //
    ''' Application : Comun                                        //
    ''' Description : CargarComboNivel carga el combo que se le pasa como parametro                                           //
    ''' Parametros  :  cbo->combo a cargar                                               //
    ''' Retorno     :  el combo cargado                                                 //
    ''' Historial   :                                                                   //
    '''     Creado 19/03/2007                               //
    '''///////////////////////////////////////////////////////////////////////////////////

    Public Sub CargarComboNivel(ByVal cbo As System.Web.UI.WebControls.DropDownList)
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("-- {_SeleccioneUnaOpcion} --", "S_0"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Tarifa}", "T_4"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_GrupodeConcesionario}", "G_4"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Concesionario}", "C_4"))
        cbo.Items.Add(New System.Web.UI.WebControls.ListItem("{_Contrato}", "O_9"))
    End Sub

#End Region

#Region "Gestor de Errores."

    'Enumeración con los codigos de error.
    Public Enum ERROR_GRAVEDAD
        Err_Leve = 2
        Err_Grave = 1
    End Enum


    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="ObjTabla"></param>
    ''' <remarks>
    ''' </remarks>
    ''' <history>
    ''' 	[Tecnoconsulting]	10/10/2006	Created
    ''' </history>
    ''' -----------------------------------------------------------------------------
    Public Sub PonerObjBlancos(ByVal ObjTabla As HtmlTable)

        Try

            For i As Integer = 0 To ObjTabla.Rows.Count - 1
                For j As Integer = 0 To ObjTabla.Rows(i).Cells.Count - 1
                    For Each MiControl As Control In ObjTabla.Rows(i).Cells(j).Controls
                        If TypeOf MiControl Is System.Web.UI.WebControls.Table Then
                            Me.PonerObjBlancos(MiControl)
                        ElseIf TypeOf MiControl Is TextBox Or TypeOf MiControl Is DropDownList Then
                            DirectCast(MiControl, WebControl).BackColor = Color.White
                            DirectCast(MiControl, WebControl).ToolTip = String.Empty
                        End If
                    Next
                Next
            Next

        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="ObjTabla"></param>
    ''' <remarks>
    ''' </remarks>
    ''' <history>
    ''' 	[Tecnoconsulting]	10/10/2006	Created
    ''' </history>
    ''' -----------------------------------------------------------------------------
    Public Sub PonerObjBlancos2(ByVal ObjTabla As System.Web.UI.WebControls.Table)

        Try

            For i As Integer = 0 To ObjTabla.Rows.Count - 1
                For j As Integer = 0 To ObjTabla.Rows(i).Cells.Count - 1
                    For Each MiControl As Control In ObjTabla.Rows(i).Cells(j).Controls
                        If TypeOf MiControl Is System.Web.UI.WebControls.Table Then
                            Me.PonerObjBlancos2(MiControl)
                        ElseIf TypeOf MiControl Is TextBox Or TypeOf MiControl Is DropDownList Then
                            DirectCast(MiControl, WebControl).BackColor = Color.White
                            DirectCast(MiControl, WebControl).ToolTip = String.Empty
                        End If
                    Next
                Next
            Next

        Catch ex As Exception
            Throw ex
        End Try

    End Sub
#End Region

#Region "Comprobación seguridad"
    Public Function validarSession(ByVal idPagina As String) As Boolean
        If Not IsNothing(Session("usr")) And Not IsNothing(Session("pwd")) Then
            If Session("usr") <> "" And Session("pwd") <> "" Then
                Return True
            End If
        End If

        Return False
    End Function
#End Region

#Region "Formateo de Fechas (hay para todos los gustos)"

    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' Metodo que convierte una cadena con formato fecha, al formato de fecha que maneja 400 (yyyyMMdd)
    ''' </summary>
    ''' <param name="strFecha">Cadena cliente en formato fecha</param>
    ''' <returns>Cadena en formato fecha 400</returns>
    ''' <remarks></remarks>
    ''' <history>
    ''' 	Héctor Soto Arévalo
    ''' </history>
    ''' -----------------------------------------------------------------------------
    Public Function FormatearFecha400(ByVal strFecha As String) As String

        If Not strFecha.Trim().Equals(String.Empty) Then
            Dim dt As Date
            dt = Convert.ToDateTime(strFecha)

            Return dt.Year.ToString() & dt.Month.ToString().PadLeft(2, "0") & dt.Day.ToString().PadLeft(2, "0")
        Else
            Return String.Empty
        End If

    End Function
    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' Metodo que convierte una cadena con formato fecha (1-4-2013), al formato de fecha dd/MM/yyyy y de tipo Date para visualizar por ejemplo en los GridView
    ''' </summary>
    ''' <param name="strFecha">Cadena cliente en formato fecha</param>
    ''' <returns>Cadena en formato fecha dd/MM/yyyy de tipo Date</returns>
    ''' <remarks></remarks>
    ''' <history>
    ''' 	Jorge Espartero
    ''' </history>
    ''' -----------------------------------------------------------------------------
    Public Function FormatearFechaToNet(ByVal strFecha As String) As Date

        If Not strFecha.Trim().Equals(String.Empty) Then
            Dim dt As Date
            dt = Convert.ToDateTime(strFecha)

            Return Convert.ToDateTime(dt.Day.ToString().PadLeft(2, "0") & "/" & dt.Month.ToString().PadLeft(2, "0") & "/" & dt.Year.ToString())
        Else
            Return String.Empty
        End If

    End Function

    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' Método que convierte la fecha en formato 400, a una cadena cliente con formato de fecha (dd/MM/yyyy)
    ''' </summary>
    ''' <param name="strFecha">Cadena de 400 que contiene la fecha</param>
    ''' <returns>Cadena con la fecha formateada</returns>
    ''' <remarks>
    ''' </remarks>
    ''' <history>
    ''' 	Héctor Soto Arévalo
    ''' </history>
    ''' -----------------------------------------------------------------------------
    Public Function FormatearFecha(ByVal strFecha As String) As String
        Dim str As String = String.Empty

        If Not strFecha.Trim().Equals(String.Empty) Then
            str = strFecha.Substring(6, 2) & "/" & strFecha.Substring(4, 2) & "/" & strFecha.Substring(0, 4)
        End If

        Return str

    End Function

    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' Método que convierte la fecha en el formato que se le indique
    ''' </summary>
    ''' <param name="strFecha">Cadena que contiene la fecha</param>
    ''' <param name="strformato">Formato al que se desea convertir</param>
    ''' <remarks>
    ''' </remarks>
    ''' <history>
    ''' </history>
    ''' -----------------------------------------------------------------------------
    Public Function FormateaFecha(ByVal strFecha As String, ByVal strformato As String) As String
        Dim strCadFec As String
        Dim dt As Date
        If strFecha <> String.Empty And strFecha <> "0" Then
            If strFecha.IndexOf("/") > 0 Then
                strCadFec = strFecha
            Else
                strCadFec = strFecha.Substring(6, 2) & "/" & strFecha.Substring(4, 2) & "/" & strFecha.Substring(0, 4)
            End If

            If IsDate(strCadFec) Then
                dt = CDate(strCadFec)
                Return dt.ToString(strformato)
            Else
                Return ""
            End If
        Else
            Return ""
        End If
    End Function

    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="strfecha"></param>
    ''' <param name="FechaInvertida"></param>
    ''' <returns></returns>
    ''' <remarks>
    ''' </remarks>
    ''' <history>
    ''' 	[Tecnoconsulting]	10/10/2006	Created
    ''' </history>
    ''' -----------------------------------------------------------------------------
    Public Function FormatearFecha(ByVal strfecha As String, ByVal FechaInvertida As Boolean) As String

        If Not strfecha.Trim().Equals(String.Empty) Then
            If strfecha.Length = 7 Then
                strfecha = strfecha.PadLeft(8, "0")
            End If
            If FechaInvertida Then
                'AAAAMMDD
                Return strfecha.Substring(6, 2) & "/" & strfecha.Substring(4, 2) & "/" & strfecha.Substring(0, 4)
            Else
                'DDMMAAAA
                Return strfecha.Substring(0, 2) & "/" & strfecha.Substring(2, 2) & "/" & strfecha.Substring(4, 4)
            End If
        Else
            Return String.Empty
        End If

    End Function

#End Region

    '''////////////////////////////////////////////////////////////////////////////////////
    ''' Archivo     : Comun.vb                                                           //
    ''' Application : Contratos                                                          //
    ''' Description :  Funcion que recibiendo una cadena, una longitud y un caracter completa 
    '''                la cadena con el caracter hasta alcanzar la longitud              //
    ''' Parametros  :                                                                    //
    ''' Retorno     :                                                                    //
    ''' Historial   :                                                                    //
    '''     Creado 23/03/2007                               //
    '''///////////////////////////////////////////////////////////////////////////////////
    Public Function formatearcadena(ByVal cadena As String, ByVal l As Integer, ByVal relleno As String) As String
        'Dim i As Integer
        Do While cadena.Length < l
            cadena = relleno + cadena
        Loop
        Return cadena
    End Function

    Public Function FormatearHora(ByVal strhora As String) As Date
        strhora = strhora.Trim.PadLeft(8, "0")
        If Not strhora.Equals("00000000") Then
            Dim hora As Date = New Date(0)
            hora = hora.AddHours(CInt(strhora.Substring(0, 2)))
            hora = hora.AddMinutes(CInt(strhora.Substring(2, 2)))
            hora = hora.AddSeconds(CInt(strhora.Substring(4, 2)))
            hora = hora.AddMilliseconds(CInt(strhora.Substring(6, 2)))
            Return hora
        Else
            Return Nothing
        End If
    End Function


    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' Función que inserta clave y contraseña en la cabecera de un web service
    ''' </summary>
    ''' <returns>AuthHeader</returns>
    ''' <remarks>
    ''' </remarks>
    ''' <history>
    ''' 	[Tecnoconsulting]	06/02/2006	Created
    ''' </history>
    ''' -----------------------------------------------------------------------------
    Public Function PonerCabecera(ByVal objWSH As Object) As Object
        objWSH.Username = Session("usr")
        objWSH.Password = Session("pwd")
        objWSH.Lang = Session("lang")
        objWSH.Aplica = System.Configuration.ConfigurationManager.AppSettings("numAplica")
        objWSH.SessionId = Session.SessionID
        objWSH.IP = String.Empty
        objWSH.Libreria = System.Configuration.ConfigurationManager.AppSettings("Libreria")
        PonerCabecera = objWSH
    End Function


#Region "Acciones sobre los botones y control del foco"

    ''' <summary>
    '''     Esto cambia el Foco a un Control, da igual su tipo. 
    ''' </summary>
    ''' <param name="ctr">
    '''     Este es el control a establecer su Foco puede ser de tipo HtmlControl o WebControl. <br />
    '''     Si este valor es 'Nothing', eliminara la referencia del foco establecida anteriormente.
    ''' </param>
    ''' <history>
    ''' 	Daniel Lazo, Manuel Soler
    ''' </history>
    Public Overloads Sub SetFocus(ByVal ctr As Control)
        'recupera el formulario que se esta procesando (o el que lo llamó)
        Dim pagina As System.Web.UI.Page = DirectCast(HttpContext.Current.Handler, System.Web.UI.Page)
        Dim form As System.Web.UI.HtmlControls.HtmlForm = Me.BuscaDefaultForm()
        Dim controlName As String = String.Empty
        Try
            If TypeOf ctr Is System.Web.UI.HtmlControls.HtmlControl Then
                controlName = DirectCast(ctr, System.Web.UI.HtmlControls.HtmlControl).ClientID
            ElseIf TypeOf ctr Is System.Web.UI.WebControls.WebControl Then
                controlName = DirectCast(ctr, System.Web.UI.WebControls.WebControl).ClientID
            ElseIf ctr Is Nothing Then 'borrado de foco
                controlName = String.Empty
            Else
                controlName = Nothing
            End If
        Catch
            controlName = Nothing
        End Try

        If Not controlName Is Nothing Then
            Const NOMBRECONTROL As String = "__FOCUSHIDDEN"
            Dim focusControl As System.Web.UI.HtmlControls.HtmlInputHidden = pagina.FindControl(NOMBRECONTROL)
            If focusControl Is Nothing Then ' Se comprueba que el control existe, sino se crea
                focusControl = New System.Web.UI.HtmlControls.HtmlInputHidden
                focusControl.ID = NOMBRECONTROL
                If form Is Nothing Then
                    pagina.Controls.AddAt(1, focusControl)
                Else
                    form.Controls.Add(focusControl)
                End If
            End If
            focusControl.Value = controlName ' Introduce en el campo oculto el control a meter el foco, para luego recuperarlo con el script
            pagina.ClientScript.RegisterStartupScript(pagina.GetType, "SetFocus", "<script language=""javascript""> try{ " &
            "var focoControl = document.all." & NOMBRECONTROL & ";" &
            "if (focoControl && typeof(focoControl.value) != ""undefined"") " &
            "if (focoControl.value.length > 0) { document.all(focoControl.value).focus();}} catch(err){} </script>")
        Else
            ' Se causa una excepcion en caso de que no se localize el tipo de control
            Throw New ArgumentException("El Control debe de ser de tipo System.Web.UI.HtmlControls.HtmlControl o System.Web.UI.WebControls.WebControl", "SetFocus")
        End If
    End Sub


    ''' <summary>
    '''     Establece el Botón por defecto de la página, puede ser por ejemplo un Botón.
    ''' </summary>
    ''' <param name="ctr">
    '''     Este es el control a establecer por defecto en la página, puede ser de tipo HtmlControl o WebControl. <br />
    '''     Si este valor es 'Nothing', eliminara el atributo de la accion desencadenante.
    ''' </param>
    ''' <remarks>
    '''     NOTA: Se recomienda ponerlo en el pageload, fuera del "not ispostback". <br />
    '''     NOTA2: El desencadenate de 'TieButton' tiene mas prioridad que esta, osea que la sobreescribe. <br />
    '''     USAR en Pagina: &lt;script language="javascript" src="../Common/js/comportamientos.js"&gt;&lt;/script&gt;    
    ''' </remarks>
    ''' <history>
    ''' 	Daniel Lazo, Manuel Soler
    ''' </history>
    Public Sub SetDefaultControl(ByVal ctr As Control)
        'recupera el formulario que se esta procesando (o el que lo llamó)
        Dim form As System.Web.UI.HtmlControls.HtmlForm = Me.BuscaDefaultForm()
        If Not (form Is Nothing) Then
            TieButton(form, ctr)
        Else
            ' Se causa una excepcion en caso de que no se localize el tipo de control
            Throw New ArgumentException("No existe formulario por defecto o no se puede convertir para establecer el evento.", "SetDefaultControl")
        End If
    End Sub

    ''' <summary>
    '''     Esto enlaza a un control (por ejemplo TextBox) un boton. 
    ''' </summary>
    ''' <param name="TextBoxToTie">
    '''     Este es el textbox para enlazar. Si no es un Control TextBox, puede derivar de HtmlControl o WebControl, y el Control Html debe aceptar el atributo 'onkeydown'. <br />
    '''     Si este valor es 'Nothing', eliminara el atributo de la accion desencadenante.
    ''' </param>
    ''' <param name="ButtonToTie">
    '''     Este en el Boton a enlazar. Necesitamos de el su ClientID. El tag Html se renderiza en el atributo click()
    ''' </param>
    ''' <history>
    ''' 	Daniel Lazo, Manuel Soler
    ''' </history>
    ''' <remarks>
    '''     NOTA: Se recomienda ponerlo en el pageload, fuera del "not ispostback". <br />
    '''     USAR en Pagina: &lt;script language="javascript" src="../Common/js/comportamientos.js"&gt;&lt;/script&gt;    
    ''' </remarks>
    Public Sub TieButton(ByVal TextBoxToTie As Control, ByVal ButtonToTie As Control)
        'Atacaremos el evento onmousedown del atributo.
        Dim attrib As System.Web.UI.AttributeCollection = Nothing
        ''Esto es para segurarnos que se carga comportamientos
        'Dim form As System.Web.UI.HtmlControls.HtmlForm = Me.BuscaDefaultForm()
        'If Not (form Is Nothing) Then
        '    form.Page.RegisterClientScriptBlock("CompJS", "<script language=""javascript"" src=""../Common/js/comportamientos.js""></script>")
        'End If
        If TypeOf TextBoxToTie Is System.Web.UI.HtmlControls.HtmlControl Then
            attrib = DirectCast(TextBoxToTie, System.Web.UI.HtmlControls.HtmlControl).Attributes
        ElseIf TypeOf TextBoxToTie Is System.Web.UI.WebControls.WebControl Then
            attrib = DirectCast(TextBoxToTie, System.Web.UI.WebControls.WebControl).Attributes
        Else
            ' lanzamos otra excepecion TextBoxToTie si no es del tipo HtmlControl o WebControl.
            Throw New ArgumentException("El Control TextBoxToTie debe derivar de System.Web.UI.HtmlControls.HtmlControl o System.Web.UI.WebControls.WebControl", "TextBoxToTie")
            Return ' y salimos
        End If
        If ButtonToTie Is Nothing Then 'borramos el evento
            attrib.Remove("onkeydown")
        Else 'o lo añadimos
            'Este es nuestro Javascript - Para cuando nuestro cliente clicke, saltara el evento.
            Dim jsString As String = "try{return FormDefaultButton(event, this,'" & ButtonToTie.ClientID & "');}catch(err){return false;}"
            attrib.Add("onkeydown", jsString)
        End If
    End Sub



    ''' <summary>
    '''     Añade el evento para la funcion javascript de bloqueo de doble click
    ''' </summary>
    ''' <history>
    ''' 	Autor: JMCelemin, mejorado por Manuel Soler
    '''     Fecha: 31/01/2007, 8/3/2007
    ''' </history>
    ''' <remarks>
    '''     NOTA: Se recomienda ponerlo en el pageload, fuera del "not ispostback". <br />
    '''     USAR en Pagina: &lt;script language="javascript" src="../Common/js/comportamientos.js"&gt;&lt;/script&gt;  
    ''' </remarks>
    Public Sub BloquearBotones()
        'recupera el formulario que se esta procesando (o el que lo llamó)
        Dim form As System.Web.UI.HtmlControls.HtmlForm = Me.BuscaDefaultForm()
        If Not (form Is Nothing) Then
            'form.Page.RegisterClientScriptBlock("CompJS", "<script language=""javascript"" src=""../Common/js/comportamientos.js""></script>")
            form.Attributes.Add("onclick", "try{return objControl.Bloqueo(event);}catch(err){return false;}")
        Else
            ' Se causa una excepcion en caso de que no se localize el tipo de control
            Throw New ArgumentException("No existe formulario por defecto o no se puede convertir para establecer el evento.", "BloquearBotones")
        End If
    End Sub

    ''' <summary>
    '''     Busca el formulario de la pagina actual, util para buscar, añadir controles o atributos.
    ''' </summary>
    ''' <returns>
    '''     Devuelve el Form donde estan los controles o en caso de no encontrarse, Nothing
    ''' </returns>
    ''' <history>
    ''' 	Autor: Manuel Soler
    '''     Fecha: 29/3/2007
    ''' </history>
    Public Function BuscaDefaultForm() As System.Web.UI.HtmlControls.HtmlForm
        For Each y As Control In DirectCast(HttpContext.Current.Handler, System.Web.UI.Page).Controls
            If y.GetType Is GetType(System.Web.UI.HtmlControls.HtmlForm) Then
                Return y
            End If
        Next y
        Return Nothing 'No encontrado
    End Function

#End Region

#Region "Funciones de FindControlPlus"
    ''' -----------------------------------------------------------------------------
    ''' <summary>
    '''     Busqueda avanzada de controles mediante varios parametros
    ''' </summary>
    ''' <param name="padre"> control padre desde el que se va a buscar </param>
    ''' <param name="ID"> nombre parcial con el que se hara la busqueda </param>
    ''' <param name="sensible"> distinguir mayusculas y minusculas en el ID </param>
    ''' <param name="tipos"> Array de tipos de controles a coincidir en las busquedas </param>
    ''' <returns> retorna  un array de controles con el suceso de la busqueda </returns>
    ''' <remarks> Varios de los parametros de busqueda son omitibles con Nothing/Null </remarks>
    ''' <history>
    '''     Manuel Soler      08/11/2007  Created
    ''' </history>
    ''' -----------------------------------------------------------------------------

    Public Function FindControlPlus(ByVal padre As Control, ByVal ID As String,
    Optional ByVal sensible As Boolean = False, Optional ByVal tipos As Type() = Nothing) As ArrayList
        Dim encontrado As New ArrayList
        If padre Is Nothing Then
            padre = DirectCast(System.Web.HttpContext.Current.Handler, System.Web.UI.Page)
        End If

        For Each controles As Control In padre.Controls
            If Not controles Is Nothing Then
                If (ID Is Nothing Or (Not controles.ID Is Nothing AndAlso Not ID Is Nothing AndAlso
                IIf(sensible, controles.ID.IndexOf(ID), controles.ID.ToLower.IndexOf(ID.ToLower)) <> -1)) _
                And InTypes(tipos, controles.GetType()) Then
                    encontrado.Add(controles)
                End If

                If controles.HasControls Then
                    encontrado.AddRange(FindControlPlus(controles, ID, sensible, tipos))
                End If
            End If
        Next

        Return encontrado
    End Function

    ''' <summary>
    ''' Chequea si coincide un tipo o si ha sido heredado.
    ''' </summary>
    ''' <param name="typeList">Un Array con los tipos a comparar</param>
    ''' <param name="typeToCheck">Tipo que debe de coincidir</param>
    ''' <returns></returns>
    Private Function InTypes(ByVal typeList As Type(), ByVal typeToCheck As Type) As Boolean
        If typeList Is Nothing Or typeToCheck Is Nothing Then Return True
        For Each tipo As Type In typeList
            If typeToCheck.Equals(tipo) Or typeToCheck.IsSubclassOf(tipo) Then Return True
        Next

        Return False
    End Function
#End Region

    Public Function EnhaceSecurity(ByVal pagina As Page) As String
        Dim data As String = String.Empty
        If Not isLocalHost Then
            data = "<script language='JavaScript' type='text/javascript'>" & vbCrLf &
                "javascript:window.top.history.forward(1);" & vbCrLf &
                "var check = window.top.name;" & vbCrLf &
                "if (!check || check == '') {" & vbCrLf &
                "window.top.opener = 'X';" & vbCrLf &
                "window.top.open('','_parent','');" & vbCrLf &
                "window.top.close();" & vbCrLf & "}" & vbCrLf & "</script>"
            pagina.ClientScript.RegisterClientScriptBlock(pagina.GetType, "EnhaceSecurity", data)
        End If
        Return data
    End Function

    Public ReadOnly Property isLocalHost(Optional ByVal pagina As Page = Nothing) As Boolean
        Get
            If pagina Is Nothing Then pagina = HttpContext.Current.Handler
            Return pagina.Request.UserHostAddress.Equals("127.0.0.1")
        End Get
    End Property

    ' Llamada des Login.aspx tras logarse el usuario
#Region "Procedimiento para iniciar la conexión Oracle y grabar el primer registro de Audit_Log de conexión del usuario"
    Public Sub Login_Usuario(ByVal user As String)
        Try
            'clsTracing.InsertAuditTrace("Login user: " & user, "", "", "", "")
        Catch ex As Exception
            Dim mesnaje As String = ex.Message.ToString()
        End Try
    End Sub
#End Region
    'fin 24/09/2012 Jorge Esp.


    Public Sub EnviaEmail(ByVal destinatario As String, ByVal asunto As String, ByVal cuerpo As String, ByVal Ficheros As List(Of String))
        Dim i As Integer = 0
        Dim ldestinatarios As List(Of String) = New List(Of String)()
        Dim lcc As List(Of String) = New List(Of String)()
        Dim lcco As List(Of String) = New List(Of String)()

        Try

            Dim nerror As Integer = 0
            Dim descerror As String = String.Empty


            If nerror <> 0 Then
                Throw New Exception(descerror)
            End If

        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Public Function ConvierteFechaDeMysql(ByVal fecha As String) As String
        Dim lafecha As String = String.Empty
        Dim cadena As String()
        If fecha <> "" Then
            'Dim cadena As String() = fecha.Split("-")
            'lafecha = cadena(2) & "/" & cadena(1) & "/" & cadena(0)

            Dim pos As Integer = fecha.IndexOf(" ")
            If pos > -1 Then
                fecha = fecha.Substring(0, pos - 1)
            End If
            cadena = fecha.Split("/")
            lafecha = fecha
        End If
        Return lafecha
    End Function

    Public Function Get_Mes_Letra(ByVal numes As Integer) As String
        Dim mesletra As String = String.Empty
        Select Case numes
            Case 1
                mesletra = "Enero"
            Case 2
                mesletra = "Febrero"
            Case 3
                mesletra = "Marzo"
            Case 4
                mesletra = "Abril"
            Case 5
                mesletra = "Mayo"
            Case 6
                mesletra = "Junio"
            Case 7
                mesletra = "Julio"
            Case 8
                mesletra = "Agosto"
            Case 9
                mesletra = "Septiembre"
            Case 10
                mesletra = "Octubre"
            Case 11
                mesletra = "Noviembre"
            Case 12
                mesletra = "Diciembre"
        End Select
        Return mesletra
    End Function
End Class
