import 'package:deliveryapplicacion/vistas/home_page.dart';
import 'package:deliveryapplicacion/vistas/login_page.dart';
import 'package:deliveryapplicacion/vistas/menu_detalle_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery El Cipitio',
      initialRoute: 'login',
      routes: {
        'home': (context) => HomePage(),
        'login': (context) => LoginPage(),
        'menu_detalle': (context) => MenuDetalle(),
      },
    );
  }
}