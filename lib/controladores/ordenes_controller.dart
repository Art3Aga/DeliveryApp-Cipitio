
import 'dart:async';

import 'package:deliveryapplicacion/servicios/db_sqlite_service.dart';


class OrdenesController {


  //Patron Singleton
  static final OrdenesController _singleton = new OrdenesController._private();

  factory OrdenesController() {
    return _singleton;
  }

  OrdenesController._private() {
    getOrdenes();
  }


  //Propiedades
  final _ordenesController = StreamController<List<Orden>>.broadcast();
  final _totalController = StreamController<double>.broadcast();

  Stream<List<Orden>> get ordenesStream => _ordenesController.stream;
  Stream<double> get totalStream => _totalController.stream;


  getOrdenes() async {
    _ordenesController.sink.add(await DBSQliteService.db.getOrdenes());
    getTotalPrecio();
  }

  addOrden(Orden orden) async {
    await DBSQliteService.db.addOrden(orden);
    getOrdenes();
  }

  updateOrden(Orden orden) async {
    await DBSQliteService.db.updateOrden(orden);
    getOrdenes();
  }

  deleteOrden(String idOrden) async {
    await DBSQliteService.db.deleteOrden(idOrden);
    getOrdenes();
  }

  cancelarOrden() async {
    await DBSQliteService.db.deleteOrdenes();
    getOrdenes();
  }

  getTotalPrecio() async {
    _totalController.sink.add(await DBSQliteService.db.totalPrecioOrden());
  }




  dispose() {
    _ordenesController?.close();
    _totalController?.close();
  }



}