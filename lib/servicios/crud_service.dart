
import 'package:deliveryapplicacion/modelos/cliente_model.dart';
import 'package:deliveryapplicacion/modelos/direccion_model.dart';
import 'package:dio/dio.dart';

class Crud {

  final _dio = new Dio();
  final _url = 'https://cipitiobackend.herokuapp.com';



  Future<dynamic> registro(Cliente cliente) async {

    final url = '$_url/api/clientes/nuevo_cliente';

    Map<String, String> dataClient = {
      'nombre': cliente.nombre,
      'telefono': cliente.telefono,
      'email': cliente.email,
      'clave': cliente.clave
    };

    final response = await this._dio.post(url, data: dataClient);

    return response.data;

  }


  Future<dynamic> login(Cliente cliente) async {

    final url = '$_url/api/clientes/login_cliente';

    final response = await this._dio.post(url, data: cliente.toJson());
    
    return response.data;

  }

  Future<dynamic> registroDireccion(DireccionCliente direccion) async {

    final url = '$_url/api/clientes/nueva_direccion';

    final response = await this._dio.post(url, data: direccion.toJson());
    
    return response.data;

  }

  Future<dynamic> direccionesByCliente(String idCliente) async {

    final url = '$_url/api/clientes/direcciones/$idCliente';

    final response = await this._dio.get(url);
    
    return response.data;

  }


}