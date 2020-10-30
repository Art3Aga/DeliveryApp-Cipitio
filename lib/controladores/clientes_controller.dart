


import 'package:deliveryapplicacion/modelos/cliente_model.dart';
import 'package:deliveryapplicacion/servicios/crud_service.dart';

class ClientesController {
  


  final _crud = new Crud();


  Future<dynamic> registro(Cliente cliente) async {

    final data = await this._crud.registro(cliente);

    if(!data['ok']) {
      return data['data'];
    }

    Cliente clienteTemp = Cliente.fromJson(data['cliente']);

    return clienteTemp;

  }

  Future<dynamic> login(Cliente cliente) async {

    final data = await this._crud.login(cliente);

    if(!data['ok']) {
      return data['data'];
    }

    Cliente clienteTemp = Cliente.fromJson(data['cliente']);

    return clienteTemp;
  }


}