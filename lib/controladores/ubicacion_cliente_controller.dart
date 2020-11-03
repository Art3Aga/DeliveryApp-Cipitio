


import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class UbicacionClienteController {


  //Patron Singleton
  static final UbicacionClienteController _singleton = new UbicacionClienteController._private();

  factory UbicacionClienteController() {
    return _singleton;
  }

  UbicacionClienteController._private() {
    startSeguimiento();
  }


  //Propiedades
  final _ubicacionController = new StreamController<LatLng>.broadcast();
  final _direccionController = new StreamController<String>.broadcast();
  final _referenciaController = new StreamController<String>.broadcast();
  bool confirmoDireccion = false;


  Stream<LatLng> get ubicacionStream => _ubicacionController.stream;
  Stream<String> get direccionStream => _direccionController.stream;
  Stream<String> get referenciaStream => _referenciaController.stream;

  startSeguimiento() async {

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    final ubicacion = LatLng(position.latitude, position.longitude);

    _ubicacionController.sink.add(ubicacion);
  }

  addDireccion(String direccion) {
    _direccionController.sink.add(direccion);
    confirmoDireccion = true;
  }

  addReferencia(String referencia) {
    _referenciaController.sink.add(referencia);
  }

  dispose() {
    _ubicacionController?.close();
    _direccionController?.close();
    _referenciaController?.close();
  }

}