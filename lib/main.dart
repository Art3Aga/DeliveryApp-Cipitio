import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/servicios/shared_preferences.dart';
import 'package:deliveryapplicacion/vistas/acceso_gps_page.dart';
import 'package:deliveryapplicacion/vistas/edit_dir_page.dart';
import 'package:deliveryapplicacion/vistas/loading_page.dart';
import 'package:deliveryapplicacion/vistas/login_page.dart';
import 'package:deliveryapplicacion/vistas/mapa_add_direccion_page.dart';
import 'package:deliveryapplicacion/vistas/promociones_detalle_page.dart';
import 'package:deliveryapplicacion/vistas/tabs_page.dart';
import 'package:deliveryapplicacion/vistas/registro_page.dart';
import 'package:deliveryapplicacion/vistas/perfil_page.dart';

import 'package:deliveryapplicacion/vistas/menu_detalle_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = new StorageCliente();
  await storage.initStorage();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storage = new StorageCliente();

    return MaterialApp(
      theme: ThemeData(primaryColor: Recursos().colorPrimario),
      debugShowCheckedModeBanner: false,
      title: 'Delivery Cipitio',
      initialRoute: storage.emailStorage == '' ? 'registro' : 'loading',
      routes: {
        'home': (context) => TabsPage(),
        'registro': (context) => RegistroPage(),
        'login': (context) => LoginPage(),
        'menu_detalle': (context) => MenuDetalle(),
        'perfil': (context) => PerfilPage(),
        'acceso_gps': (context) => AccessoGpsPage(),
        'promocion_detalle': (context) => PromocionesDetalle(),
        'loading': (context) => LoadingPage(),
        'administrar_direccion': (context) => AdministrarUbicacion(),
      },
    );
  }
}
