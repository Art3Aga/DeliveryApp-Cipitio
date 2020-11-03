import 'package:flutter/material.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/vistas/mapa_add_direccion_page.dart';

class AdministrarUbicacion extends StatelessWidget {
  TextEditingController _password_controller = new TextEditingController();
  TextEditingController _password_confirmar_controller =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
            Text('Puntos De Entrega',
                style: TextStyle(
                    color: Recursos().colorTerciario,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.02),
            Text('El Cipitio',
                style: TextStyle(
                    color: Recursos().colorTerciario, fontSize: 14.0)),
          ],
        ),
      ),
    );
  }


  Widget _listaDirecciones(Size size) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, i) => _itemDireccion()
    );
  }

  Widget _botonAgregar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MapaAddDireccion()));
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Recursos().colorPrimario,
      ),
    );
  }

  Widget _itemDireccion() {
    return ListTile(
      onTap: (){},
      leading: Icon(Icons.pin_drop),
      trailing: Icon(Icons.more_vert),
      title: Text('Casita'),
      subtitle: Text('Cerca del Mercadito'),
    );
  }
}
