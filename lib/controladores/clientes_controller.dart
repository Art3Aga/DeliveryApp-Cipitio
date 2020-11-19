import 'dart:async';

import 'package:deliveryapplicacion/modelos/cliente_model.dart';
import 'package:deliveryapplicacion/modelos/direccion_model.dart';
export 'package:deliveryapplicacion/modelos/cliente_model.dart';
export 'package:deliveryapplicacion/modelos/direccion_model.dart';
import 'package:deliveryapplicacion/servicios/crud_service.dart';

class ClientesController {
  //Propiedades
  final _crud = new Crud();
  final _direccionesController =
      new StreamController<List<DireccionCliente>>.broadcast();
  Stream<List<DireccionCliente>> get direccionesStream =>
      _direccionesController.stream;

  Future<dynamic> registro(Cliente cliente) async {
    final data = await this._crud.registro(cliente);

    if (!data['ok']) {
      return data['data'];
    }

    Cliente clienteTemp = Cliente.fromJson(data['cliente']);

    return clienteTemp;
  }

  Future<dynamic> login(Cliente cliente) async {
    final data = await this._crud.login(cliente);

    if (!data['ok']) {
      return data['data'];
    }

    Cliente clienteTemp = Cliente.fromJson(data['cliente']);

    return clienteTemp;
  }

  Future<dynamic> updateClave(
      String idCliente, String clave, String claveNueva) async {
    final data = await this._crud.updateClave(idCliente, clave, claveNueva);

    if (!data['ok']) {
      return data['data'];
    }

    Cliente clienteTemp = Cliente.fromJson(data['client']);

    return clienteTemp;
  }

  Future<dynamic> updatePhone(String idCliente, String phone) async {
    final data = await this._crud.updatePhone(idCliente, phone);

    if (!data['ok']) {
      return data['data'];
    }

    Cliente clienteTemp = Cliente.fromJson(data['cliente']);

    return clienteTemp;
  }

  Future<dynamic> registroDireccion(DireccionCliente direccion) async {
    final data = await this._crud.registroDireccion(direccion);

    if (!data['ok']) {
      return data['data'];
    }

    DireccionCliente direccionTemp =
        DireccionCliente.fromJson(data['direccion']);

    return direccionTemp;
  }

  Future<List<DireccionCliente>> direccionesByCliente(String idCliente) async {
    final data = await this._crud.direccionesByCliente(idCliente);

    final direcciones = new Direcciones.fromJsonList(data['direcciones']);

    _direccionesController.sink.add(direcciones.items);

    return direcciones.items;
  }

  dispose() {
    _direccionesController?.close();
  }
}
