import 'package:flutter/material.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';

class AgregarDireccion extends StatelessWidget {
  TextEditingController _direccion_controller = new TextEditingController();

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
                    SizedBox(height: size.height * 0.1),
                    _icono(size),
                    SizedBox(height: size.height * 0.1),
                    //_body(size)
                    _inputdireccion(size),
                    SizedBox(height: size.height * 0.1),
                    _botonagregar(size),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputdireccion(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.015, horizontal: size.width * 0.1),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        controller: _direccion_controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Direccion',
          suffixIcon: Icon(Icons.gps_fixed),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Recursos().colorPrimario, width: 2),
              borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  Widget _titulo() {
    final style = TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 29,
        color: Recursos().colorPrimario);
    return Text('Ingresa tu direccion ', style: style);
  }

  Widget _icono(Size size) {
    return Container(
      child: Icon(
        Icons.maps_ugc_rounded,
        color: Recursos().colorPrimario,
        size: 100.0,
      ),
    );
  }

  Widget _botonagregar(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.025, horizontal: size.width * 0.2),
        onPressed: () async {
          _login();
        },
        child: Text(
          'Agregar Ubicacion!',
          style: TextStyle(fontSize: 18),
        ),
        color: Recursos().colorTerciario,
        textColor: Colors.white,
        splashColor: Recursos().colorSecundario,
      ),
    );
  }

  void _login() {
    return;
  }
}
