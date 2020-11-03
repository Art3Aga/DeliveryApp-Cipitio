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
          _title(),
        ],
      ),
      floatingActionButton: _boton_agregar(context),
    );
  }

  Widget _title() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Puntos De Entrega',
                style: TextStyle(
                    color: Recursos().colorTerciario,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text('El Cipitio',
                style: TextStyle(
                    color: Recursos().colorTerciario, fontSize: 14.0)),
          ],
        ),
      ),
    );
  }

  Widget _boton_agregar(BuildContext context) {
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
}
