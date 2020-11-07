import 'package:flutter/material.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditPass extends StatelessWidget {
  TextEditingController _password_controller = new TextEditingController();
  TextEditingController _password_confirmar_controller =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Cambiar Contraseña')),
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
                    SizedBox(height: size.height * 0.05),
                    _icono(size),
                    SizedBox(height: size.height * 0.05),
                    _saludo(),
                    SizedBox(height: size.height * 0.05),
                    _inputpassword_actual(size),
                    SizedBox(height: size.height * 0.05),
                    _saludo2(),
                    SizedBox(height: size.height * 0.05),
                    //_body(size)
                    _inputpassword_nueva(size),
                    SizedBox(height: size.height * 0.05),
                    _botontelefono(size),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputpassword_actual(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.015, horizontal: size.width * 0.1),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        controller: _password_controller,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Contraseña Actual',
          suffixIcon: Icon(Icons.fiber_pin),
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

  Widget _inputpassword_nueva(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.015, horizontal: size.width * 0.1),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        controller: _password_confirmar_controller,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Nueva Contraseña',
          suffixIcon: Icon(Icons.fiber_pin),
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
    return Text('Edita tu contraseña ', style: style);
  }

  Widget _saludo() {
    final style = TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 25,
        color: Recursos().colorPrimario);
    return Text('Ingresa tu contraseña', style: style);
  }

  Widget _saludo2() {
    final style = TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 25,
        color: Recursos().colorPrimario);
    return Text('Nueva Contraseña', style: style);
  }

  Widget _icono(Size size) {
    return Container(
      child: Icon(
        //Icons.admin_panel_settings_rounded,
        FontAwesomeIcons.edit,
        color: Recursos().colorPrimario,
        size: 100.0,
      ),
    );
  }

  Widget _botontelefono(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.025, horizontal: size.width * 0.2),
        onPressed: () async {
          _login();
        },
        child: Text(
          'Confirmar Cambios!',
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
