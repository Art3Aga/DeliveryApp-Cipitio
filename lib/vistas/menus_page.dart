

import 'package:deliveryapplicacion/buscadores/buscar_menus.dart';
import 'package:deliveryapplicacion/modelos/menu_model.dart';
import 'package:deliveryapplicacion/widgets/cards_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MenusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return <Widget>[
              _crearAppBar(size, context),
            ];
          },
          body: _body(size)
        ),
      );
  }


   Widget _crearAppBar(Size size, BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: size.height * 0.26,
      floating: true,
      pinned: true,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Container(
          color: Colors.red,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _imgBannerMenus(),
              _searchBar(size, context),
            ],
          ),
        ),
      ),
    );
  }


  Widget _imgBannerMenus() {
    return Image(
      image: AssetImage('assets/panes.jpg'),
      fit: BoxFit.cover,
    );
  }

  Widget _searchBar(Size size, BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: size.height * 0.025),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: size.height * 0.05,
            width: double.infinity,
            child: _inputSearchBar(size, context),
            decoration: BoxDecoration(
              color: Color.fromRGBO(220, 231, 227, 0.85),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0,5))
              ]
            ),
          ),
        ),
      )
    );
  }

  Widget _inputSearchBar(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: BuscarMenus());
      },
      child: Row(
        children: [
          SizedBox(width: size.width * 0.03),
          Icon(Icons.search, color: Colors.black54),
          SizedBox(width: size.width * 0.05),
          Text('Buscar Menu...', style: TextStyle(color: Colors.black54))
        ],
      ),
    );
  }

  Widget _body(Size size) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.04),
      child: Column(
        children: [
          _swiperTarjetas(size)
        ],
      ),
    );
  }

  Widget _swiperTarjetas(Size size) {
    final List<Menu> menus = [
      Menu(idMenu: 1, nombre: "Menu 1", descripcion: "Descripcion del Menu N° 1 Descripcion del Menu N° 1 Descripcion del Menu N° 1 Descripcion del Menu N° 1 Descripcion del Menu N° 1 Descripcion del Menu N° 1 Descripcion del Menu N° 1 Descripcion del Menu N° 1", precio: 1.99, imagen: "https://d1ralsognjng37.cloudfront.net/939dd856-2cbe-4226-9246-b790337190d9.jpeg"),
      Menu(idMenu: 2, nombre: "Menu 2", descripcion: "Descripcion del Menu N° 2", precio: 2.99, imagen: "https://scontent.fsal3-1.fna.fbcdn.net/v/t1.0-9/117826099_1164528353913227_4355133303312654781_o.jpg?_nc_cat=111&_nc_sid=8bfeb9&_nc_ohc=kcFhDkTyz8sAX8Z6jUw&_nc_ht=scontent.fsal3-1.fna&oh=6d021ab23c15a86f2c2f37f4f3717670&oe=5FB2709C"),
      Menu(idMenu: 3, nombre: "Menu 3", descripcion: "Descripcion del Menu N° 3", precio: 1.75, imagen: "https://scontent.fsal3-1.fna.fbcdn.net/v/t1.0-9/117523933_1161292397570156_5144117073103333712_n.jpg?_nc_cat=108&_nc_sid=8bfeb9&_nc_ohc=h1tM8pIaDf8AX9VfzI8&_nc_ht=scontent.fsal3-1.fna&oh=8fea1a9c664064d5835e1b532608107c&oe=5FB20B78"),
      Menu(idMenu: 4, nombre: "Menu 4", descripcion: "Descripcion del Menu N° 4", precio: 3.80, imagen: "https://scontent.fsal3-1.fna.fbcdn.net/v/t1.0-9/117170558_1156791931353536_4157687241622751385_n.jpg?_nc_cat=102&_nc_sid=8bfeb9&_nc_ohc=33qLZKM6vdUAX9O2ejr&_nc_ht=scontent.fsal3-1.fna&oh=62f5bf1abdc13a337d8e09936443f4d9&oe=5FB2F742"),
    ];
    return CardSwiper(
      menus: menus,
    );
  }
}