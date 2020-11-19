
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
  final _pedidosController = StreamController<List<Menu>>.broadcast();
  final _totalController = StreamController<double>.broadcast();
  final _crud = new Crud();

  List<Menu> menus = new List();
  double total = 0;
  double totalMenus = 0;
  double totalPromos = 0;

  Stream<List<Menu>> get pedidosStream => _pedidosController.stream;
  Stream<double> get totalStream => _totalController.stream;


  getPedidos() async {
    menus = await DBSQliteService.db.getMenus();
    _pedidosController.sink.add(await DBSQliteService.db.getMenus());
    getTotalPrecio();
  }

  addMenuToOrden(Menu menu) async {
    await DBSQliteService.db.addMenuToOrden(menu);
    getPedidos();
  }

  updatePedido(Menu menu) async {
    await DBSQliteService.db.updateMenuFromOrden(menu);
    getPedidos();
  }

  deletePedido(String idMenu) async {
    await DBSQliteService.db.deleteMenuFromOrden(idMenu);
    getPedidos();
  }

  cancelarOrden() async {
    await DBSQliteService.db.deletePedidos();
    getPedidos();
  }

  getTotalPrecio() async {
    _totalController.sink.add(await DBSQliteService.db.totalPrecioPedido());
    totalMenus = await DBSQliteService.db.totalPrecioPedido();
    totalPromos = await DBSQliteService.db.totalPrecioPedidoPromos();

    //total = totalMenus + totalPromos;
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