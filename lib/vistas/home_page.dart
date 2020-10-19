
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/vistas/menus_page.dart';
import 'package:deliveryapplicacion/vistas/perfil_page.dart';
import 'package:deliveryapplicacion/vistas/promociones_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  List<Widget> _menuPaginas = <Widget>[
    MenusPage(),
    PromocionesPage(),
    Container(),
    PerfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Recursos().colorTerciario,), onPressed: (){},
          )
        ],
      ),*/
      body: Center(
        child: _menuPaginas.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Recursos().colorTerciario,
                tabs: [
                  GButton(
                    icon: Icons.restaurant_menu,
                    text: 'Menus',
                  ),
                  GButton(
                    icon: Icons.fastfood,
                    text: 'Promociones',
                  ),
                  GButton(
                    icon: Icons.menu,
                    text: 'Ordenes',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Perfil',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}