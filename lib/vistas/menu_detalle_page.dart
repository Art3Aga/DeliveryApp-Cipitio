import 'dart:ui';

import 'package:deliveryapplicacion/modelos/menu_model.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MenuDetalle extends StatefulWidget {

  @override
  _MenuDetalleState createState() => _MenuDetalleState();
}

class _MenuDetalleState extends State<MenuDetalle> {

  TextEditingController _notaController = new TextEditingController();
  int _cantidad = 1;

  @override
  Widget build(BuildContext context) {
    final Menu menu = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar(menu, size),
          SliverList(
            delegate: SliverChildListDelegate([
              _imagenMenu(menu, size),
              _descripcionMenu(size, menu),
              _inputNota(size, context),
              _seleccionarCantidad(size, menu),
              SizedBox(height: size.height * 0.1)
              //_btnAddOrden(menu, context, size),
            ]),
          )
        ],
      ),
      floatingActionButton: _btnAddOrden(menu, context, size),
    );
  }

  Widget _cuadroTiempoEntrega(Size size) {

    final styleMinutos = TextStyle(
      color: Colors.white,
      fontSize: 20
    );

    final styleMin = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w200
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('30', style: styleMinutos),
                Text('Min', style: styleMin),
              ],
            ),
            width: 80,
            height: 60,
            color: Recursos().colorSecundario
          ),
        ),
      ],
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
            _cuadroTiempoEntrega(size)
          ],
        )
      ),
    );
  }

  _imagenMenu(Menu menu, Size size) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.02),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: NetworkImage(menu.imagen),
              height: size.height * 0.2,
              width: size.height * 0.15,
              fit: BoxFit.cover,
            ),
          ),
          _nombrePrecioMenu(size, menu)
        ],
      ),
    );
  }

  Widget _nombrePrecioMenu(Size size, Menu menu) {


    final styleNombreMenu = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w800
    );

    final stylePrecio = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
    );

    return Flexible(
      child: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(menu.nombre, style: styleNombreMenu),
            SizedBox(height: size.height * 0.05),
            Text('\$${menu.precio}', style: stylePrecio),
          ],
        ),
      )
    );
  }

  Widget _descripcionMenu(Size size, Menu menu) {


    final styleDescripcionMenu = TextStyle(
      fontSize: 16,
      color: Colors.black45
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.03),
      child: Text(menu.descripcion, style: styleDescripcionMenu),
    );
  }

  Widget _inputNota(Size size, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.05),
      child: Theme(
        data: Theme.of(context).copyWith(primaryColor: Recursos().colorPrimario),
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          controller: _notaController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Adicionar nota a este producto',
            suffixIcon: Icon(Icons.note_add),
          ),
        ),
      ),
    );
  }

  Widget _seleccionarCantidad(Size size, Menu menu) {

    final style = TextStyle(
      fontSize: 20
    );

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text('${this._cantidad}', style: style),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey)
            ),
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: size.height * 0.01),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Icon(Icons.add),
                onPressed: _addCantidadToOrden,
                elevation: 0,
                shape: Border.all(color: Colors.grey),
                color: Colors.transparent,
              ),
              SizedBox(width: size.width * 0.01),
              RaisedButton(
                child: Icon(Icons.minimize),
                onPressed: _removeCantidadToOrden,
                elevation: 0,
                shape: Border.all(color: Colors.grey),
                color: Colors.transparent,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _btnAddOrden(Menu menu, BuildContext context, Size size) {
    return Container(
      width: size.width,
      margin: EdgeInsets.only(left: size.width * 0.09),
      //margin: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.12),
      child: RaisedButton(
        onPressed: () => _addPedidoToOrden(context),
        child: Text(
          'Agregar ${this._cantidad} a la Orden - \$${menu.precio * this._cantidad}',
          style: TextStyle(color: Colors.white),
        ),
        color: Recursos().colorTerciario,
      ),
    );
  }

  void _addPedidoToOrden(BuildContext context) {
    Recursos().showMessageSuccess(context, 'Agregado a la Orden!', () {
      Navigator.of(context).pop();
    });
  }

  void _addCantidadToOrden() {
    this._cantidad ++;
    setState(() {
      
    });
  }

  void _removeCantidadToOrden() {
    if(this._cantidad > 1) {
      this._cantidad --;
    }
    setState(() {
      
    });
  }
}
