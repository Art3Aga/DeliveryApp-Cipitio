import 'package:flutter/material.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/vistas/agregar_dir_page.dart';

class AdministrarUbicacion extends StatelessWidget {
  TextEditingController _password_controller = new TextEditingController();
  TextEditingController _password_confirmar_controller =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: size.width * 0.2),
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _titulo(),
                    SizedBox(
                      height: size.height * 0.7,
                    ),
                    _botonagregar(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titulo() {
    final style = TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 29,
        color: Recursos().colorPrimario);
    return Text('Tus direcciones', style: style);
  }

  Widget _icono(Size size) {
    return Container(
      child: Icon(
        Icons.gps_fixed,
        color: Recursos().colorPrimario,
        size: 50.0,
      ),
    );
  }

  Widget _botonagregar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AgregarDireccion()));
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Recursos().colorPrimario,
      ),
    );
  }
}
