
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

  Stream<List<Orden>> get ordenesStream => _ordenesController.stream;


  getOrdenes() async {
    _ordenesController.sink.add(await DBSQliteService.db.getOrdenes());
  }

  addOrden(Orden orden) async {
    await DBSQliteService.db.addOrden(orden);
    getOrdenes();
  }

  updateOrden(Orden orden) async {
    await DBSQliteService.db.updateOrden(orden);
    getOrdenes();
  }

  deleteOrden(int idOrden) async {
    await DBSQliteService.db.deleteOrden(idOrden);
    getOrdenes();
  }




  dispose() {
    _ordenesController?.close();
  }



}