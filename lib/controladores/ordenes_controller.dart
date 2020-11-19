
import 'dart:async';

import 'package:deliveryapplicacion/servicios/crud_service.dart';
import 'package:deliveryapplicacion/servicios/db_sqlite_service.dart';


class OrdenesController {


  //Patron Singleton
  static final OrdenesController _singleton = new OrdenesController._private();

  factory OrdenesController() {
    return _singleton;
  }

  OrdenesController._private() {
    getPedidos();
  }


  //Propiedades
  final _pedidosController = StreamController<List<Pedido>>.broadcast();
  final _totalController = StreamController<double>.broadcast();
  final _crud = new Crud();

  List<Pedido> pedidos = new List();
  double total = 0;

  Stream<List<Pedido>> get pedidosStream => _pedidosController.stream;
  Stream<double> get totalStream => _totalController.stream;


  getPedidos() async {
    pedidos = await DBSQliteService.db.getPedidos();
    _pedidosController.sink.add(await DBSQliteService.db.getPedidos());
    getTotalPrecio();
  }

  addMenuToOrden(Menu menu) async {
    await DBSQliteService.db.addMenuToOrden(menu);
    getPedidos();
  }

  updatePedido(Pedido orden) async {
    await DBSQliteService.db.updatePedido(orden);
    getPedidos();
  }

  deletePedido(String idOrden) async {
    await DBSQliteService.db.deletePedido(idOrden);
    getPedidos();
  }

  cancelarOrden() async {
    await DBSQliteService.db.deletePedidos();
    getPedidos();
  }

  getTotalPrecio() async {
    _totalController.sink.add(await DBSQliteService.db.totalPrecioPedido());
    total = await DBSQliteService.db.totalPrecioPedido();
  }

  Future<dynamic> nuevaOrden(Orden orden) async {

    final data = await this._crud.nuevaOrden(orden);

    if(!data['ok']) {
      return data['data'];
    }

    Orden ordenTemp = Orden.fromJson(data['orden']);

    return ordenTemp;

  }

  Future<dynamic> nuevoPedido(Pedido pedido, String idOrden) async {

    final data = await this._crud.nuevoPedido(pedido, idOrden);

    if(!data['ok']) {
      return data['data'];
    }

    Pedido pedidoTemp = Pedido.fromJson(data['pedido']);

    return pedidoTemp;

  }




  dispose() {
    _pedidosController?.close();
    _totalController?.close();
  }



}