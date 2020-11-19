import 'package:deliveryapplicacion/modelos/cliente_model.dart';
import 'package:deliveryapplicacion/modelos/direccion_model.dart';
import 'package:deliveryapplicacion/modelos/ordenes_model.dart';
import 'package:deliveryapplicacion/modelos/pedido_model.dart';
export 'package:deliveryapplicacion/modelos/ordenes_model.dart';
import 'package:dio/dio.dart';

class Crud {
  final _dio = new Dio();
  final _url = 'https://cipitiobackend.herokuapp.com';
  final _urlLocal = 'http://192.168.43.180:3000';

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

  Future<dynamic> updateClave(
      String idCliente, String clave, String claveNueva) async {
    final url = '$_urlLocal/api/clientes/actualizar_contra';
    Map<String, dynamic> data = {
      'id_cliente': idCliente,
      'clave': clave,
      'clave_nueva': claveNueva
    };
    final response = await this._dio.post(url, data: data);

    return response.data;
  }

  Future<dynamic> updatePhone(String idCliente, String phone) async {
    final url = '$_urlLocal/api/clientes/actualizar_telefono';
    Map<String, dynamic> data = {'id_cliente': idCliente, 'telefono': phone};
    final response = await this._dio.post(url, data: data);

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

  Future<dynamic> nuevaOrden(Orden orden) async {
    final url = '$_url/api/orden_pedido/nueva_orden';

    Map<String, dynamic> ordenData = {
      'id_cliente': orden.idCliente,
      'total': orden.total
    };

    final response = await this._dio.post(url, data: ordenData);

    return response.data;
  }

  Future<dynamic> nuevoPedido(Pedido pedido, String idOrden) async {
    final url = '$_url/api/orden_pedido/nuevo_pedido';

    Map<String, dynamic> dataPedido = {
      'id_orden': idOrden,
      'id_cliente': pedido.idCliente,
      'id_menu_promo': pedido.idMenuPromo,
      'cantidad': pedido.cantidad,
      'subtotal': pedido.subtotal
    };

    final response = await this._dio.post(url, data: dataPedido);

    return response.data;
  }

  Future<dynamic> getMenus() async {
    final url = '$_url/api/menus/lista';

    final response = await this._dio.get(url);

    return response.data;
  }

  Future<dynamic> getPromos() async {
    final url = '$_urlLocal/api/promos/lista';

    try {
      final response = await this._dio.get(url);

      return response.data;
    } catch (e) {
      return e.toString();
    }
  }
}
