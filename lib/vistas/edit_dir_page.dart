import 'package:deliveryapplicacion/controladores/clientes_controller.dart';
import 'package:deliveryapplicacion/modelos/direccion_model.dart';
import 'package:deliveryapplicacion/servicios/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/vistas/mapa_add_direccion_page.dart';

// ignore: must_be_immutable
class AdministrarUbicacion extends StatelessWidget {


  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordConfirmarController = new TextEditingController();
  final _clientesController = new ClientesController();
  final _storage = new StorageCliente();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(title: Text('Direcciones')),
      body: ListView(
        children: [
          _title(size),
          _listaDirecciones(size)
        ],
      ),
      floatingActionButton: _botonAgregar(context),
    );
  }

  Widget _title(Size size) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Direcciones de Envío',
              style: TextStyle(color: Recursos().colorTerciario, fontSize: 24.0, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: size.height * 0.02),
            Text('El Cipitio',
              style: TextStyle(color: Recursos().colorTerciario, fontSize: 14.0)
            ),
          ],
        ),
      ),
    );
  }


  Widget _listaDirecciones(Size size) {

    _clientesController.direccionesByCliente(_storage.idClienteStorage);

    return StreamBuilder<List<DireccionCliente>>(
      stream: _clientesController.direccionesStream,
      builder: (context, snapshot) {

        if(snapshot.hasData) {

          final direcciones = snapshot.data;

          return direcciones.length > 0 ? ListView.separated(
            shrinkWrap: true,
            itemCount: direcciones.length,
            itemBuilder: (context, i) => _itemDireccion(direcciones[i], size),
            separatorBuilder: (context, i) => Divider(),
          ) : Container(child: Center(child: Text('No hay Direcciones de Envío Registradas!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))));

        }
        else {
          return Center(child: CupertinoActivityIndicator(radius: 25));
        }

      }
    );
  }

  Widget _botonAgregar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MapaAddDireccion(registrarDireccionEnDB: true, direccionActiva: false)));
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Recursos().colorPrimario,
      ),
    );
  }

  Widget _itemDireccion(DireccionCliente direccion, Size size) {

    Icon icon = direccion.activo ? Icon(Icons.pin_drop, color: Colors.green) : Icon(Icons.pin_drop, color: Colors.grey);

    return ListTile(
      onTap: (){},
      leading: icon,
      trailing: _popupOpcionesDireccion(size, direccion),
      title: Text(direccion.direccion),
      subtitle: Text(direccion.referencia),
    );
  }

  Widget _popupOpcionesDireccion(Size size, DireccionCliente direccion) {
    return direccion.activo ? PopupMenuButton(
      icon: Icon(Icons.more_vert),
      tooltip: 'Opciones',
      itemBuilder: (context) => [
        _itemPopup(size, 'Editar', Icons.edit, Colors.blue, () => Navigator.of(context).pop()),
        _itemPopup(size, 'Eliminar', Icons.delete, Colors.red, () => Navigator.of(context).pop()),
      ]
    ) :
    PopupMenuButton(
      icon: Icon(Icons.more_vert),
      tooltip: 'Opciones',
      itemBuilder: (context) => [
        _itemPopup(size, 'Hacer Direccion Actual', Icons.edit_location, Colors.green, () => Navigator.of(context).pop()),
        _itemPopup(size, 'Editar', Icons.edit, Colors.blue, () => Navigator.of(context).pop()),
        _itemPopup(size, 'Eliminar', Icons.delete, Colors.red, () => Navigator.of(context).pop()),
      ]
    );
  }

  PopupMenuItem _itemPopup(Size size, String titulo, IconData icon, Color iconColor, Function callback) {
    return PopupMenuItem(
      child: FlatButton(
        onPressed: callback,
        child: Row(
          children: <Widget>[
            Text(titulo), SizedBox(width: size.width * 0.01), Icon(icon, color: iconColor),
          ]
        ),
      )
    );
  }
}
