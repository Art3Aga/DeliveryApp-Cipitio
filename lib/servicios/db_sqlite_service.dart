

import 'dart:io';
import 'package:deliveryapplicacion/modelos/orden_model.dart';
export 'package:deliveryapplicacion/modelos/orden_model.dart';
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
    String path = join(documentsDirectory.path, 'OrdenesDB.db');

    

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onConfigure: _onConfigure,
      onCreate: (Database db, int version) async {
        await _onConfigure(db);
        await db.execute(
          'CREATE TABLE Ordenes ('
          ' id_orden INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,' 
          ' id_menu INTEGER,' 
          ' nombre TEXT,' 
          ' descripcion TEXT,' 
          ' precio REAL,'
          ' imagen TEXT,' 
          ' cantidad INTEGER,' 
          ' precio_orden REAL '
          ')'
        );
      }
    );
  }


  //////////////////////   CRUD   ////////////////////////////////////

  //CREATE
  Future<int> addOrden(Orden orden) async {
    final db = await database;
    final response = await db.insert('Ordenes', orden.toJson());
    return response;
  }

  //READ
  Future<List<Orden>> getOrdenes() async {
    final db = await database;
    final response = await db.rawQuery("SELECT * FROM Ordenes");
    List<Orden> ordenes = response.isNotEmpty 
                                ? response.map((orden) => Orden.fromJson(orden)).toList() : [];
    return ordenes;
  }

  Future<int> cantidadOrdenes(int idOrden) async {
    final db = await database;
    final response = await db.rawQuery('SELECT COUNT(*) AS ordenes FROM Ordenes WHERE id_orden = $idOrden');
    int cantidadOrdenes = Sqflite.firstIntValue(response);
    return cantidadOrdenes;
  }

  Future<double> totalPrecioOrden() async {
    final db = await database;
    final response = await db.rawQuery('SELECT SUM(precio_orden) AS total FROM Ordenes');
    double total = response.isNotEmpty ? response[0]['total'] : 0.0;
    return total;
  }

  //UPDATE
  Future<int> updateOrden(Orden orden) async {
    final db = await database;
    final response = await db.update('Ordenes', orden.toJson(), where: 'id_orden = ?', whereArgs: [orden.idOrden]);
    return response;
  }

  //DELETE
  Future<int> deleteOrden(int idOrden) async {
    final db = await database;
    final response = await db.rawDelete('DELETE FROM Ordenes WHERE id_orden = $idOrden');
    return response;
  }

  Future<int> deleteOrdenes() async {
    final db = await database;
    final response = await db.rawDelete('DELETE FROM Ordenes');
    return response;
  }

}