
import 'package:shared_preferences/shared_preferences.dart';

class StorageCliente {

  static final StorageCliente _instancia = new StorageCliente._internal();

  factory StorageCliente() {
    return _instancia;
  }

  StorageCliente._internal();

  SharedPreferences _storage;

  initStorage() async {
    this._storage = await SharedPreferences.getInstance();
  }

  // ID Cliente
  String get idClienteStorage {
    return _storage.getString('id_cliente') ?? '';
  }
  
  set idClienteStorage( String idCliente ) {
    _storage.setString('id_cliente', idCliente);
  }

  //Telefono
  String get telefono {
    return _storage.getString('telefono') ?? '';
  }
   set telefono( String telefono ) {
    _storage.setString('telefono', telefono);
  }

  // Nombre Cliente
  String get nombreStorage {
    return _storage.getString('nombre') ?? '';
  }

  set nombreStorage( String nombre ) {
    _storage.setString('nombre', nombre);
  }

  // Email del Cliente
  String get emailStorage {
    return _storage.getString('email') ?? '';
  }

  set emailStorage( String email ) {
    _storage.setString('email', email);
  }

  // Direccion Actual del Cliente
  String get direccionStorage {
    return _storage.getString('direccion') ?? '';
  }

  set direccionStorage( String direccion ) {
    _storage.setString('direccion', direccion);
  }

  // Referencia Actual del Cliente
  String get referenciaStorage {
    return _storage.getString('referencia') ?? '';
  }

  set referenciaStorage( String referencia ) {
    _storage.setString('referencia', referencia);
  }

  // Coordenadas Actual del Cliente
  String get coordenadasStorage {
    return _storage.getString('coordenadas') ?? '';
  }

  set coordenadasStorage( String coordenadas ) {
    _storage.setString('coordenadas', coordenadas);
  }

}


