
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

  // GET y SET Email del Cliente
  String get emailStorage {
    return _storage.getString('email') ?? '';
  }

  set emailStorage( String email ) {
    _storage.setString('email', email);
  }

}


