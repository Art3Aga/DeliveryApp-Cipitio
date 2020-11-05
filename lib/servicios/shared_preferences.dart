
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

}


