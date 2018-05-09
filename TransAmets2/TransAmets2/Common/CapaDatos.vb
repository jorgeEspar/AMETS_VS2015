Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web.HttpUtility

Public Class CapaDatos
    Public objMySQL As ComMySQL

    Public Sub New()
        objMySQL = New ComMySQL()
    End Sub

    'Metodo para seleccionar Artículos
    Public Function GetArticulos(ByVal Tipo As String, ByVal Categoria As String, ByVal SubCategoria As String, ByVal CodArt As String) As DataTable
        Dim xtipo As String = "tipo"
        Dim xcategoria As String = "categoria"
        Dim xsubcategoria As String = "subcategoria"
        Dim xTitulo As String = "Titulo"
        Dim xTituloP As String = "TituloP"
        Dim xDescripcion As String = "Descripcion"
        Dim idioma As String = "es-ES"
        If HttpContext.Current.Session("myCulture") Is Nothing Then
            idioma = "es-ES"
        Else
            idioma = HttpContext.Current.Session("myCulture")
        End If
        If idioma = "en-GB" Then
            xtipo = "tipoingles"
            xcategoria = "categoriaingles"
            xsubcategoria = "subcategoriaingles"
            xTitulo = "TituloIngles"
            xTituloP = "TituloPIngles"
            xDescripcion = "DescripcionIngles"
        End If

        Dim dt As New DataTable
        Dim sql As String = String.Empty
        Dim sqlwhere As String = String.Empty

        Dim connection As MySqlConnection
        connection = New MySqlConnection
        Try
            'se apunta a la cadena de conexion guardada en el archivo Web.config
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("OleaMySQL").ConnectionString
            'se abre la conexion
            connection.Open()
            'se ejecuta una consulta SQL
            sql = "Select a.id,a.idTipo, a.idCat,a.idSubcat, a.Fecha, a.Referencia,a.Autor,  a." & xTitulo & " as Titulo, a." & xTituloP & " as TituloP,a." & xDescripcion & " as Descripcion "
            sql += ",a.numfotos, a.precio, tipos.tipo as tipofoto"
            sql += ", tipos." & xtipo & " as tipo, categorias." & xcategoria & " as categoria, subcategoria." & xsubcategoria & " as subcategoria "
            sql += "FROM articulos a INNER JOIN tipos ON a.idtipo = tipos.id "
            sql += "INNER JOIN categorias ON a.idcat = categorias.id "
            sql += "LEFT JOIN subcategoria ON a.idsubcat = subcategoria.id"
            If CodArt <> "" Then
                sqlwhere = " WHERE a.id=" & CodArt
            Else
                If Tipo <> "" Then
                    sqlwhere = " WHERE a.idTipo=" & Tipo
                End If
                If Categoria <> "" Then
                    If sqlwhere <> "" Then sqlwhere += " AND "
                    sqlwhere += " a.idcat = " & Categoria
                End If
                If SubCategoria <> "" Then
                    If sqlwhere <> "" Then sqlwhere += " AND "
                    sqlwhere += " a.idsubcat = " & SubCategoria
                End If
                If CodArt <> "" Then
                    If sqlwhere <> "" Then sqlwhere += " AND "
                    sqlwhere += " a.id = " & CodArt
                End If
            End If
            sql += sqlwhere
            If Tipo = "" And Categoria = "" And SubCategoria = "" And CodArt = "" Then
                sql += " order by a.fecha desc;"
            Else
                If CodArt = "" Then
                    sql += " order by a.idtipo, a.idcat, a.idsubcat, a.fecha desc;"
                End If
            End If

            Dim ComandoSQL As New MySqlCommand(sql, connection)
            Dim ds As New DataSet
            Dim da As New MySqlDataAdapter(ComandoSQL)
            da.Fill(ds)

            If ds.Tables.Count > 0 Then
                dt = ds.Tables(0)
            End If

            da.Dispose()

        Catch ex As Exception
            Throw ex
        Finally
            connection.Close()
        End Try

        Return dt
    End Function

    Public Function Get_Tipos() As DataTable
        Dim dt As New DataTable
        Dim sql As String = String.Empty
        Dim sqlwhere As String = String.Empty

        Dim connection As MySqlConnection
        connection = New MySqlConnection
        Try
            'se apunta a la cadena de conexion guardada en el archivo Web.config
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("OleaMySQL").ConnectionString
            'se abre la conexion
            connection.Open()
            'se ejecuta una consulta SQL
            sql = "select * FROM tipos order by id"

            Dim ComandoSQL As New MySqlCommand(sql, connection)
            Dim ds As New DataSet
            Dim da As New MySqlDataAdapter(ComandoSQL)
            da.Fill(ds)

            If ds.Tables.Count > 0 Then
                dt = ds.Tables(0)
            End If

            da.Dispose()

        Catch ex As Exception
            Throw ex
        Finally
            connection.Close()
        End Try

        Return dt
    End Function

#Region "Estadisticas"
    Public Function Get_COMPRAS_VENTAS_LastYear(ByVal xfechas As String, ByVal codcli As String, ByVal matricula As String, ByVal agencia As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Dim hoy As Date = Date.Today
        'Dim fecha As Date = hoy.AddYears(-1) 'DateAdd("y", -1, hoy)
        Dim fecha As Date = hoy.AddMonths(-13)
        Try
            'sql = "SELECT CONCAT(monthname(FECHA),"" - "", Year(FECHA)) as MES, Sum(COMPRA) as SumaCompra, Sum(VENTA) As SumaVenta FROM portes "
            sql = "SELECT month(FECHA) AS MES, Year(FECHA) AS YEAR, Sum(COMPRA) as SumaCompra, Sum(VENTA) As SumaVenta FROM portes "
            If xfechas <> "" Then
                If xfechas <> "" Then
                    If xfechas.IndexOf("-") > -1 Then
                        Dim fechas As String() = xfechas.Split(" - ")
                        sql += "WHERE FECHA>='" & conviertefecha_tomysql(fechas(0)) & "' AND FECHA<='" & conviertefecha_tomysql(fechas(2)) & "'"
                    Else
                        sql += "WHERE FECHA = '" & conviertefecha_tomysql(xfechas) & "'"
                    End If
                End If
            Else
                sql += "WHERE FECHA>='" & Format(fecha, "yyyy-MM-dd") & "' " '2017-03-01' "
            End If
            If codcli <> "" Then
                sql += " AND CODCLI=" & codcli
            End If
            If matricula <> "" Then
                sql += " AND MATRICULA='" & matricula & "'"
            End If
            If agencia <> "" Then
                sql += " AND CODP_AGENCIA=" & agencia
            End If
            sql += " GROUP BY Mes ORDER BY FECHA"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Get_NumPortes_LastYear(ByVal xfechas As String, ByVal codcli As String, ByVal matricula As String, ByVal agencia As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Dim hoy As Date = Date.Today
        'Dim fecha As Date = hoy.AddYears(-1) 'DateAdd("y", -1, hoy)
        Dim fecha As Date = hoy.AddMonths(-13)
        Try
            sql = "SELECT month(FECHA) AS MES, Year(FECHA) AS YEAR, Count(AUTOPORTE) as Cuantos FROM portes "
            If xfechas <> "" Then
                If xfechas <> "" Then
                    If xfechas.IndexOf("-") > -1 Then
                        Dim fechas As String() = xfechas.Split(" - ")
                        sql += "WHERE FECHA>='" & conviertefecha_tomysql(fechas(0)) & "' AND FECHA<='" & conviertefecha_tomysql(fechas(2)) & "'"
                    Else
                        sql += "WHERE FECHA = '" & conviertefecha_tomysql(xfechas) & "'"
                    End If
                End If
            Else
                sql += "WHERE FECHA>='" & Format(fecha, "yyyy-MM-dd") & "' " '2017-03-01' "
            End If
            If codcli <> "" Then
                sql += " AND CODCLI=" & codcli
            End If
            If matricula <> "" Then
                sql += " AND MATRICULA='" & matricula & "'"
            End If
            If agencia <> "" Then
                sql += " AND CODP_AGENCIA=" & agencia
            End If
            sql += " GROUP BY Mes ORDER BY FECHA"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Carga_Cobros_Pagos_Pendientes(ByVal xfechas As String, ByVal codcli As String, ByVal matricula As String, ByVal agencia As String) As DataTable
        Dim dtreturn As New DataTable
        dtreturn.Columns.Add("TOTAL_COMPRA", GetType(Double))
        dtreturn.Columns.Add("NUMPORTES_TOTAL_COMPRA", GetType(Double))
        dtreturn.Columns.Add("TOTAL_VENTA", GetType(Double))
        dtreturn.Columns.Add("NUMPORTES_TOTAL_VENTA", GetType(Double))
        dtreturn.Columns.Add("PENDIENTE_COBRO", GetType(Double))
        dtreturn.Columns.Add("NUMPORTES_PENDIENTE_COBRO", GetType(Double))
        dtreturn.Columns.Add("PENDIENTE_PAGO", GetType(Double))
        dtreturn.Columns.Add("NUMPORTES_PENDIENTE_PAGO", GetType(Double))

        Dim dt As DataTable
        Dim sql As String
        Dim sqlwhere As String
        Dim hoy As Date = Date.Today
        Dim fecha As Date = hoy.AddMonths(-13)
        Dim TOTAL_COMPRA As Double = 0
        Dim NUMPORTES_TOTAL_COMPRA As Double = 0
        Dim TOTAL_VENTA As Double = 0
        Dim NUMPORTES_TOTAL_VENTA As Double = 0
        Dim PENDIENTE_COBRO As Double = 0
        Dim NUMPORTES_PENDIENTE_COBRO As Double = 0
        Dim PENDIENTE_PAGO As Double = 0
        Dim NUMPORTES_PENDIENTE_PAGO As Double = 0
        Try
            sql = "SELECT SUM(COMPRA) as COMPRA, COUNT(AUTOPORTE) AS NUMPORTES FROM portes WHERE AUTOPORTE>0 "
            If xfechas <> "" Then
                If xfechas <> "" Then
                    If xfechas.IndexOf("-") > -1 Then
                        Dim fechas As String() = xfechas.Split(" - ")
                        sql += " AND FECHA>='" & conviertefecha_tomysql(fechas(0)) & "' AND FECHA<='" & conviertefecha_tomysql(fechas(2)) & "'"
                    Else
                        sql += "AND FECHA = '" & conviertefecha_tomysql(xfechas) & "'"
                    End If
                End If
            Else
                sql += " AND FECHA>='" & Format(fecha, "yyyy-MM-dd") & "' " '2017-03-01' "
            End If
            If codcli <> "" Then
                sql += " AND CODCLI=" & codcli
            End If
            If matricula <> "" Then
                sql += " AND MATRICULA='" & matricula & "'"
            End If
            If agencia <> "" Then
                sql += " AND CODP_AGENCIA=" & agencia
            End If
            'sql += " GROUP BY Mes"
            dt = objMySQL.Consulta(sql)
            If dt.Rows.Count > 0 Then
                TOTAL_COMPRA = dt.Rows(0).Item("COMPRA")
                NUMPORTES_TOTAL_COMPRA = dt.Rows(0).Item("NUMPORTES")
            End If

            sql = "SELECT SUM(VENTA) as VENTA, COUNT(AUTOPORTE) AS NUMPORTES FROM portes WHERE AUTOPORTE>0 "
            If xfechas <> "" Then
                If xfechas <> "" Then
                    If xfechas.IndexOf("-") > -1 Then
                        Dim fechas As String() = xfechas.Split(" - ")
                        sql += " AND FECHA>='" & conviertefecha_tomysql(fechas(0)) & "' AND FECHA<='" & conviertefecha_tomysql(fechas(2)) & "'"
                    Else
                        sql += " AND FECHA = '" & conviertefecha_tomysql(xfechas) & "'"
                    End If
                End If
            Else
                sql += " AND FECHA>='" & Format(fecha, "yyyy-MM-dd") & "' " '2017-03-01' "
            End If
            If codcli <> "" Then
                sql += " AND CODCLI=" & codcli
            End If
            If matricula <> "" Then
                sql += " AND MATRICULA='" & matricula & "'"
            End If
            If agencia <> "" Then
                sql += " AND CODP_AGENCIA=" & agencia
            End If
            'sql += " GROUP BY Mes"
            dt = objMySQL.Consulta(sql)
            If dt.Rows.Count > 0 Then
                TOTAL_VENTA = dt.Rows(0).Item("VENTA")
                NUMPORTES_TOTAL_VENTA = dt.Rows(0).Item("NUMPORTES")
            End If

            sql = "SELECT SUM(VENTA) as VENTA, COUNT(AUTOPORTE) AS NUMPORTES FROM portes WHERE FECOBRO IS NULL "
            If xfechas <> "" Then
                If xfechas <> "" Then
                    If xfechas.IndexOf("-") > -1 Then
                        Dim fechas As String() = xfechas.Split(" - ")
                        sql += " AND FECHA>='" & conviertefecha_tomysql(fechas(0)) & "' AND FECHA<='" & conviertefecha_tomysql(fechas(2)) & "'"
                    Else
                        sql += " AND FECHA = '" & conviertefecha_tomysql(xfechas) & "'"
                    End If
                End If
            Else
                sql += "AND FECHA>='" & Format(fecha, "yyyy-MM-dd") & "' " '2017-03-01' "
            End If
            If codcli <> "" Then
                sql += " AND CODCLI=" & codcli
            End If
            If matricula <> "" Then
                sql += " AND MATRICULA='" & matricula & "'"
            End If
            If agencia <> "" Then
                sql += " AND CODP_AGENCIA=" & agencia
            End If
            'sql += " GROUP BY Mes"
            'sql = "SELECT SUM(f.IMPORTE_FAC) as IMPORTE_FAC, SUM(c.IMPORTE_COBRO) AS IMPORTE_COBRADO, COUNT(fp.ID) AS NUMPORTES "
            'sql += "FROM ((facturas f LEFT JOIN cobros c ON f.AUTOFAC = c.AUTOFAC) LEFT JOIN facturas_portes fp ON f.AUTOFAC = fp.AUTOFAC) "
            'sql += "Left JOIN portes p ON fp.AUTOPORTE = p.AUTOPORTE "
            'sqlwhere = ""
            'If xfechas <> "" Then
            '    If xfechas <> "" Then
            '        If xfechas.IndexOf("-") > -1 Then
            '            Dim fechas As String() = xfechas.Split(" - ")
            '            sqlwhere += " AND f.FECHA_FAC>='" & conviertefecha_tomysql(fechas(0)) & "' AND f.FECHA_FAC<='" & conviertefecha_tomysql(fechas(2)) & "'"
            '        Else
            '            sqlwhere += " AND f.FECHA_FAC = '" & conviertefecha_tomysql(xfechas) & "'"
            '        End If
            '    End If
            'Else
            '    sqlwhere += "AND f.FECHA_FAC>='" & Format(fecha, "yyyy-MM-dd") & "' " '2017-03-01' "
            'End If
            'If codcli <> "" Then
            '    sqlwhere += " AND f.CLIENTE_FAC=" & codcli
            'End If
            'If matricula <> "" Then
            '    sqlwhere += " AND p.MATRICULA='" & matricula & "'"
            'End If
            'If agencia <> "" Then
            '    sqlwhere += " AND p.CODP_AGENCIA=" & agencia
            'End If
            ''sql += " GROUP BY Mes"
            'If sqlwhere <> "" Then sql += sqlwhere
            dt = objMySQL.Consulta(sql)
            If dt.Rows.Count > 0 Then
                'Dim suma_importe_facturacion As Double = dt.Rows(0).Item("IMPORTE_FAC")
                'Dim suma_importe_cobrado As Double = dt.Rows(0).Item("IMPORTE_COBRADO")
                'PENDIENTE_COBRO = suma_importe_facturacion - suma_importe_cobrado

                PENDIENTE_COBRO = dt.Rows(0).Item("VENTA")
                NUMPORTES_PENDIENTE_COBRO = dt.Rows(0).Item("NUMPORTES")
            End If

            sql = "Select SUM(COMPRA) As COMPRA, COUNT(AUTOPORTE) As NUMPORTES FROM portes WHERE FEPAGO Is NULL "
            If xfechas <> "" Then
                If xfechas <> "" Then
                    If xfechas.IndexOf("-") > -1 Then
                        Dim fechas As String() = xfechas.Split(" - ")
                        sql += " And FECHA>='" & conviertefecha_tomysql(fechas(0)) & "' AND FECHA<='" & conviertefecha_tomysql(fechas(2)) & "'"
                    Else
                        sql += " AND FECHA = '" & conviertefecha_tomysql(xfechas) & "'"
                    End If
                End If
            Else
                sql += "AND FECHA>='" & Format(fecha, "yyyy-MM-dd") & "' " '2017-03-01' "
            End If
            If codcli <> "" Then
                sql += " AND CODCLI=" & codcli
            End If
            If matricula <> "" Then
                sql += " AND MATRICULA='" & matricula & "'"
            End If
            If agencia <> "" Then
                sql += " AND CODP_AGENCIA=" & agencia
            End If
            'sql += " GROUP BY Mes"
            dt = objMySQL.Consulta(sql)
            If dt.Rows.Count > 0 Then
                PENDIENTE_PAGO = dt.Rows(0).Item("COMPRA")
                NUMPORTES_PENDIENTE_PAGO = dt.Rows(0).Item("NUMPORTES")
            End If

            dtreturn.Rows.Add(TOTAL_COMPRA, NUMPORTES_TOTAL_COMPRA, TOTAL_VENTA, NUMPORTES_TOTAL_VENTA, PENDIENTE_COBRO, NUMPORTES_PENDIENTE_COBRO, PENDIENTE_PAGO, NUMPORTES_PENDIENTE_PAGO)
            Return dtreturn
        Catch ex As Exception
            Throw ex
        End Try
    End Function

#End Region
#Region "Funciones Portes"
    Public Function Get_Datos_Porte(ByVal numporte As Long) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT portes.*, clientes.CLINOM, transportistas.PROPIETARIO, transportistas.CONDUCTOR "
            sql += "FROM portes LEFT JOIN clientes ON portes.CODCLI=clientes.CODIGOCLI LEFT JOIN transportistas ON portes.MATRICULA=transportistas.MATRICULA "
            sql += "WHERE AUTOPORTE=" & numporte
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try

    End Function
#End Region
#Region "Funciones Preportes"
    Public Function Get_Datos_Preporte(ByVal numpreporte As Long) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT preportes.*, clientes.CLINOM, transportistas.PROPIETARIO, transportistas.CONDUCTOR "
            sql += "FROM preportes LEFT JOIN clientes ON preportes.CLIENTE=clientes.CODIGOCLI LEFT JOIN transportistas ON preportes.MATRICULA=transportistas.MATRICULA "
            sql += "WHERE PREPORTE=" & numpreporte
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try

    End Function
#End Region
#Region "Buscadores"
    Public Function Get_Clientes(ByVal codigo As String, ByVal nombre As String, ByVal cifnif As String) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT * FROM clientes WHERE CODIGOCLI>0"
            If codigo <> "" Then
                sql += " AND CODIGOCLI=" & codigo
            End If
            If nombre <> "" Then
                sql += " AND CLINOM like '%" & nombre & "%'"
            End If
            If cifnif <> "" Then
                sql += " AND CLICIF like '%" & cifnif & "%'"
            End If
            sql += " ORDER BY CLINOM"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function Get_Transportistas(ByVal matricula As String, ByVal propiestario As String, ByVal conductor As String) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT * FROM transportistas WHERE MATRICULA<>''"
            If matricula <> "" Then
                sql += " AND MATRICULA='" & matricula & "'"
            End If
            If propiestario <> "" Then
                sql += " AND PROPIETARIO like '%" & propiestario & "%'"
            End If
            If conductor <> "" Then
                sql += " AND CONDUCTOR like '%" & conductor & "%'"
            End If
            sql += " ORDER BY MATRICULA"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function Get_Portes(ByVal autoporte As String, ByVal numporte As Integer, ByVal fechaporte As String, ByVal codcli As String, ByVal matricula As String) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT portes.*, clientes.CLINOM, transportistas.PROPIETARIO, transportistas.conductor "
            sql += "FROM portes LEFT JOIN clientes ON portes.CODCLI=clientes.CODIGOCLI LEFT JOIN transportistas ON portes.MATRICULA=transportistas.MATRICULA "
            sql += "WHERE AUTOPORTE>0"
            If autoporte <> "" Then
                sql += " And AUTOPORTE=" & autoporte
            End If
            If numporte <> "" Then
                sql += " And NUMPOR = " & numporte
            End If
            If fechaporte <> "" Then
                sql += " And FECHA = '" & conviertefecha_tomysql(fechaporte) & "%'"
            End If
            If codcli <> "" Then
                sql += " AND CODCLI=" & codcli
            End If
            If matricula <> "" Then
                sql += " AND MATRICULA='" & matricula & "'"
            End If
            sql += " ORDER BY FECHA DESC"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_ListadoPortes(ByVal fechaporte As String, ByVal codcli As String, ByVal matricula As String, ByVal codagencia As String, ByVal fechaentrega As String,
                                      ByVal dircarga As String, dirdestino As String, ByVal mercancia As String, ByVal estado As String) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT portes.*, clientes.CLINOM, transportistas.PROPIETARIO, transportistas.CONDUCTOR, agencias_trans.NOMBRE_COOP "
            sql += "FROM ((portes LEFT JOIN clientes ON portes.CODCLI=clientes.CODIGOCLI) LEFT JOIN transportistas ON portes.MATRICULA=transportistas.MATRICULA) "
            sql += "LEFT JOIN agencias_trans ON portes.CODP_AGENCIA = agencias_trans.AUTOCOOP "
            sql += "WHERE AUTOPORTE>0"
            If fechaporte <> "" Then
                If fechaporte.IndexOf("-") > -1 Then
                    Dim fechas As String() = fechaporte.Split(" - ")
                    sql += " And FECHA>='" & conviertefecha_tomysql(fechas(0)) & "' AND FECHA<='" & conviertefecha_tomysql(fechas(2)) & "'"
                Else
                    sql += " AND FECHA = '" & conviertefecha_tomysql(fechaporte) & "'"
                End If
            End If
            If fechaentrega <> "" Then
                If fechaentrega.IndexOf("-") > -1 Then
                    Dim fechasentrega As String() = fechaentrega.Split(" - ")
                    sql += " And FECHA_ENTREGA>='" & conviertefecha_tomysql(fechasentrega(0)) & "' AND FECHA_ENTREGA<='" & conviertefecha_tomysql(fechasentrega(2)) & "'"
                Else
                    sql += " AND FECHA_ENTREGA = '" & conviertefecha_tomysql(fechaentrega) & "'"
                End If
            End If

            If codcli <> "" Then
                sql += " And CODCLI = " & codcli
            End If
            If matricula <> "" Then
                sql += " And MATRICULA = '" & matricula & "'"
            End If
            If codagencia <> "" Then
                sql += " AND CODP_AGENCIA=" & codagencia
            End If
            If dircarga <> "" Then
                sql += " AND DIRCARGA like '%" & dircarga & "%'"
            End If
            If dirdestino <> "" Then
                sql += " AND DESTINO like '%" & dirdestino & "%'"
            End If
            If mercancia <> "" Then
                sql += " AND MERCANCIA like '%" & mercancia & "%'"
            End If

            If estado <> "" Then
                Select Case estado
                    Case "SF" ' Sin facturar
                        sql += " AND portes.FACTURA IS NULL"
                    Case "SP" 'Sin pagar
                        sql += " AND portes.FEPAGO IS NULL"
                    Case "FSCN" 'Facturado sin cobrar
                        sql += " AND (portes.FACTURA IS NOT NULL AND portes.FECOBRO IS NULL)"
                    Case "FSCS" 'Facturado y cobrado
                        sql += " AND (portes.FACTURA IS NOT NULL AND portes.FECOBRO IS NOT NULL)"
                    Case "PS" ' Pagados
                        sql += " AND portes.FEPAGO IS NOT NULL"
                    Case "SFSP" 'Sin Facturar ni Pagar
                        sql += " AND (portes.FACTURA IS NULL AND portes.FEPAGO IS NULL)"
                    Case "CSPSP" 'Cobrado y Pagado
                        sql += " AND (portes.FECOBRO IS NOT NULL AND portes.FEPAGO IS NOT NULL)"
                End Select
            End If

            sql += " ORDER BY portes.FECHA DESC, portes.CODCLI"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Get_Agencias_Trans(ByVal AUTOCOOP As String, ByVal NOMBRE_COOP As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM agencias_trans WHERE AUTOCOOP>0"
            If AUTOCOOP <> "" Then
                sql += " AND AUTOCOOP=" & AUTOCOOP
            End If
            If NOMBRE_COOP <> "" Then
                sql += " AND NOMBRE_COOP LIKE '%" & NOMBRE_COOP & "%'"
            End If
            sql += " ORDER BY NOMBRE_COOP"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Agencia_Matricula(ByVal AUTOAGMAT As String, ByVal COD_AGENCIA As String, ByVal MATRICULA_COOP As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM agencia_matricula WHERE AUTOAGMAT>0"
            If AUTOAGMAT <> "" Then
                sql += " AND AUTOAGMAT=" & AUTOAGMAT
            End If
            If COD_AGENCIA <> "" Then
                sql += " AND COD_AGENCIA=" & COD_AGENCIA
            End If
            If MATRICULA_COOP <> "" Then
                sql += " AND MATRICULA_COOP='" & MATRICULA_COOP & "'"
            End If
            sql += " ORDER BY AUTOAGMAT"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Clicarga(ByVal CODDIRCLI As String, ByVal CODIGOCLI As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM clicarga WHERE CODDIRCLI>0"
            If CODDIRCLI <> "" Then
                sql += " AND CODDIRCLI=" & CODDIRCLI
            End If
            If CODIGOCLI <> "" Then
                sql += " AND CODIGOCLI=" & CODIGOCLI
            End If
            sql += " ORDER BY CODDIRCLI"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Destino(ByVal COD_DESTINO As String, ByVal DES_DESTINO As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM destino WHERE COD_DESTINO>0"
            If COD_DESTINO <> "" Then
                sql += " AND COD_DESTINO=" & COD_DESTINO
            End If
            If DES_DESTINO <> "" Then
                sql += " AND DES_DESTINO like '%" & DES_DESTINO & "%'"
            End If
            sql += " ORDER BY COD_DESTINO"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Movicli(ByVal CODIGOCLI As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM movicli WHERE CODIGOCLI=" & CODIGOCLI
            sql += " ORDER BY FECHA_MOVCLI DESC, AUTOMOVCLI"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Movitra(ByVal CODIGOTRA As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM movitra WHERE CODIGOTRA=" & CODIGOTRA
            sql += " ORDER BY FECHA_MOVTRA DESC, AUTOMOVTRA"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Origen(ByVal COD_ORIGEN As String, ByVal DES_ORIGEN As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM origen WHERE COD_ORIGEN>0"
            If COD_ORIGEN <> "" Then
                sql += " AND COD_ORIGEN=" & COD_ORIGEN
            End If
            If DES_ORIGEN <> "" Then
                sql += " AND DES_ORIGEN like '%" & DES_ORIGEN & "%'"
            End If
            sql += " ORDER BY COD_ORIGEN"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Precios(ByVal COD_PRECIO As String, ByVal COD_PRE_CLI As String, ByVal PRE_FECHA_DESDE As String, ByVal PRE_FECHA_HASTA As String,
                                ByVal PRE_ORIGEN As String, ByVal PRE_DESTINO As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM precios WHERE COD_PRECIO>0"
            If COD_PRECIO <> "" Then
                sql += " AND COD_PRECIO=" & COD_PRECIO
            End If
            If COD_PRE_CLI <> "" Then
                sql += " AND COD_PRE_CLI = " & COD_PRE_CLI
            End If
            If PRE_FECHA_DESDE <> "" Then
                sql += " AND PRE_FECHA>='" & conviertefecha_tomysql(PRE_FECHA_DESDE) & "'"
            End If
            If PRE_FECHA_HASTA <> "" Then
                sql += " AND PRE_FECHA<='" & conviertefecha_tomysql(PRE_FECHA_HASTA) & "'"
            End If
            If PRE_ORIGEN <> "" Then
                sql += " AND PRE_ORIGEN=" & PRE_ORIGEN
            End If
            If PRE_DESTINO <> "" Then
                sql += " AND PRE_DESTINO=" & PRE_DESTINO
            End If

            sql += " ORDER BY COD_PRECIO"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Preportes(ByVal PREPORTE As String, ByVal CLIENTE As String, ByVal MATRICULA As String, ByVal FECHA_DESDE As String, ByVal FECHA_HASTA As String,
                                ByVal FECHA_PORTE_DESDE As String, ByVal FECHA_PORTE_HASTA As String, ByVal ORIGEN As String, ByVal DESTINO As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM preportes WHERE PREPORTE>0"
            If PREPORTE <> "" Then
                sql += " AND PREPORTE=" & PREPORTE
            End If
            If CLIENTE <> "" Then
                sql += " AND CLIENTE = " & CLIENTE
            End If
            If MATRICULA <> "" Then
                sql += " AND MATRICULA='" & MATRICULA & "'"
            End If
            If FECHA_DESDE <> "" Then
                sql += " AND FECHA>='" & conviertefecha_tomysql(FECHA_DESDE) & "'"
            End If
            If FECHA_HASTA <> "" Then
                sql += " AND FECHA<='" & conviertefecha_tomysql(FECHA_HASTA) & "'"
            End If
            If FECHA_PORTE_DESDE <> "" Then
                sql += " AND FECHA_PORTE>='" & conviertefecha_tomysql(FECHA_PORTE_DESDE) & "'"
            End If
            If FECHA_PORTE_HASTA <> "" Then
                sql += " AND FECHA_PORTE<='" & conviertefecha_tomysql(FECHA_PORTE_HASTA) & "'"
            End If
            If ORIGEN <> "" Then
                sql += " AND ORIGEN=" & ORIGEN
            End If
            If DESTINO <> "" Then
                sql += " AND DESTINO=" & DESTINO
            End If

            sql += " ORDER BY FECHA DESC, PREPORTE"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_DesProvincia(ByVal CODIGO As String) As String
        Dim desprovincia As String = String.Empty
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT DESCRIPCION FROM provincias WHERE CODIGO<>''"
            If CODIGO <> "" Then
                sql += " AND CODIGO='" & CODIGO & "'"
            End If
            dt = objMySQL.Consulta(sql)
            If dt.Rows.Count > 0 Then
                desprovincia = dt.Rows(0).Item("DESCRIPCION")
            End If
            Return desprovincia
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Get_Provincias(ByVal CODIGO As String, ByVal DESCRIPCION As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM provincias WHERE CODIGO<>''"
            If CODIGO <> "" Then
                sql += " AND CODIGO='" & CODIGO & "'"
            End If
            If DESCRIPCION <> "" Then
                sql += " AND DESCRIPCION='" & DESCRIPCION & "'"
            End If
            sql += " ORDER BY CODIGO"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Recibos(ByVal NURECIBO As String, ByVal FECHA_RE_DESDE As String, ByVal FECHA_RE_HASTA As String, ByVal MATRICULA_RE As String, ByVal AGENCIA_RE As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM recibos WHERE AUTOREC>0"
            If NURECIBO <> "" Then
                sql += " AND NURECIBO=" & NURECIBO
            End If
            If FECHA_RE_DESDE <> "" Then
                sql += " AND FECHA_RE>='" & conviertefecha_tomysql(FECHA_RE_DESDE) & "'"
            End If
            If FECHA_RE_HASTA <> "" Then
                sql += " AND FECHA_RE<='" & conviertefecha_tomysql(FECHA_RE_HASTA) & "'"
            End If
            If MATRICULA_RE <> "" Then
                sql += " AND MATRICULA_RE='" & MATRICULA_RE & "'"
            End If
            If AGENCIA_RE <> "" Then
                sql += " AND AGENCIA_RE=" & AGENCIA_RE
            End If

            sql += " ORDER BY FECHA_RE, NURECIBO"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Tipocami(ByVal CODIGO As String, ByVal DESCRIPCION As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM tipocami WHERE CODIGO>0"
            If CODIGO <> "" Then
                sql += " AND CODIGO='" & CODIGO & "'"
            End If
            If DESCRIPCION <> "" Then
                sql += " AND DESCRIPCION='" & DESCRIPCION & "'"
            End If
            sql += " ORDER BY CODIGO"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Tiposrecibo(ByVal CODIGO As String, ByVal DESCRIPCION As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM tiposrecibo WHERE CODIGO>0"
            If CODIGO <> "" Then
                sql += " AND CODIGO='" & CODIGO & "'"
            End If
            If DESCRIPCION <> "" Then
                sql += " AND DESCRIPCION='" & DESCRIPCION & "'"
            End If
            sql += " ORDER BY CODIGO"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_volumen(ByVal COD_VOLUMEN As String, ByVal DES_VOLUMEN As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM volumen WHERE COD_VOLUMEN>0"
            If COD_VOLUMEN <> "" Then
                sql += " AND COD_VOLUMEN=" & COD_VOLUMEN
            End If
            If DES_VOLUMEN <> "" Then
                sql += " AND DES_VOLUMEN='" & DES_VOLUMEN & "'"
            End If
            sql += " ORDER BY COD_VOLUMEN"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Zonas(ByVal CODIGO As String, ByVal DESCRIPCION As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM zonas WHERE CODIGO>0"
            If CODIGO <> "" Then
                sql += " AND CODIGO='" & CODIGO & "'"
            End If
            If DESCRIPCION <> "" Then
                sql += " AND DESCRIPCION='" & DESCRIPCION & "'"
            End If
            sql += " ORDER BY CODIGO"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_ClienteDirCarga(ByVal CodCli As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "Select clicarga.*,provincias.descripcion as PROVINCIA "
            sql += "From clicarga LEFT Join provincias ON LEFT(clicarga.CODPOSTAL,2)=provincias.CODIGO "
            sql += "WHERE clicarga.CODIGOCLI=" & CodCli
            sql += " ORDER BY clicarga.CODIGOCLI, clicarga.CODDIRCLI"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region
#Region "funciones varias"
    Public Function Get_Login(ByVal user As String, ByVal pwd As String) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT * FROM usuarios WHERE UPPER(usuario)='" & user.ToUpper() & "' AND password='" & pwd & "'"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try

    End Function
    Public Function Get_Datos_Empresa() As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT * FROM empresa"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    ' convierte una fecha español a formato mysql = aaaa-mm-dd
    Private Function conviertefecha_tomysql(ByVal fecha As String) As String
        Dim newdate As String = ""
        Dim xfecha As Date
        If fecha <> "" Then
            xfecha = CDate(fecha)
            newdate = Year(xfecha).ToString & "-" & Month(xfecha).ToString.PadLeft(2, "0") & "-" & Day(xfecha).ToString.PadLeft(2, "0")
        End If
        Return newdate
    End Function
#End Region

#Region "PRECIOS"
    Public Function Get_ListadoPrecios(ByVal FecPrecios As String, ByVal codcli As String, ByVal CodOrigen As String, ByVal dircarga As String,
                                       ByVal CodDestino As String, ByVal dirdestino As String, ByVal mercancia As String,
                                       ByVal Peso As String, ByVal TipoCamion As String, ByVal Volumen As String) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT precios.*, clientes.CLINOM, origen.DES_ORIGEN, destino.DES_DESTINO, tipocami.DESCRIPCION AS DES_TIPOCAMI, volumen.DES_VOLUMEN "
            sql += "FROM ((((precios LEFT JOIN clientes ON precios.COD_PRE_CLI=clientes.CODIGOCLI) LEFT JOIN origen ON precios.PRE_ORIGEN=origen.COD_ORIGEN) "
            sql += "LEFT JOIN destino ON precios.PRE_DESTINO = destino.COD_DESTINO) "
            sql += "LEFT JOIN tipocami ON precios.PRE_TIPOCAM = tipocami.CODIGO) "
            sql += "LEFT JOIN volumen ON precios.PRE_VOLUMEN = volumen.COD_VOLUMEN "
            sql += "WHERE COD_PRECIO>0"
            If FecPrecios <> "" Then
                If FecPrecios.IndexOf("-") > -1 Then
                    Dim fechas As String() = FecPrecios.Split(" - ")
                    sql += " And PRE_FECHA>='" & conviertefecha_tomysql(fechas(0)) & "' AND PRE_FECHA<='" & conviertefecha_tomysql(fechas(2)) & "'"
                Else
                    sql += " AND PRE_FECHA = '" & conviertefecha_tomysql(FecPrecios) & "'"
                End If
            End If
            If codcli <> "" Then
                sql += " And precios.COD_PRE_CLI = " & codcli
            End If
            If CodOrigen <> "" Then
                sql += " And precios.PRE_ORIGEN = " & CodOrigen
            End If
            If CodDestino <> "" Then
                sql += " AND precios.PRE_DESTINO=" & CodDestino
            End If
            If dircarga <> "" Then
                sql += " AND (precios.DETALLE_ORIGEN like '%" & dircarga & "%' OR DES_ORIGEN like '%" & dircarga & "%')"
            End If
            If dirdestino <> "" Then
                sql += " AND (precios.DETALLE_DESTINO like '%" & dirdestino & "%' OR DES_DESTINO like '%" & dirdestino & "%')"
            End If
            If mercancia <> "" Then
                sql += " AND MERCANCIA like '%" & mercancia & "%'"
            End If
            If Peso <> "" Then
                sql += " AND PRE_TNS=" & Peso
            End If
            If TipoCamion <> "" Then
                sql += " AND PRE_TIPOCAM=" & Peso
            End If
            If Volumen <> "" Then
                sql += " AND PRE_VOLUMEN=" & Volumen
            End If

            sql += " ORDER BY precios.COD_PRE_CLI, precios.PRE_FECHA DESC, precios.PRE_ORIGEN, precios.DETALLE_ORIGEN, precios.PRE_DESTINO, precios.DETALLE_DESTINO"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Precio(ByVal COD_PRECIO As String) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT precios.*, clientes.CLINOM, origen.DES_ORIGEN, destino.DES_DESTINO, tipocami.DESCRIPCION AS DES_TIPOCAMI, volumen.DES_VOLUMEN "
            sql += "FROM ((((precios LEFT JOIN clientes ON precios.COD_PRE_CLI=clientes.CODIGOCLI) LEFT JOIN origen ON precios.PRE_ORIGEN=origen.COD_ORIGEN) "
            sql += "LEFT JOIN destino ON precios.PRE_DESTINO = destino.COD_DESTINO) "
            sql += "LEFT JOIN tipocami ON precios.PRE_TIPOCAM = tipocami.CODIGO) "
            sql += "LEFT JOIN volumen ON precios.PRE_VOLUMEN = volumen.COD_VOLUMEN "
            sql += "WHERE COD_PRECIO=" & COD_PRECIO

            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region
#Region "PREPORTES"
    Public Function Get_ListadoPrePortes(ByVal FecPrePorte As String, ByVal codcli As String, ByVal matricula As String, ByVal codagencia As String, ByVal FechaPorte As String,
                                      ByVal dircarga As String, dirdestino As String, ByVal mercancia As String, ByVal estado As String) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT preportes.*, clientes.CLINOM, transportistas.PROPIETARIO, transportistas.CONDUCTOR, agencias_trans.NOMBRE_COOP, origen.DES_ORIGEN, destino.DES_DESTINO "
            sql += "FROM ((((preportes LEFT JOIN clientes ON preportes.CLIENTE=clientes.CODIGOCLI) LEFT JOIN transportistas ON preportes.MATRICULA=transportistas.MATRICULA) "
            sql += "LEFT JOIN agencias_trans ON preportes.AGENCIA = agencias_trans.AUTOCOOP) "
            sql += "LEFT JOIN origen ON preportes.ORIGEN = origen.COD_ORIGEN) "
            sql += "LEFT JOIN destino ON preportes.DESTINO = destino.COD_DESTINO "
            sql += "WHERE PREPORTE>0"
            If FecPrePorte <> "" Then
                If FecPrePorte.IndexOf("-") > -1 Then
                    Dim fechas As String() = FecPrePorte.Split(" - ")
                    sql += " And FECHA>='" & conviertefecha_tomysql(fechas(0)) & "' AND FECHA<='" & conviertefecha_tomysql(fechas(2)) & "'"
                Else
                    sql += " AND FECHA = '" & conviertefecha_tomysql(FecPrePorte) & "'"
                End If
            End If
            If FechaPorte <> "" Then
                If FechaPorte.IndexOf("-") > -1 Then
                    Dim fechasPORTE As String() = FechaPorte.Split(" - ")
                    sql += " And FECHA_PORTE>='" & conviertefecha_tomysql(fechasPORTE(0)) & "' AND FECHA_PORTE<='" & conviertefecha_tomysql(fechasPORTE(2)) & "'"
                Else
                    sql += " AND FECHA_PORTE = '" & conviertefecha_tomysql(FechaPorte) & "'"
                End If
            End If

            If codcli <> "" Then
                sql += " And CLIENTE = " & codcli
            End If
            If matricula <> "" Then
                sql += " And MATRICULA = '" & matricula & "'"
            End If
            If codagencia <> "" Then
                sql += " AND AGENCIA=" & codagencia
            End If
            If dircarga <> "" Then
                sql += " AND (ORIGEN_LIBRE like '%" & dircarga & "%' OR DES_ORIGEN like '%" & dircarga & "%')"
            End If
            If dirdestino <> "" Then
                sql += " AND (DESTINO_LIBRE like '%" & dirdestino & "%' OR DES_DESTINO like '%" & dirdestino & "%' OR DETALLE_DESTINO like '%" & dirdestino & "%')"
            End If
            If mercancia <> "" Then
                sql += " AND MERCANCIA like '%" & mercancia & "%'"
            End If

            If estado <> "" Then
                Select Case estado
                    Case "SS" ' Sin Salir
                        ''sql += " AND portes.FACTURA IS NULL"
                    Case "SH" ' han salido hoy
                        ''sql += " AND portes.FEPAGO IS NULL"
                    Case "FD" ' Han salido faltan datos
                        ''sql += " AND (portes.FACTURA IS NOT NULL AND portes.FECOBRO IS NULL)"
                    Case "LV" ' Listos para validar
                        ''sql += " AND (portes.FACTURA IS NOT NULL AND portes.FECOBRO IS NOT NULL)"
                End Select
            End If

            sql += " ORDER BY preportes.FECHA DESC, preportes.CLIENTE"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

#Region "FACTURAS"
    Public Function Get_Facturas(ByVal AUTOFAC As String, ByVal NUMERO As String, ByVal CLIENTE_FAC As String, ByVal FECHA_FAC_DESDE As String, ByVal FECHA_FAC_HASTA As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Try
            sql = "SELECT facturas.*, clientes.CLINOM FROM facturas LEFT JOIN clientes ON facturas.CLIENTE_FAC = clientes.CODCLI WHERE AUTOFAC>0"
            If AUTOFAC <> "" Then
                sql += " AND AUTOFAC=" & AUTOFAC
            End If
            If NUMERO <> "" Then
                sql += " AND NUMERO=" & NUMERO
            End If
            If CLIENTE_FAC <> "" Then
                sql += " AND CLIENTE_FAC=" & CLIENTE_FAC
            End If
            If FECHA_FAC_DESDE <> "" Then
                sql += " AND FECHA_FAC>='" & conviertefecha_tomysql(FECHA_FAC_DESDE) & "'"
            End If
            If FECHA_FAC_HASTA <> "" Then
                sql += " AND FECHA_FAC<='" & conviertefecha_tomysql(FECHA_FAC_HASTA) & "'"
            End If
            sql += " ORDER BY FECHA_FAC, NUMERO"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Get_ListadoFacturas(ByVal NUMFAC As String, ByVal FECHA_FAC As String, ByVal CLIENTE_FAC As String, ByVal Estado As String) As DataTable
        Dim dt As DataTable
        Dim sql As String
        Dim sqlwhere As String = String.Empty
        Dim sqlhaving As String = String.Empty
        Dim sqlgroup As String = String.Empty
        Try
            sql = "SELECT f.AUTOFAC,f.NUMFAC, f.FECHA_FAC, f.FECHA_COBRO,f.FECHA_VTO,f.IMPORTE_FAC,f.CLIENTE_FAC,f.IMPORTE_FAC,f.CONCEPTO_FAC,clientes.CLINOM, "
            sql += "(SELECT SUM(IMPORTE_COBRO) from cobros WHERE NUFACTURA_COB = f.NUMFAC) AS SUMCOBRADO "
            sql += "FROM facturas f LEFT JOIN clientes ON f.CLIENTE_FAC = clientes.CODIGOCLI "
            sqlgroup += "Group BY f.AUTOFAC,f.NUMFAC, f.FECHA_FAC, f.FECHA_COBRO,f.FECHA_VTO,f.IMPORTE_FAC, f.CLIENTE_FAC,f.IMPORTE_FAC,f.CONCEPTO_FAC, clientes.CLINOM "
            sqlhaving += "HAVING f.AUTOFAC>0 "
            If FECHA_FAC <> "" Then
                If FECHA_FAC.IndexOf("-") > -1 Then
                    Dim fechas As String() = FECHA_FAC.Split(" - ")
                    sqlhaving += " And f.FECHA_FAC>='" & conviertefecha_tomysql(fechas(0)) & "' AND f.FECHA_FAC<='" & conviertefecha_tomysql(fechas(2)) & "'"
                Else
                    sqlhaving += " AND f.FECHA_FAC = '" & conviertefecha_tomysql(FECHA_FAC) & "'"
                End If
            End If
            If NUMFAC <> "" Then
                sqlhaving += " AND f.NUMFAC='" & NUMFAC & "'"
            End If

            If CLIENTE_FAC <> "" Then
                sqlhaving += " And f.CLIENTE_FAC = " & CLIENTE_FAC
            End If

            If Estado <> "" Then
                Select Case Estado
                    Case "PC" 'Pendientes cobro
                        sqlhaving += " AND f.FECHA_COBRO IS NULL"
                    Case "C" 'Cobradas
                        sqlhaving += " AND f.FECHA_COBRO IS NOT NULL"
                    Case "CP" 'Cobros parciales
                        sqlhaving += " AND (f.FECHA_COBRO IS NULL AND SUMCOBRADO>0)"
                    Case "VS" 'Vencen esta semana
                        sqlhaving += " AND f.FECHA_COBRO IS NULL AND YEARWEEK(f.FECHA_VTO)=YEARWEEK(CURDATE())"
                    Case "FV" 'Fuera vencimiento
                        sqlhaving += " AND f.FECHA_COBRO IS NULL AND f.FECHA_VTO<'" & conviertefecha_tomysql(Date.Today()) & "'"
                End Select
            End If
            sql = sql & sqlwhere & sqlgroup & sqlhaving
            sql += " ORDER BY f.FECHA_FAC DESC, f.CLIENTE_FAC, f.NUMFAC"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Datos_Factura(ByVal AUTOFAC As String, ByVal NUMFAC As String) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT f.*, clientes.CLINOM, clientes.EMAIL, (SELECT SUM(IMPORTE_COBRO) from cobros WHERE NUFACTURA_COB = f.NUMFAC) As SUMCOBRADO "
            sql += "FROM facturas f LEFT JOIN clientes ON f.CLIENTE_FAC = clientes.CODIGOCLI WHERE AUTOFAC>0"

            If AUTOFAC <> "" Then
                sql += " AND f.AUTOFAC=" & AUTOFAC
            End If
            If NUMFAC <> "" Then
                sql += " AND f.NUMFAC='" & NUMFAC & "'"
            End If

            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Portes_Factura(ByVal AUTOFAC As String) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT portes.* "
            sql += "FROM facturas_portes f LEFT JOIN portes ON f.AUTOPORTE = portes.AUTOPORTE WHERE AUTOFAC=" & AUTOFAC

            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Portes_Cliente_Factura(ByVal CODCLI As String, ByVal TIPO_PORES As String, ByVal HastaFechaPortes As String, ByVal Matricula As String, ByVal CodAgencia As String) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT portes.* FROM portes WHERE portes.CODCLI=" & CODCLI & " AND portes.FECOBRO IS NULL AND PARAFACTURAR<>'N'"
            If TIPO_PORES <> "" Then
                If TIPO_PORES = "P" Then 'Pendientes de facturar
                    sql += " AND FACTURA IS NULL"
                Else ' A = Con albaranes
                    sql += " AND FACTURA IS NULL AND FEPAGO IS NOT NULL"
                End If
            End If
            If HastaFechaPortes <> "" Then
                sql += " AND portes.FECHA<='" & conviertefecha_tomysql(HastaFechaPortes) & "'"
            End If
            If Matricula <> "" Then
                sql += " AND portes.MATRICULA='" & Matricula & "'"
            End If
            If CodAgencia <> "" Then
                sql += " AND portes.CODP_AGENCIA=" & CodAgencia
            End If
            sql += " ORDER BY portes.FECHA, portes.NUMPOR"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Cobros_Factura(ByVal AUTOFAC As String, ByVal NUMFAC As String) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT * FROM cobros WHERE AUTOCOBRO>0"

            If AUTOFAC <> "" Then
                sql += " AND AUTOFAC=" & AUTOFAC
            End If
            If NUMFAC <> "" Then
                sql += " AND NUFACTURA_COB='" & NUMFAC & "'"
            End If
            sql += " ORDER BY FECHA_COBRO DESC, AUTOCOBRO DESC"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Factura_Emails(ByVal AUTOFAC As String) As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT * FROM facturas_envios_emails WHERE ID>0"

            If AUTOFAC <> "" Then
                sql += " AND AUTOFAC=" & AUTOFAC
            End If
            sql += " ORDER BY FECHA_ENIVO DESC"
            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region

#Region "Prepara_BBDD_Mysql"
    Public Function Prepara_BBDD_MYsql() As String
        Dim msg As String = String.Empty
        Dim sql As String
        Dim dt As DataTable
        Dim dtcobros As DataTable
        Dim regs As Integer
        Dim cu As Long
        Dim i As Long
        Dim x As Long
        Dim pos As Integer
        Dim filas As Int32 = 0
        Dim cadena As String
        Dim autoporte As String
        Try
            '************************************************
            '*** Seleccionamos las Facturas, extraemos los Portes de la Factura y los guardamos en la tabla "facturas_portes"
            sql = "SELECT * FROM facturas ORDER BY AUTOFAC"
            dt = objMySQL.Consulta(sql)
            If dt.Rows.Count > 0 Then
                regs = objMySQL.BorrarRegistrosTabla("facturas_portes", "")
                cu = dt.Rows.Count
                For x = 0 To cu - 1
                    cadena = "" & dt.Rows(x).Item("CONCEPTO_FAC")
                    If cadena <> "" Then
                        pos = cadena.IndexOf("Nº: ")
                        If pos > 0 Then
                            cadena = cadena.Substring(pos + 4, cadena.Length - (pos + 4))
                            Dim arrportes As String() = cadena.Split(",")
                            For ii = 0 To arrportes.Length - 1
                                cadena = arrportes(ii).Replace(" ", "")
                                autoporte = Get_Autoporte(cadena)
                                If autoporte = "" Then
                                    cadena = "Porte " & autoporte & " no encontrado."
                                Else
                                    sql = "INSERT INTO facturas_portes (AUTOFAC, AUTOPORTE) VALUES("
                                    sql += dt.Rows(x).Item("AUTOFAC").ToString().Replace(" ", "") & "," & autoporte
                                    sql += ")"
                                    filas = objMySQL.Alta(sql, "")
                                End If
                            Next
                        End If
                    End If

                    'si la factura está cobrada, buscar en cobros el registro del cobro y si no existe añadirlo
                    sql = "SELECT * FROM cobros WHERE NUFACTURA_COB='" & dt.Rows(x).Item("NUMFAC").ToString().Replace(" ", "") & "'"
                    dtcobros = objMySQL.Consulta(sql)
                    If dtcobros.Rows.Count > 0 Then
                        ' campo añadido AUTOFAC tabla "cobros". Añadir el AUTOFAC de cada factura si existe el registro en cobros
                        sql = "UPDATE cobros SET AUTOFAC=" & dt.Rows(x).Item("AUTOFAC").ToString().Replace(" ", "")
                        sql += " WHERE NUFACTURA_COB='" & dt.Rows(x).Item("NUMFAC").ToString().Replace(" ", "") & "'"
                        filas = objMySQL.EjecutaQuery(sql)
                    End If
                Next
            End If

            sql = "SELECT f.AUTOFAC, f.NUMFAC, f.IMPORTE_FAC, f.FECHA_COBRO, c.IMPORTE_COBRO FROM facturas f LEFT JOIN cobros c ON f.AUTOFAC = c.AUTOFAC WHERE f.FECHA_COBRO IS NOT NULL ORDER BY f.AUTOFAC"
            dtcobros = objMySQL.Consulta(sql)
            If dtcobros.Rows.Count > 0 Then
                Dim swaltacobro As Boolean = True
                Dim importecobro As Double = 0
                Dim importefactura As Double = 0
                Dim newimportecobro As Double = 0
                Dim dt2 As DataTable
                cu = dtcobros.Rows.Count
                For x = 0 To cu - 1
                    swaltacobro = True
                    importefactura = dtcobros.Rows(x).Item("IMPORTE_FAC")

                    sql = "SELECT SUM(c.IMPORTE_COBRO) AS SUMACOBROS FROM cobros c WHERE c.AUTOFAC=" & dtcobros.Rows(x).Item("AUTOFAC")
                    dt2 = objMySQL.Consulta(sql)
                    If dt2.Rows.Count > 0 Then
                        If dt2.Rows(0).Item("SUMACOBROS").ToString() <> "" Then
                            If dt2.Rows(0).Item("SUMACOBROS") >= dtcobros.Rows(x).Item("IMPORTE_FAC") Then
                                swaltacobro = False
                            Else
                                importecobro = dt2.Rows(0).Item("SUMACOBROS")
                                newimportecobro = importefactura - importecobro
                                sql = "INSERT INTO cobros (AUTOFAC, NUFACTURA_COB, IMPORTE_COBRO, FECHA_COBRO) VALUES("
                                sql += dtcobros.Rows(x).Item("AUTOFAC").ToString().Replace(" ", "") & ","
                                sql += "'" & dtcobros.Rows(x).Item("NUMFAC").ToString() & "',"
                                sql += newimportecobro.ToString().Replace(",", ".") & ","
                                sql += "'" & conviertefecha_tomysql(dtcobros.Rows(x).Item("FECHA_COBRO").ToString()) & "'"
                                sql += ")"
                                filas = objMySQL.Alta(sql, "")
                                swaltacobro = False
                            End If
                        End If
                    End If
                    If swaltacobro = True Then
                        sql = "INSERT INTO cobros (AUTOFAC, NUFACTURA_COB, IMPORTE_COBRO, FECHA_COBRO) VALUES("
                        sql += dtcobros.Rows(x).Item("AUTOFAC").ToString().Replace(" ", "") & ","
                        sql += "'" & dtcobros.Rows(x).Item("NUMFAC").ToString() & "',"
                        sql += dtcobros.Rows(x).Item("IMPORTE_FAC").ToString().Replace(",", ".") & ","
                        sql += "'" & conviertefecha_tomysql(dtcobros.Rows(x).Item("FECHA_COBRO").ToString()) & "'"
                        sql += ")"
                        filas = objMySQL.Alta(sql, "")
                    End If
                Next
            End If

        Catch ex As Exception
            msg = ex.Message
        End Try
        Return msg
    End Function

#End Region

#Region "Contadores"
    Public Function Get_Autoporte(ByVal num_porte As String) As String
        Dim autopporte As String = String.Empty
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT AUTOPORTE "
            sql += "FROM portes WHERE NUMPOR=" & num_porte

            dt = objMySQL.Consulta(sql)
            If dt.Rows.Count > 0 Then
                autopporte = dt.Rows(0).Item("AUTOPORTE").ToString()
            End If
            Return autopporte
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function Get_Num_Portes() As Long
        Dim dt As DataTable
        Dim sql As String
        Dim num_porte As Long = 0
        Try
            sql = "SELECT PORTE "
            sql += "FROM contadores WHERE ANOPORTE=" & Year(Date.Today).ToString()

            dt = objMySQL.Consulta(sql)
            If dt.Rows.Count > 0 Then
                num_porte = CLng(dt.Rows(0).Item("PORTE"))
            Else
                num_porte = 1
            End If
            Return num_porte
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Num_Factura() As Long
        Dim dt As DataTable
        Dim sql As String
        Dim num_porte As Long = 0
        Try
            sql = "SELECT MAX(NUMERO) "
            sql += "FROM facturas WHERE YEAR(FECHA_FAC)=" & Year(Date.Today).ToString()

            dt = objMySQL.Consulta(sql)
            If dt.Rows.Count > 0 Then
                num_porte = CLng(dt.Rows(0).Item("PORTE"))
            Else
                num_porte = 1
            End If
            Return num_porte
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Get_Datos_Factura(ByVal AUTOFAC As String) As DataSet
        Dim ds As New DataSet
        Dim dt As New DataTable("DatosFactura")
        Dim dtportes As New DataTable("PortesFactura")

        Dim sql As String
        Dim num_porte As Long = 0
        Try
            sql = "SELECT f.*, cli.CLINOM, cli.CLIDIR, cli.CLIPOB, cli.CLICODPOS, cli.PROVINCIA, cli.CLICIF FROM facturas f LEFT JOIN clientes cli ON f.CLIENTE_FAC = cli.CODIGOCLI WHERE f.AUTOFAC=" & AUTOFAC
            dt = objMySQL.Consulta(sql)
            If dt.Rows.Count > 0 Then
                dtportes = Get_Portes_Factura(AUTOFAC)
            End If
            ds.Tables.Add(dt)
            ds.Tables.Add(dtportes)
            Return ds
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Graba_EnvioEmail_Factura(ByVal AUTOFAC As String, ByVal email As String) As String
        Dim msg As String = String.Empty
        Dim id As Int32 = 0
        Dim sql As String
        Try
            sql = "INSERT INTO facturas_envios_emails (AUTOFAC, EMAIL_DESTINO) VALUES("
            sql += AUTOFAC & ",'" & email & "')"
            id = objMySQL.Alta(sql, "")
        Catch ex As Exception
            msg = "Error al grabar el registro del envío del email de la factura con la cuenta de email"
        End Try
        Return msg
    End Function

    Public Function Get_Datos_SMTP() As DataTable
        Dim dt As DataTable
        Dim sql As String

        Try
            sql = "SELECT * FROM configuracion_smtp"

            dt = objMySQL.Consulta(sql)

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region
End Class
