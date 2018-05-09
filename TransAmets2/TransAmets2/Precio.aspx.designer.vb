'------------------------------------------------------------------------------
' <generado automáticamente>
'     Este código fue generado por una herramienta.
'
'     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
'     se vuelve a generar el código. 
' </generado automáticamente>
'------------------------------------------------------------------------------

Option Strict On
Option Explicit On


Partial Public Class Precio
    
    '''<summary>
    '''Control UpdatePanel1.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents UpdatePanel1 As Global.System.Web.UI.UpdatePanel
    
    '''<summary>
    '''Control hdnPrecioId.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents hdnPrecioId As Global.System.Web.UI.WebControls.HiddenField
    
    '''<summary>
    '''Control hdnClienteId.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents hdnClienteId As Global.System.Web.UI.WebControls.HiddenField
    
    '''<summary>
    '''Control hndDirCliente_id.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents hndDirCliente_id As Global.System.Web.UI.WebControls.HiddenField
    
    '''<summary>
    '''Control hndPrimeravez.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents hndPrimeravez As Global.System.Web.UI.WebControls.HiddenField
    
    '''<summary>
    '''Control hndAlta.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents hndAlta As Global.System.Web.UI.WebControls.HiddenField
    
    '''<summary>
    '''Control hndBaja.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents hndBaja As Global.System.Web.UI.WebControls.HiddenField
    
    '''<summary>
    '''Control hdnControlJS.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents hdnControlJS As Global.System.Web.UI.HtmlControls.HtmlInputHidden
    
    '''<summary>
    '''Control hndTipoError.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents hndTipoError As Global.System.Web.UI.HtmlControls.HtmlInputHidden
    
    '''<summary>
    '''Control hdnTitulo.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents hdnTitulo As Global.System.Web.UI.HtmlControls.HtmlInputHidden
    
    '''<summary>
    '''Control hdnRedirect.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents hdnRedirect As Global.System.Web.UI.HtmlControls.HtmlInputHidden
    
    '''<summary>
    '''Control hdnReload.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents hdnReload As Global.System.Web.UI.HtmlControls.HtmlInputHidden
    
    '''<summary>
    '''Control lblTituloPag.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblTituloPag As Global.System.Web.UI.HtmlControls.HtmlGenericControl
    
    '''<summary>
    '''Control UP_Botones.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents UP_Botones As Global.System.Web.UI.UpdatePanel
    
    '''<summary>
    '''Control btnGuardar.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnGuardar As Global.System.Web.UI.HtmlControls.HtmlButton
    
    '''<summary>
    '''Control btnCancel.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnCancel As Global.System.Web.UI.HtmlControls.HtmlButton
    
    '''<summary>
    '''Control txtFecPrecio.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtFecPrecio As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control txtTns.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtTns As Global.System.Web.UI.HtmlControls.HtmlInputText
    
    '''<summary>
    '''Control txtCodCli.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtCodCli As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control txtCliente.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtCliente As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control lbldeleteprescriptor.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lbldeleteprescriptor As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control lblicobuscadorPrescriptor.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblicobuscadorPrescriptor As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control txtCompra.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtCompra As Global.System.Web.UI.HtmlControls.HtmlInputText
    
    '''<summary>
    '''Control txtVenta.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtVenta As Global.System.Web.UI.HtmlControls.HtmlInputText
    
    '''<summary>
    '''Control txtSegundaDescarga.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtSegundaDescarga As Global.System.Web.UI.HtmlControls.HtmlInputText
    
    '''<summary>
    '''Control txtMercancia.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtMercancia As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control ddlTipocam.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlTipocam As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control ddlVolumen.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlVolumen As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control ddlOrigen.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlOrigen As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control txtDetalleOrigen.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtDetalleOrigen As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control ddlDestino.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlDestino As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control txtDetalleDestino.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtDetalleDestino As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control hndEndSession.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents hndEndSession As Global.System.Web.UI.HtmlControls.HtmlInputHidden
End Class
