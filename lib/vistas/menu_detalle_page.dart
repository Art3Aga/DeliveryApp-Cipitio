import 'dart:ui';

import 'package:deliveryapplicacion/modelos/menu_model.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class MenuDetalle extends StatelessWidget {

  //Menu menu;

  //MenuDetalle({@required menu});


  @override
  Widget build(BuildContext context) {

    final Menu menu = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar(menu, size),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: size.height * 0.01),
                _imagenMenu(menu, size),
              ]
            ),
          )
        ],
      ),
      floatingActionButton: _btnAddOrden(menu, context),
    );
  }

  Widget _crearAppBar(Menu menu, Size size) {
    return SliverAppBar(
      elevation: 2,
      backgroundColor: Recursos().colorTerciario,
      expandedHeight: size.height * 0.35,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Stack(
            fit: StackFit.expand,
            children: [
              FadeInImage(
                placeholder: AssetImage('assets/loading.gif'), 
                image: NetworkImage(menu.imagen),
                fadeInDuration: Duration(microseconds: 180),
                fit: BoxFit.cover
              ),
              Container(
                color: Colors.black38,
                width: double.infinity,
              ),
            ],
          )
        ),
    );
  }

  _imagenMenu(Menu menu, Size size) {    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.02),
      child: Row(
        children: [
          Hero(
            tag: new Text(menu.uniqueID),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(menu.imagen),
                height: size.height * 0.2,
                width: size.height * 0.15,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            child: Column()
          )
        ],
      ),
    );
  }


  Widget _btnAddOrden(Menu menu, BuildContext context) {
    return RaisedButton(
      onPressed: () => _addPedidoToOrden(context),
      child: Text('Agregar 1 a la Orden - \$${menu.precio}', style: TextStyle(color: Colors.white),),
      color: Recursos().colorTerciario,
    );
  }

  void _addPedidoToOrden(BuildContext context) {
    Recursos().showMessageSuccess(context, 'Agregado a la Orden!', () {
      Navigator.of(context).pop();
    });
  }
}