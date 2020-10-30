
import 'package:deliveryapplicacion/modelos/cliente_model.dart';
import 'package:dio/dio.dart';

class Crud {

  final _dio = new Dio();
  final _url = 'http://192.168.1.7:3000';



  Future<dynamic> registro(Cliente cliente) async {

    final url = '$_url/api/clientes/nuevo_cliente';

    final response = await this._dio.post(url, data: cliente.toJson());

    return response.data;

  }


  Future<dynamic> login(Cliente cliente) async {

    final url = '$_url/api/clientes/login_cliente';

    final response = await this._dio.post(url, data: cliente.toJson());
    
    return response.data;

  }


}