import 'package:deliveryapplicacion/controladores/ordenes_controller.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/servicios/shared_preferences.dart';
import 'package:deliveryapplicacion/vistas/edit_dir_page.dart';
import 'package:deliveryapplicacion/vistas/edit_pass_page.dart';
import 'package:deliveryapplicacion/vistas/edit_phone_page.dart';
import 'package:deliveryapplicacion/vistas/pedidos_history_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  final storage = new StorageCliente();
  final _pedidosController = new OrdenesController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: size.width * 0.2),
      child: Column(
        children: [
          _titulo(),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icono(size),
              SizedBox(width: size.height * 0.02),
              Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  _saludo(),
                  SizedBox(height: size.height * 0.02),
                  _saludo2(),
                  SizedBox(height: size.height * 0.02),
                  _saludo3()
                  //_body(size)
                ],
              ),
            ],
          ),
          SizedBox(height: size.height * 0.05),
          _options(context)
        ],
      ),
    ));
  }

  Widget _titulo() {
    final style = TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 25,
        color: Recursos().colorPrimario);
    return Text('Mi Perfil', style: style);
  }

  Widget _saludo() {
    final style = TextStyle(fontSize: 25.0, color: Recursos().colorPrimario);
    return Text('Hola ${storage.nombreStorage.split(' ')[0]}!', style: style);
  }

  Widget _saludo2() {
    final style = TextStyle(color: Recursos().colorPrimario);
    return Text('Bienvenido a El Cipitillo ', style: style);
  }

  Widget _saludo3() {
    final style = TextStyle(color: Recursos().colorPrimario);
    return Text('+503 7861 9772 ', style: style);
  }

  Widget _icono(Size size) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(50), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 11,
          offset: Offset(0, 3),
        ),
      ]),
      child: CircleAvatar(
        radius: size.width * 0.13,
        backgroundColor: Recursos().colorTerciario,
        child: Text(_iniciales()),
      ),
    );
  }

  Widget _options(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 35, horizontal: 10.0),
      child: Column(
        children: [
          Divider(color: Recursos().colorPrimario),
          _telefono(context),
          Divider(color: Recursos().colorPrimario),
          _clave(context),
          Divider(color: Recursos().colorPrimario),
          _historial(context),
          Divider(color: Recursos().colorPrimario),
          _direcciones(context),
          Divider(color: Recursos().colorPrimario),
          _btnSalir(context),
          Divider(color: Recursos().colorPrimario),
        ],
      ),
    );
  }

  Widget _telefono(BuildContext context) {
    return ListTile(
      title: Container(
        child: Text(
          'Editar mi numero de telefono',
          style: TextStyle(
            color: Recursos().colorPrimario,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      leading: Icon(Icons.phone_android, color: Recursos().colorPrimario),
      trailing: Icon(Icons.chevron_right, color: Recursos().colorPrimario),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EditPhone()));
      },
    );
  }

  Widget _clave(BuildContext context) {
    return ListTile(
      title: Container(
        child: Text(
          'Cambiar contraseña',
          style: TextStyle(
            color: Recursos().colorPrimario,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      leading: Icon(Icons.vpn_key, color: Recursos().colorPrimario),
      trailing: Icon(Icons.chevron_right, color: Recursos().colorPrimario),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EditPass()));
      },
    );
  }

  Widget _historial(BuildContext context) {
    return ListTile(
      title: Container(
        child: Text(
          'Historial de pedidos',
          style: TextStyle(
            color: Recursos().colorPrimario,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      leading: Icon(Icons.list, color: Recursos().colorPrimario),
      trailing: Icon(Icons.chevron_right, color: Recursos().colorPrimario),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PedidosHistory()));
      },
    );
  }

  Widget _direcciones(BuildContext context) {
    return ListTile(
      title: Container(
        child: Text(
          'Administra tus direcciones',
          style: TextStyle(
            color: Recursos().colorPrimario,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      leading: Icon(Icons.gps_fixed, color: Recursos().colorPrimario),
      trailing: Icon(Icons.chevron_right, color: Recursos().colorPrimario),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdministrarUbicacion()));
      },
    );
  }

  Widget _btnSalir(BuildContext context) {
    return ListTile(
        title: Container(
          child: Text(
            'Cerrar Sesion',
            style: TextStyle(
              color: Recursos().colorPrimario,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: Icon(Icons.exit_to_app, color: Colors.red),
        trailing: Icon(Icons.chevron_right, color: Recursos().colorPrimario),
        onTap: () {
          Recursos().showMessageConfirmar(context, () {
            _cerrarSesion(context);
            _pedidosController.cancelarOrden();
          }, 'Salir', '¿Seguro desea cerrar sesion?');
        });
  }

  void _cerrarSesion(BuildContext context) {
    storage.emailStorage =
        ''; // Eliminar el email del storage para que salga de la app
    storage.nombreStorage =
        ''; // Eliminar el nombre del storage para que salga de la app
    storage.idClienteStorage =
        ''; // Eliminar el nombre del storage para que salga de la app
    Navigator.of(context).pushReplacementNamed('registro');
  }

  String _iniciales() {
    List<String> separados = storage.nombreStorage.split(' ');
    return separados[0].substring(0, 1) + separados[1].substring(0, 1);
  }

  void _login() {
    return;
  }
}
