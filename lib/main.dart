import 'package:deliveryapplicacion/vistas/tabs_page.dart';
import 'package:deliveryapplicacion/vistas/login_page.dart';
import 'package:deliveryapplicacion/vistas/perfil_page.dart';

import 'package:deliveryapplicacion/vistas/menu_detalle_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery El Cipitio',
      initialRoute: 'home',
      routes: {
        'home': (context) => TabsPage(),
        'login': (context) => LoginPage(),
        'menu_detalle': (context) => MenuDetalle(),
        'registro': (contexlt) => PerfilPage(),
      },
    );
  }
}
