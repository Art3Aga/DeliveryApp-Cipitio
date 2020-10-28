import 'dart:ui';
import 'dart:math';

import 'package:deliveryapplicacion/modelos/promo_model.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/widgets/grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PromocionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _title(),
                _proms(),
              ],
            ),
          )
        ],
      ),
    );
  }

  /*Widget _background() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          
        )
      ),
    );


    final cajaRosa = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        height: 360.0,
        width: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(236, 98, 188, 1.0),
              Color.fromRGBO(241, 142, 172, 1.0)
            ]
          )
        ),
      )
    );
    
    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -100.0,
          child: cajaRosa
        )
      ],
    );


  }*/
  Widget _proms() {
    final List<Promocion> proms = [
      Promocion(
          idPromo: 0,
          nombrePromo: 'pan 1',
          precio: 4.99,
          imagen:
              'https://www.recetassalvador.com/base/stock/Recipe/38-image/38-image_web.jpg'),
      Promocion(
          idPromo: 0,
          nombrePromo: 'pan 2',
          precio: 4.99,
          imagen:
              'https://www.recetassalvador.com/base/stock/Recipe/38-image/38-image_web.jpg'),
      Promocion(
          idPromo: 0,
          nombrePromo: 'pan 3',
          precio: 4.99,
          imagen:
              'https://www.recetassalvador.com/base/stock/Recipe/38-image/38-image_web.jpg'),
      Promocion(
          idPromo: 0,
          nombrePromo: 'pan 4',
          precio: 4.99,
          imagen:
              'https://www.recetassalvador.com/base/stock/Recipe/38-image/38-image_web.jpg'),
      Promocion(
          idPromo: 0,
          nombrePromo: 'pan 5',
          precio: 4.99,
          imagen:
              'https://www.recetassalvador.com/base/stock/Recipe/38-image/38-image_web.jpg'),
      Promocion(
          idPromo: 0,
          nombrePromo: 'pan 6',
          precio: 4.99,
          imagen:
              'https://www.recetassalvador.com/base/stock/Recipe/38-image/38-image_web.jpg'),
      Promocion(
          idPromo: 0,
          nombrePromo: 'pan 7',
          precio: 4.99,
          imagen:
              'https://www.recetassalvador.com/base/stock/Recipe/38-image/38-image_web.jpg'),
    ];
    return Grid(
      promos: proms,
      columns: 3,
    );
  }

  Widget _title() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Promociones',
                style: TextStyle(
                    color: Recursos().colorTerciario,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text('Haz tu pedido ya',
                style: TextStyle(
                    color: Recursos().colorTerciario, fontSize: 14.0)),
          ],
        ),
      ),
    );
  }

  Widget _promos() {
    return Table(
      children: [
        TableRow(children: [
          _prom(
              image:
                  'https://www.elsaborcontinental.com/wp-content/uploads/sites/48/2020/04/xPanes_Con_Pollo.png,qx66984.pagespeed.ic.yXNEyT85CM.jpg',
              promoTitle: 'Promo 1'),
          _prom(
              image:
                  'https://www.recetassalvador.com/base/stock/Recipe/38-image/38-image_web.jpg',
              promoTitle: 'Promo 1'),
          _prom(
              image:
                  'https://www.elsaborcontinental.com/wp-content/uploads/sites/48/2020/04/xPanes_Con_Pollo.png,qx66984.pagespeed.ic.yXNEyT85CM.jpg',
              promoTitle: 'Promo 1'),
        ]),
        TableRow(children: [
          _prom(
              image:
                  'https://www.recetassalvador.com/base/stock/Recipe/38-image/38-image_web.jpg',
              promoTitle: 'Promo 1'),
          _prom(
              image:
                  'https://www.elsaborcontinental.com/wp-content/uploads/sites/48/2020/04/xPanes_Con_Pollo.png,qx66984.pagespeed.ic.yXNEyT85CM.jpg',
              promoTitle: 'Promo 1'),
          _prom(
              image:
                  'https://www.elsaborcontinental.com/wp-content/uploads/sites/48/2020/04/xPanes_Con_Pollo.png,qx66984.pagespeed.ic.yXNEyT85CM.jpg',
              promoTitle: 'Promo 1'),
        ]),
        TableRow(children: [
          _prom(
              image:
                  'https://www.recetassalvador.com/base/stock/Recipe/38-image/38-image_web.jpg',
              promoTitle: 'Promo 1'),
          _prom(
              image:
                  'https://www.elsaborcontinental.com/wp-content/uploads/sites/48/2020/04/xPanes_Con_Pollo.png,qx66984.pagespeed.ic.yXNEyT85CM.jpg',
              promoTitle: 'Promo 1'),
          _prom(
              image:
                  'https://www.196flavors.com/wp-content/uploads/2018/12/panes-con-pavo-1-FP.jpg',
              promoTitle: 'Promo 1'),
        ])
      ],
    );
  }

  Widget _prom({String image, String promoTitle}) {
    final card = Container(
      child: Column(
        children: [
          FadeInImage(
            height: 80.0,
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(image),
            fit: BoxFit.fill,
          ),
          Container(
              padding: EdgeInsets.all(25.0),
              child: Text(
                promoTitle,
                style: TextStyle(
                  color: Recursos().colorPrimario,
                ),
              ))
        ],
      ),
    );
    return Container(
      height: 150.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Recursos().colorTerciario,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2.0, 10.0))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: card,
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
          primaryColor: Colors.pinkAccent,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0)))),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today, size: 30.0), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 30.0), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle, size: 30.0),
              title: Container()),
        ],
      ),
    );
  }
  /*Widget _promo({String image, String promoTitle}) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
        child: Container(
          height: 180.0,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Recursos().colorTerciario,
              borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.0,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FadeInImage(
                      image: NetworkImage(image),
                      placeholder: AssetImage('assets/loading.gif'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(0.0),
                child: Text(promoTitle),
              )
            ],
          ),
        ),
      ),
    );
  }*/
}
