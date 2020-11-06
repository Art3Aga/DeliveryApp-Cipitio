import 'package:deliveryapplicacion/controladores/clientes_controller.dart';
import 'package:deliveryapplicacion/modelos/direccion_model.dart';
import 'package:deliveryapplicacion/servicios/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/vistas/mapa_add_direccion_page.dart';

// ignore: must_be_immutable
class ProcesarOrden extends StatelessWidget {
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordConfirmarController =
      new TextEditingController();
  final _clientesController = new ClientesController();
  final _storage = new StorageCliente();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Detalle De La Orden')),
      body: Container(
        margin: EdgeInsets.only(top: size.width * 0.05),
        child: ListView(
          children: [
            _title2(size),
            _title(size),
            SizedBox(height: size.height * 0.4),
            _subtotal(size),
            SizedBox(height: size.height * 0.02),
            _total(size)
          ],
        ),
      ),
      floatingActionButton: _botonAgregar(context),
    );
  }

  Widget _title(Size size) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Direccion de Envío',
                style: TextStyle(
                    color: Recursos().colorTerciario,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.02),
            Text('Colonia El Tesoro Av Venezuela #007',
                style: TextStyle(
                    color: Recursos().colorTerciario, fontSize: 16.0)),
          ],
        ),
      ),
    );
  }

  Widget _subtotal(Size size) {
    return Container(
      margin:
          EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _subtotal_text(),
          _subtotal_efectivo(),
        ],
      ),
    );
  }

  Widget _total(Size size) {
    return Container(
      margin:
          EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _total_text(),
          _total_efectivo(),
        ],
      ),
    );
  }

  Widget _title2(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: size.height * 0.02),
        _icono(size),
        SizedBox(width: size.height * 0.02),
        Column(
          children: [
            SizedBox(height: size.height * 0.02),
            _saludo(),
            SizedBox(height: size.height * 0.02),
            _saludo2(),
            //_body(size)
          ],
        ),
      ],
    );
  }

  Widget _botonAgregar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MapaAddDireccion(
                      registrarDireccionEnDB: true, direccionActiva: false)));
        },
        label: Text("Rastrear Orden"),
        icon: Icon(Icons.gps_fixed),
        backgroundColor: Recursos().colorPrimario,
      ),
    );
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
        radius: size.width * 0.1,
        backgroundColor: Recursos().colorTerciario,
        child: Text("RP"),
      ),
    );
  }

  Widget _saludo() {
    final style = TextStyle(fontSize: 25.0, color: Recursos().colorPrimario);
    return Text('Repartidor Encargado', style: style);
  }

  Widget _saludo2() {
    final style = TextStyle(fontSize: 18.0, color: Recursos().colorPrimario);
    return Text('David Alvarado Ramos', style: style);
  }

  Widget _subtotal_text() {
    final style = TextStyle(fontSize: 18.0, color: Recursos().colorPrimario);
    return Text('SubTotal', style: style);
  }

  Widget _subtotal_efectivo() {
    final style = TextStyle(fontSize: 18.0, color: Recursos().colorPrimario);
    return Text('4.44', style: style);
  }

  Widget _total_text() {
    final style = TextStyle(
        fontSize: 18.0,
        color: Recursos().colorPrimario,
        fontWeight: FontWeight.bold);
    return Text('Total', style: style);
  }

  Widget _total_efectivo() {
    final style = TextStyle(fontSize: 18.0, color: Recursos().colorPrimario);
    return Text('4.44', style: style);
  }
}
