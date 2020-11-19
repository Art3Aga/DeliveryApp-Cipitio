

import 'dart:io';
import 'package:deliveryapplicacion/modelos/menu_model.dart';
export 'package:deliveryapplicacion/modelos/menu_model.dart';
import 'package:deliveryapplicacion/modelos/pedido_model.dart';
import 'package:deliveryapplicacion/modelos/promo_model.dart';
export 'package:deliveryapplicacion/modelos/pedido_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBSQliteService {

  //Propiedades
  static Database _database;
  static final DBSQliteService db = DBSQliteService._private();

  DBSQliteService._private();

  Future<Database> get database async {
    
    if(_database != null) return _database;

    _database = await initDB();

    return _database;

  }
  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys=ON');
  }
  initDB() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'PedidosDB.db');

    return await openDatabase(
      path,
      version: 2,
      onOpen: (db) {},
      onConfigure: _onConfigure,
      onCreate: (Database db, int version) async {
        await _onConfigure(db);
        await db.execute(
          'CREATE TABLE Menus ('
          ' id_menu TEXT,' 
          ' nombre TEXT,' 
          ' precio REAL,' 
          ' descripcion TEXT,' 
          ' imagen TEXT,' 
          ' nota TEXT,' 
          ' cantidad INTEGER,' 
          ' subtotal REAL '
          ')'
        );

        await db.execute(
          'CREATE TABLE Promociones ('
          ' id_promocion TEXT,' 
          ' nombre TEXT,' 
          ' precio REAL,' 
          ' descripcion TEXT,' 
          ' imagen TEXT,' 
          ' nota TEXT,' 
          ' menus TEXT,' 
          ' descuento REAL,' 
          ' cantidad INTEGER,' 
          ' subtotal REAL '
          ')'
        );
      }
    );
  }


  //////////////////////   CRUD   ////////////////////////////////////

  //CREATE
  Future<int> addMenuToOrden(Menu menu) async {
    final db = await database;
    final response = await db.insert('Menus', menu.toJson());
    return response;
  }

  Future<int> addPromoToOrden(Promocion promo) async {
    final db = await database;
    final response = await db.insert('Promociones', promo.toJson());
    return response;
  }

  //READ
  Future<List<Pedido>> getPedidos() async {
    final db = await database;
    final response = await db.rawQuery("SELECT * FROM Pedidos");
    List<Pedido> pedidos = response.isNotEmpty 
                                ? response.map((pedido) => Pedido.fromJson(pedido)).toList() : [];
    return pedidos;
  }

  Future<int> cantidadPedidos(String idPedido) async {
    final db = await database;
    final response = await db.rawQuery('SELECT COUNT(*) AS pedidos FROM Pedidos WHERE id_pedido = $idPedido');
    int cantidadPedidos = Sqflite.firstIntValue(response);
    return cantidadPedidos;
  }

  Future<double> totalPrecioPedido() async {
    final db = await database;
    final response = await db.rawQuery('SELECT SUM(subtotal) AS total FROM Pedidos');
    double total = response.isNotEmpty ? response[0]['total'] : 0.0;
    return total;
  }

  //UPDATE
  Future<int> updatePedido(Pedido pedido) async {
    final db = await database;
    final response = await db.update('Pedidos', pedido.toJson(), where: 'id_pedido = ?', whereArgs: [pedido.idPedido]);
    return response;
  }

  //DELETE
  Future<int> deletePedido(String idPedido) async {
    final db = await database;
    final response = await db.rawDelete('DELETE FROM Pedidos WHERE id_pedido = $idPedido');
    return response;
  }

  Future<int> deletePedidos() async {
    final db = await database;
    final response = await db.rawDelete('DELETE FROM Pedidos');
    return response;
  }

}