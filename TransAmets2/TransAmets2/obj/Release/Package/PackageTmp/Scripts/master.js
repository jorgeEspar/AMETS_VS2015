$(document).ready(function () {

    moment.locale('es'); // default the locale to English
    var localLocale = moment();

    InitLeftMenu();
    LeftMenuToggleHandler();

   InitTopMenu();

    $('#logoff').click(function () {
        loginoff();
    });
});
function InitLeftMenu()
{
    //HOME
    $('#menuHomeLink').attr('href', 'principal.aspx');
    $('#menuNewWindow').attr('href', 'principal.aspx');
    $('#menuNewWindow').attr('target', '_blank');
     
    //Portes
    $('#menuMtoPortes').attr('href', 'portes_listado.aspx');
    $('#menuPorteNuevo').attr('href', 'Porte.aspx?id=&N=S&B=N');
    $('#menuListPreportes').attr('href', 'preportes_listado.aspx');
    $('#menuListPreportesNew').attr('href', 'preportes_listado.aspx');
    $('#menuListPreportesNew').attr('target', 'Preportes');
    $('#menuPreporteNew').attr('href', 'Preporte.aspx?id=&N=S&B=N');

    //MANTENIMIENTOS
    $('#menuMtoClientes').attr('href', 'MtoClientesListado.aspx');     // Mto Clientes
    $('#menuMtoTransportistas').attr('href', 'MtoTransportistasListado.aspx');  // Mto Transportistas
    $('#menuMovimientosClientes').attr('href', 'MovimientosClientesListado.aspx');     // Movimiento Clientes
    $('#menuMovimientosTransportistas').attr('href', 'MovimientosTransportistasListado.aspx');  // Movimiento Transportistas

    //Facturas
    $('#menuListadoFacturas').attr('href', 'facturas_listado.aspx');       // Facturas Listado
    $('#menuGeneracionFacturas').attr('href', 'Factura.aspx?id=&N=S&B=N'); // Facturas

    //ADMINISTRATION
    $('#menuGestionUsers').attr('href', 'GestionUsuarios.aspx');
    $('#menuConfiguracionApli').attr('href', 'ConfiguracionApli.aspx');
    $('#menuPrepararBBDDMysql').attr('href', 'preparar_bbdd_mysql.aspx');
    
}

function LeftMenuToggleHandler()
{
    //left menu toggle event handler - add to footer
    //$("#menu-toggle").click(function (e) { e.preventDefault(); $("#wrapper").toggleClass("toggled"); });

    //Submenu
    $('.dropdown .dropdown').each(function () {
        var $self = $(this);
        var handle = $self.children('[data-toggle="dropdown"]');
        $(handle).click(function () {
            var submenu = $self.children('.dropdown-menu');
            $(submenu).toggle();
            return false;
        });
    });

    //Close submenu on mouse leave from a sub menu
    $('.dropdown-menu').mouseleave(function () {
        $(".myFakeClass").hide();
    });

    //Close submenu on mouse leave from first level menu
    $('[data-toggle="dropdown"]').mouseenter(function () {
        $(".myFakeClass").hide();
    });


    $('.navbar-header .dropdown-menu').on('show.bs.dropdown', function (e) {
        $(this).find('.dropdown').first().stop(true, true).slideDown();
    });


    $('.dropdown .dropdown').on('hide.bs.dropdown', function (e) {
        $(this).find('.dropdown-menu').first().stop(true, true).slideUp();
    });
 
}

function InitTopMenu()
{
    updateTime();
}

function updateTime()
{
    var datetime = null,
        date = null;
    
    var update = function () {
        date = moment(new Date());
        dia = moment().format('dddd');
        dia = capitalizeFirstLetter(dia);
        mes = moment.months()[moment().month()];
        mes = capitalizeFirstLetter(mes);
        //sdate = date.format('ddd, MMM D YYYY, h:mm:ss A');
        sdate = dia + " " + date.format('D') + " de " + mes + " de " + date.format('YYYY, h:mm:ss A');
        datetime.html(sdate);
    };

    datetime = $('.topUserInfo span:eq(0)');
    update();
    setInterval(update, 1000);
}
function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}