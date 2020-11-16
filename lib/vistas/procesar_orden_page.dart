import 'package:deliveryapplicacion/controladores/clientes_controller.dart';
import 'package:deliveryapplicacion/modelos/ordenes_model.dart';
import 'package:deliveryapplicacion/modelos/usuario_model.dart';
import 'package:deliveryapplicacion/servicios/shared_preferences.dart';
import 'package:deliveryapplicacion/servicios/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/vistas/mapa_add_direccion_page.dart';

// ignore: must_be_immutable
class ProcesarOrden extends StatefulWidget {
  @override
  _ProcesarOrdenState createState() => _ProcesarOrdenState();
}

class _ProcesarOrdenState extends State<ProcesarOrden> {
  TextEditingController _passwordController = new TextEditingController();

  TextEditingController _passwordConfirmarController = new TextEditingController();

  final _clientesController = new ClientesController();

  final _socketService = new SocketService();

  final _storage = new StorageCliente();

  Orden orden;
  Usuario repartidor;
  bool cargando = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _socketService.connectar();
    _socketService.socket.on('repartidor-orden', _getRepartidorOrden);

    return Scaffold(
      appBar: AppBar(title: Text('Detalle De La Orden')),
      body: Container(
        margin: EdgeInsets.only(top: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title2(size),
            SizedBox(height: size.height * 0.05),
            _title(size),
            this.orden != null ? _datosOrden(size) : Container(),
          ],
        ),
      ),
      floatingActionButton: this.repartidor != null ? _botonAgregar(context) : Container(),
    );
  }

  Widget _datosOrden(Size size) {
    return ListView(
      shrinkWrap: true,
      children: [
        _itemDatoOrden('Orden ID:', this.orden.idOrden),
        _itemDatoOrden('Estado:', this.orden.estado),
        _itemDatoOrden('Fecha:', this.orden.fecha),
        _itemDatoOrden('Cliente:', _storage.nombreStorage),
        _listaPedidos(size),
        _itemDatoOrden('Total:', '\$${this.orden.total.toStringAsFixed(2)}'),
      ],
    );
  }

  Widget _itemDatoOrden(String leading, String trailing) {
    final styleLeading = TextStyle(fontSize: 18.0, color: Recursos().colorPrimario, fontWeight: FontWeight.bold);
    final styleTrailing = leading == 'Total:' ? TextStyle(fontSize: 22.0, color: Recursos().colorPrimario, fontWeight: FontWeight.bold) : TextStyle(fontSize: 14.0, color: Recursos().colorPrimario);
    return ListTile(
      leading: Text(leading, style: styleLeading),
      trailing: Text(trailing, style: styleTrailing),
    );
  }

  Widget _listaPedidos(Size size) {
    final styleLeading = TextStyle(fontSize: 18.0, color: Recursos().colorPrimario, fontWeight: FontWeight.bold);
    final stylePedidos = TextStyle(fontSize: 11.0, color: Recursos().colorPrimario);
    return ListTile(
      leading: Text('Pedidos', style: styleLeading),
      trailing: Wrap(
        children: [
          Text('Panes con Pollo 2x,', style: stylePedidos),
          Text('Panes con Pollo 2x,', style: stylePedidos),
          Text('Panes con Pollo 2x,', style: stylePedidos),
          Text('Panes con Pollo 2x,', style: stylePedidos),
          Text('Panes con Pollo 2x,', style: stylePedidos),
          Text('Panes con Pollo 2x,', style: stylePedidos),
          Text('Panes con Pollo 2x,', style: stylePedidos),
        ],
      )
    );
  }

  Widget _title(Size size) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Direccion de Envío', style: TextStyle(color: Recursos().colorTerciario, fontSize: 24.0, fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.02),
            Text(_storage.direccionStorage, style: TextStyle(color: Recursos().colorTerciario, fontSize: 16.0)),
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
          _subtotalText(),
          _subtotalTfectivo(),
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
          _totalText(),
          _totalEfectivo(),
        ],
      ),
    );
  }

  Widget _title2(Size size) {
    final styleTextProcesada = TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
    return this.repartidor != null ?  Row(
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
          ],
        )
      ],
    ) : Container(child: Center(child: Text('Su Orden está siendo procesada ...', style: styleTextProcesada,)));
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
        child: Text(_iniciales()),
      ),
    );
  }

  Widget _saludo() {
    final style = TextStyle(fontSize: 25.0, color: Recursos().colorPrimario);
    return Text('Repartidor Encargado', style: style);
  }

  Widget _saludo2() {
    final style = TextStyle(fontSize: 18.0, color: Recursos().colorPrimario);
    return Text(this.repartidor.nombre, style: style);
  }

  Widget _subtotalText() {
    final style = TextStyle(fontSize: 18.0, color: Recursos().colorPrimario);
    return Text('SubTotal', style: style);
  }

  Widget _subtotalTfectivo() {
    final style = TextStyle(fontSize: 18.0, color: Recursos().colorPrimario);
    return Text('4.44', style: style);
  }

  Widget _totalText() {
    final style = TextStyle(
        fontSize: 18.0,
        color: Recursos().colorPrimario,
        fontWeight: FontWeight.bold);
    return Text('Total', style: style);
  }

  Widget _totalEfectivo() {
    final style = TextStyle(fontSize: 18.0, color: Recursos().colorPrimario);
    return Text('\$${this.orden.total.toStringAsFixed(2)}', style: style);
  }

  dynamic _getRepartidorOrden(dynamic data) {
    setState(() {
      this.repartidor = Usuario.fromJson(data['repartidor']);
      this.orden = Orden.fromJson(data['orden']);
    });
    //data.id_cliente, data.orden (new Orden), data.repartidor (new Usuario)
  }

  String _iniciales() {
    List<String> separados = this.repartidor.nombre.split(' ');
    return separados[0].substring(0, 1) + separados[1].substring(0, 1);
  }
}
