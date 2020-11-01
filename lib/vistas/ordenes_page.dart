

import 'package:deliveryapplicacion/controladores/ordenes_controller.dart';
import 'package:deliveryapplicacion/modelos/menu_model.dart';
import 'package:deliveryapplicacion/modelos/orden_model.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdenesPage extends StatelessWidget {


  final bool activarAppBar;

  OrdenesPage({@required this.activarAppBar});

  final _ordenesController = new OrdenesController();


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    _ordenesController.getOrdenes();

    return Scaffold(
      appBar: activarAppBar ? AppBar() : null,
      body: ListView(
        children: [
          _title(),
          _body(size, context)
        ],
      )
    );
  }

  _body(Size size, BuildContext context) {
    return Container(
      child: StreamBuilder<List<Orden>>(
        stream: _ordenesController.ordenesStream,
        builder: (BuildContext context, AsyncSnapshot<List<Orden>> snapshot){

          if(snapshot.hasData) {
            List<Orden> ordenes = snapshot.data;
            return ordenes.length > 0 ? ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, i) => _itemOrden(ordenes[i], size, context), 
              separatorBuilder: (_, i) => Divider(), 
              itemCount: ordenes.length
            ) : Container(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('No tienes Ordenes en este Momento!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            );
          }
          else {
            return Center(child: CupertinoActivityIndicator(radius: 25));
          }

        },
      ),
    );
  }

  _itemOrden(Orden orden, Size size, BuildContext context) {

    final styleTitle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
    );

    final styleCantidad = TextStyle(
      color: Colors.white,
      fontSize: 14
    );
    
    final styleSubTitle = TextStyle(
      fontSize: 16,
      fontStyle: FontStyle.italic
    );

    return ListTile(
      leading: Container(
        padding: EdgeInsets.only(right: size.width * 0.05),
        decoration: BoxDecoration(
        border: Border(
            right: BorderSide(width: 0.0, color: Colors.black)
          ),
        ),
        child: CircleAvatar(
          radius: size.height * 0.033,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(orden.imagen),
          foregroundColor: Colors.white,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(orden.nombre, style: styleTitle),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(5),
              color: Recursos().colorPrimario,
              child: Text('${orden.cantidad}x', style: styleCantidad),
            ),
          ),
        ],
      ),
      subtitle: Text('\$${orden.precioOrden}', style: styleSubTitle),
      trailing: _popupOpcionesOrden(size, orden),
      onTap: (){
        Menu menu = new Menu(
          idMenu: orden.idMenu,
          nombre: orden.nombre,
          descripcion: orden.descripcion,
          imagen: orden.imagen,
          precio: orden.precio
        );
        Navigator.of(context).pushNamed('menu_detalle', arguments: menu);
      },
    );
  }

  Widget _title() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Resumen de tu Orden',
                style: TextStyle(
                  color: Recursos().colorTerciario,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 10.0),
            Text('El Cipitio',
                style: TextStyle(
                    color: Recursos().colorTerciario, fontSize: 14.0)),
          ],
        ),
      ),
    );
  }


  Widget _popupOpcionesOrden(Size size, Orden orden) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      tooltip: 'Opciones',
      itemBuilder: (context) => [
        PopupMenuItem(
          child: FlatButton(
            onPressed: (){
              Navigator.of(context).pop();
              _ordenesController.deleteOrden(orden.idOrden);
            },
            child: Row(children: <Widget>[Text('Eliminar de la Orden'), SizedBox(width: size.width * 0.01), Icon(Icons.delete, color: Colors.red)])
          ),
        ),
      ]
    );
  }


}