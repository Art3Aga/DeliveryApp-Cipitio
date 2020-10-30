
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/servicios/shared_preferences.dart';
import 'package:deliveryapplicacion/vistas/login_page.dart';
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
      theme: ThemeData(
        primaryColor: Recursos().colorPrimario
      ),
      debugShowCheckedModeBanner: false,
      title: 'Delivery El Cipitio',
      initialRoute:  'home', //storage.emailStorage == '' ? 'registro' : 'home',
      routes: {
        'home': (context) => TabsPage(),
        'registro': (context) => RegistroPage(),
        'login': (context) => LoginPage(),
        'menu_detalle': (context) => MenuDetalle(),
        'perfil': (context) => PerfilPage(),
      },
    );
  }
}
