import 'package:deliveryapplicacion/recursos/recursos.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
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
                    SizedBox(height: size.height * 0.02),
                    _icono(size),
                    SizedBox(height: size.height * 0.02),
                    _saludo(),
                    SizedBox(height: size.height * 0.02),
                    _saludo2(),
                    SizedBox(height: size.height * 0.05),
                    //_body(size)
                    _botondirecciones(size),
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


  Widget _titulo() {
    final style = TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 29,
        color: Recursos().colorPrimario);
    return Text('Mi Perfil', style: style);
  }

  Widget _saludo() {
    final style = TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 25,
        color: Recursos().colorPrimario);
    return Text('Hola', style: style);
  }

  Widget _saludo2() {
    final style = TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 25,
        color: Recursos().colorPrimario);
    return Text('Bienvenidos a El Cipitillo ', style: style);
  }

  Widget _icono(Size size) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(50), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 11,
          offset: Offset(0, 3),
        ),
      ]),
      child: CircleAvatar(
        radius: size.width * 0.13,
        backgroundColor: Recursos().colorPrimario,
        child: Text('EC'),
      ),
    );
  }

  Widget _botondirecciones(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
        topLeft: Radius.circular(30),
      ),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.width * 0.1),
        onPressed: _login,
        child: Text(
          'Edita Tus Direcciones',
          style: TextStyle(fontSize: 18),
        ),
        color: Recursos().colorTerciario,
        textColor: Colors.white,
        splashColor: Recursos().colorSecundario,
      ),
    );
  }

  Widget _botontelefono(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
        topLeft: Radius.circular(30),
      ),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.width * 0.1),
        onPressed: _login,
        child: Text(
          'Numero De Telefono',
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
