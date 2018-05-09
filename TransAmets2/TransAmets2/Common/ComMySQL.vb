Imports MySql.Data.MySqlClient

Public Class ComMySQL
    Public conMySQL As MySqlConnection

    Public Function Conectar() As MySqlConnection
        Try
            'Dim conMySQL As MySqlConnection
            conMySQL = New MySqlConnection
            conMySQL.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("ConectionMysqlAMETS").ConnectionString
            'se abre la conexion
            conMySQL.Open()

            'Dim connectionString As String = "Data Source=" & FrmInicio.config.AppSettings.Settings.Item("ServerWeb").Value.ToString() & ";database=" & FrmInicio.config.AppSettings.Settings.Item("DataBaseWeb").Value.ToString() & ";uid=" & FrmInicio.config.AppSettings.Settings.Item("UserServerWeb").Value.ToString() & ";pwd=" & FrmInicio.config.AppSettings.Settings.Item("PwdServerWeb").Value.ToString() & ";Allow Zero Datetime=False;Convert Zero Datetime=true;"
            ''conMySQL = New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("ConnectionMySQL").ToString()) '("Server=127.0.0.1;DataBase=Nombre_de_la_BD;uid=Usuario;pwd=Contraseña").ToString
            'conMySQL = New MySqlConnection(connectionString)
            'conMySQL.Open()
        Catch ex As Exception
            Throw ex
            'MsgBox("Error al conectar al Servidor de MySQL. " & ex.Message.ToString(), MsgBoxStyle.Critical, "Conectar a BBDD MySQL")
        End Try

        Return conMySQL
    End Function

    Public Sub Desconectar()
        Try
            'Cerrar la conexion si esta abierta
            If conMySQL.State = ConnectionState.Open Then
                conMySQL.Close() 'Cerrar la conexion
                conMySQL.Dispose() 'Liberar recursos
            End If
        Catch ex As Exception
            Throw ex
            'MsgBox("Error al cerrar la BBDD de MySQL. " & ex.Message, MsgBoxStyle.Critical, "Desconectar de MySQL")
        End Try
    End Sub

    Public Function cambiarfecha_mysql(ByVal fecha As String) As String
        Dim fechamysql As String = ""
        If fecha.Trim() <> "" Then

            If fecha = "05/23/2012" Or fecha = "23/05/2012" Then
                fecha = fecha
            End If
            If fecha.IndexOf(" ") > 0 Then
                fecha = fecha.Substring(0, fecha.IndexOf(" "))
            End If
            Dim datos() As String = Split(fecha, "/")
            fechamysql = datos(2) & "-" & datos(1) & "-" & datos(0)
        End If

        Return fechamysql
    End Function


    Public Function Consulta(ByVal sql As String) As DataTable
        Dim dt As DataTable = New DataTable
        Try
            Conectar()
            'Dim md As MySqlDataAdapter = New MySqlDataAdapter(sql, conMySQL)
            ''Dim cmd As MySqlCommandBuilder = New MySqlCommandBuilder(md)
            'md.Fill(ds)
            'If ds.Tables.Count > 0 Then
            '    dt = ds.Tables(0)
            'End If

            Using cmd As New MySqlCommand(sql, conMySQL)
                cmd.CommandType = CommandType.Text
                Using sda As New MySqlDataAdapter(cmd)
                    Using dt
                        sda.Fill(dt)
                    End Using
                End Using
            End Using


        Catch ex As Exception
            Throw ex
        Finally
            Desconectar() 'Cerrar la Conexion a la BD
        End Try

        Return dt
    End Function

    Public Function ConsultaReader(ByVal sql As String) As DataTable
        Dim dr As MySqlDataReader = Nothing 'Guardara las filas de la consulta
        Dim dt As DataTable = New DataTable
        Dim schemaTable As DataTable
        Conectar() 'Conectar al servidor

        Try
            Dim query As New MySqlCommand(sql, conMySQL) 'Especificamos la sentencia MySQL
            dr = query.ExecuteReader() 'Ejecuta la sentencia MySQL
            If dr.HasRows Then
                'dt.Load(dr) ', LoadOption.OverwriteChanges)
                schemaTable = dr.GetSchemaTable()
                For Each row As DataRow In schemaTable.Rows
                    dt.Columns.Add(row.Item("ColumnName"), Type.GetType(row.Item("DataType").ToString))
                Next
                While (dr.Read())
                    Dim row As DataRow = dt.NewRow
                    For i = 0 To dr.FieldCount - 1
                        'If dr.Item(i).GetType() = TypeOf (System.DateTime) Then
                        If dr.Item(i).DataType = Type.GetType("System.DateTime") Then
                            Dim valor As String = dr.Item(i).ToString.Trim
                            Dim x() As String = Split(valor, " ")
                            Dim fecha As String
                            Dim lafecha As Date
                            Dim hora As String = "00:00:00"
                            If valor <> "" Then
                                lafecha = Convert.ToDateTime(x(0))
                                fecha = lafecha.Day & "/" & lafecha.Month & "/" & lafecha.Year
                                If x.Length > 1 Then
                                    fecha = fecha & " " & x(1)
                                End If
                                row.Item(i) = Convert.ToDateTime(fecha)
                            Else
                                row.Item(i) = System.DBNull.Value
                            End If
                        Else
                            row.Item(i) = dr.Item(i)
                        End If
                    Next
                    dt.Rows.Add(row)
                End While
            Else
                schemaTable = dr.GetSchemaTable()
                'For each field in the table...
                For Each myField As DataRow In schemaTable.Rows
                    dt.Columns.Add(myField.Item("ColumnName"), Type.GetType(myField.Item("DataType").ToString))
                    'If myField.Item("DataType").ToString = "System.String" Then
                    'End If
                    ''For each property of the field...
                    'For Each myProperty As DataColumn In schemaTable.Columns
                    '    dt.Columns.Add(myProperty.ColumnName, Type.GetType(myProperty.DataType.ToString))
                    'Next
                Next
            End If

        Catch ex As Exception
            'MsgBox("Error en la consulta de MySQL. " & ex.Message, MsgBoxStyle.Critical, "Consulta de MySQL") 'Muestra un mensaje de Error si lo hay
            Throw ex
        End Try

        Return dt
    End Function

    Public Function Alta(ByVal sql As String, ByVal Proceso As String) As Integer
        Conectar() 'Conectar a la BD
        Dim filas As Integer = 0 'Guardara las filas afectadas

        Try
            Dim query As New MySqlCommand(sql, conMySQL) 'Especifica la Sentencia MySQL
            filas = query.ExecuteNonQuery() 'Ejecuta la Sentencia MySQL

        Catch ex As Exception
            Throw ex
        Finally
            Desconectar() 'Cerrar la Conexion a la BD
        End Try

        Return filas
    End Function

    Public Function Alta_ReturnNewID(ByVal sql As String, ByVal Proceso As String) As Integer
        Conectar() 'Conectar a la BD
        Dim filas As Int32 = 0 'Guardara las filas afectadas

        Try
            Dim query As New MySqlCommand(sql, conMySQL) 'Especifica la Sentencia MySQL
            filas = query.ExecuteNonQuery() 'Ejecuta la Sentencia MySQL
            ' If has last inserted id, add a parameter to hold it.

            query.Parameters.Add(New MySqlParameter("newId", query.LastInsertedId))

            'Return the id of the new record. Convert from Int64 to Int32 (int).
            filas = Convert.ToInt32(query.Parameters("@newId").Value)

        Catch ex As Exception
            Throw ex
        Finally
            Desconectar() 'Cerrar la Conexion a la BD
        End Try

        Return filas
    End Function

    Public Function BorrarRegistrosTabla(ByVal tabla As String, Optional sql As String = "") As Integer
        Conectar() 'Conectar a la BD
        Dim filas As Integer = 0 'Guardara las filas afectadas

        Try
            If sql = "" Then
                'sql = "DELETE From " & tabla
                'sql = "ALTER TABLE " & tabla & " AUTO_INCREMENT = 1"
                sql = "TRUNCATE TABLE " & tabla & ";ALTER TABLE " & tabla & " AUTO_INCREMENT = 1;"
            End If
            Dim query As New MySqlCommand(sql, conMySQL) 'Especifica la Sentencia MySQL
            filas = query.ExecuteNonQuery() 'Ejecuta la Sentencia MySQL

        Catch ex As Exception
            Throw ex
        End Try

        Desconectar() 'Cerrar la Conexion a la BD

        Return filas
    End Function

    Public Function EjecutaQuery(ByVal sql As String) As Integer
        Conectar() 'Conectar a la BD
        Dim filas As Integer = 0 'Guardara las filas afectadas

        Try
            Dim query As New MySqlCommand(sql, conMySQL) 'Especifica la Sentencia MySQL
            filas = query.ExecuteNonQuery() 'Ejecuta la Sentencia MySQL

        Catch ex As Exception
            Throw ex
        Finally
            Desconectar() 'Cerrar la Conexion a la BD
        End Try

        Return filas
    End Function

#Region "PedidosWeb"

    Public Sub CargaClientes()
        Dim dt As New DataTable
        Dim sql As String = String.Empty
        Dim contok As Long = 0
        Dim ok As Integer = 0

        Dim xi As Integer = 0

        Try
            Conectar() 'Conectar a la BD

            For i As Long = 0 To dt.Rows.Count - 1
                ' buscar la descripción de la forma de pago
                sql = "INSERT INTO clientes (codcli,nom,cif,codpos,cal1,email,pagweb,tel1,tel2,fax,nomcom,percon,obs,"
                sql += "forpag,pripag,numpag,entpag,diapag1,diapag2,aviso,login,pwd,riecon,tipivacli,codrep,tandesco1,"
                sql += "nomenv,calenv,codposenv) values("
                sql += dt.Rows(i).Item("codcli").ToString().Trim() & ","
                sql += "'" & dt.Rows(i).Item("nom").ToString().Trim().Replace("'", "\'") & "','" & dt.Rows(i).Item("cif").ToString().Trim() & "',"
                sql += "'" & dt.Rows(i).Item("codpos").ToString().Trim() & "','" & dt.Rows(i).Item("cal1").ToString().Trim().Replace("'", "\'") & "',"
                sql += "'" & dt.Rows(i).Item("email").ToString().Trim() & "','" & dt.Rows(i).Item("pagweb").ToString().Trim().Replace("'", "\'") & "',"
                sql += "'" & dt.Rows(i).Item("tel1").ToString().Trim() & "','" & dt.Rows(i).Item("tel2").ToString().Trim() & "',"
                sql += "'" & dt.Rows(i).Item("fax").ToString().Trim() & "','" & dt.Rows(i).Item("nomcom").ToString().Trim().Replace("'", "\'") & "',"
                sql += "'" & dt.Rows(i).Item("percon").ToString().Trim().Replace("'", "\'") & "','" & dt.Rows(i).Item("obs").ToString().Trim().Replace("'", "\'") & "',"
                'sql += "'" & desforpag.Trim().Replace("'", "\'") & "',"
                sql += dt.Rows(i).Item("pripag").ToString() & "," & dt.Rows(i).Item("numpag").ToString() & ","
                sql += dt.Rows(i).Item("entpag").ToString() & "," & dt.Rows(i).Item("diapag1").ToString() & ","
                sql += dt.Rows(i).Item("diapag2").ToString() & ",'" & dt.Rows(i).Item("aviso").ToString().Replace("'", "\'") & "',"
                sql += "'" & dt.Rows(i).Item("login").ToString().Trim() & "','" & dt.Rows(i).Item("pwd").ToString().Trim() & "',"
                sql += dt.Rows(i).Item("riecon").ToString().Replace(",", ".") & ",'" & dt.Rows(i).Item("tipivacli").ToString() & "',"
                sql += dt.Rows(i).Item("codrep").ToString() & "," & dt.Rows(i).Item("tandesco1").ToString().Replace(",", ".") & ","
                sql += "'','" & dt.Rows(i).Item("calenv").ToString().Trim().Replace("'", "\'") & "','" & dt.Rows(i).Item("codposenv").ToString().Trim() & "')"

                ok = Alta(sql, "Carga Clientes")
                If ok > 0 Then contok += 1

            Next
        Catch ex As Exception
            Throw ex
        Finally
            Desconectar() 'Cerrar la Conexion a la BD
        End Try

    End Sub

    Public Function UltPedidoWeb(ByVal tipo As String) As Long
        Dim ultpedido As Long = 0
        Dim sql As String = String.Empty
        Dim dtc As DataTable = Nothing

        sql = "SELECT numped from pedclica where Canal=''" ' AND Eje=" & Convert.ToInt16(FrmInicio.config.AppSettings.Settings.Item("Ejercicio").Value)
        Select Case tipo
            Case "PEDIDOS"
                sql += " AND Tipped='P'"
            Case "ALBARANES"
                sql += " AND Tipped='A'"
            Case "FACTURAS"
                sql += " AND Tipped='F'"
        End Select
        Try
            dtc = Consulta(sql)
            If dtc.Rows.Count > 0 Then
                ultpedido = dtc.Rows(0).Item("numped")
            End If
            dtc.Dispose()
        Catch ex As Exception
            Throw ex
        End Try

        Return ultpedido
    End Function
#End Region

End Class
