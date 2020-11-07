

import 'package:deliveryapplicacion/controladores/ordenes_controller.dart';
import 'package:deliveryapplicacion/modelos/menu_model.dart';
import 'package:deliveryapplicacion/modelos/pedido_model.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/modelos/ordenes_model.dart';
import 'package:deliveryapplicacion/servicios/shared_preferences.dart';
import 'package:deliveryapplicacion/servicios/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdenesPage extends StatelessWidget {


  final bool activarAppBar;

  OrdenesPage({@required this.activarAppBar});

  final _pedidosController = new OrdenesController();
  final _storage = new StorageCliente();
  final _socketService = new SocketService();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


    _pedidosController.getPedidos();

    return Scaffold(
      appBar: activarAppBar ? AppBar() : null,
      body: ListView(
        children: [
          _title(),
          _body(size, context),
          _subTotal(size),
          _btnCancelarOrden(context, size)
        ],
      ),
      floatingActionButton: _btnProcesarOrden(size),
    );
  }

  _body(Size size, BuildContext context) {
    return Container(
      child: StreamBuilder<List<Pedido>>(
        stream: _pedidosController.pedidosStream,
        builder: (BuildContext context, AsyncSnapshot<List<Pedido>> snapshot){

          if(snapshot.hasData) {
            List<Pedido> pedidos = snapshot.data;
            return pedidos.length > 0 ? ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, i) => _itemOrden(pedidos[i], size, context), 
              separatorBuilder: (_, i) => Divider(), 
              itemCount: pedidos.length
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

  _itemOrden(Pedido pedido, Size size, BuildContext context) {

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
          backgroundImage: NetworkImage(pedido.imagen),
          foregroundColor: Colors.white,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(pedido.nombre, style: styleTitle),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(5),
              color: Recursos().colorPrimario,
              child: Text('${pedido.cantidad}x', style: styleCantidad),
            ),
          ),
        ],
      ),
      subtitle: Text('\$${pedido.subtotal}', style: styleSubTitle),
      trailing: _popupOpcionesOrden(size, pedido),
      onTap: (){
        Menu menu = new Menu(
          idMenu: pedido.idMenuPromo,
          nombre: pedido.nombre,
          descripcion: pedido.descripcion,
          imagen: pedido.imagen,
          precio: pedido.precio
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

  Widget _popupOpcionesOrden(Size size, Pedido pedido) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      tooltip: 'Opciones',
      itemBuilder: (context) => [
        PopupMenuItem(
          child: FlatButton(
            onPressed: (){
              Navigator.of(context).pop();
              _pedidosController.deletePedido(pedido.idPedido);
            },
            child: Row(children: <Widget>[Text('Eliminar de la Orden'), SizedBox(width: size.width * 0.01), Icon(Icons.delete, color: Colors.red)])
          ),
        ),
      ]
    );
  }

  Widget _btnCancelarOrden(BuildContext context, Size size) {
    return StreamBuilder<List<Pedido>>(
      stream: _pedidosController.pedidosStream,
      builder: (context, snapshot) {
        if(snapshot.hasData) {

          List<Pedido> pedidos = snapshot.data;

          return pedidos.length > 0 ? Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: size.height * 0.05),
            child: FlatButton(
              splashColor: Recursos().colorSecundario,
              child: Text('Cancelar Orden'),
              onPressed: () {
                Recursos().showMessageConfirmar(context, () => _cancelarOrden(context), 'Cancelar Orden', '¿Está seguro que desea cancelar la orden?');
              },
              color: Recursos().colorPrimario,
              textColor: Colors.white,
            ),
          ) : Container();
        }
        else {
          return Center(child: CupertinoActivityIndicator(radius: 25));
        }
      }
    );
  }

  void _cancelarOrden(BuildContext context) {
    _pedidosController.cancelarOrden();
    Navigator.of(context).pop();
  }

  Widget _btnProcesarOrden(Size size) {
    return StreamBuilder<double>(
      stream: _pedidosController.totalStream,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          double total = snapshot.data;
          return total > 0 ? Container(
            child: MaterialButton(
              child: Text('Procesar Orden'),
              onPressed: () {
                _dialogConfirmarDireccionActual(context);
              },
              color: Recursos().colorPrimario,
              textColor: Colors.white,
              splashColor: Recursos().colorSecundario,
            ),
          ) : Container();
        }
        else return Container();
      }
    );
  }

  Widget _subTotal(Size size) {
    return StreamBuilder<double>(
      stream: _pedidosController.totalStream,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          double total = snapshot.data;
          return total > 0 ? ListTile(
            title: Text('Total: \$${total.toStringAsFixed(2)}'),
          ) : Container();
        }
        else {
          return Container();
        }
      }
    );
  }


  void _dialogConfirmarDireccionActual(BuildContext context) {
    Recursos().showMessageConfirmarDireccion(
      context,
      'Dirección Actual',
      'Su dirección actual es "${_storage.direccionStorage}"\n¿Desea Cambiarla?',
      'Cambiar',
      'Procesar Orden',
      () => _nuevaOrden(context)
    );
  }

  _cambiarDireccion(BuildContext context) {
    Navigator.of(context).pushNamed('administrar_direccion');
    Navigator.of(context).pop();
  }



  _nuevaOrden(BuildContext context) async {

    Orden orden = new Orden(idCliente: _storage.idClienteStorage, total: _pedidosController.total);

    final response = await _pedidosController.nuevaOrden(orden);

    if(response is Orden) {
      _pedidosController.pedidos.forEach((pedido) async {
        await _pedidosController.nuevoPedido(pedido, response.idOrden);
      });
      Recursos().showMessageSuccess(context, "Su Orden ha sido Registrada Correctamente!", () => _next(context)); 
    }
    else if (response is String) {
      Recursos().showMessageError(context, response);
    }

    _socketService.socket.emit('nueva-orden');

  }

  _next(BuildContext context) {
    //Navigator.of(context).pushNamed('ruta_de_la_pantalla_para_el_rastreo');   //Solo 1 de los 2
    Navigator.of(context).pop();
  }


  



}