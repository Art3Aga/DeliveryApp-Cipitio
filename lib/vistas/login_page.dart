import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _telefonoController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: size.width * 0.3),
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
                    _inputNombre(size),
                    _inputTelefono(size),
                    SizedBox(height: size.height * 0.02),
                    _botonLogin(size),
                    //SizedBox(height: size.height * 0.02),
                    // _botonregister(size)
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
    final style = TextStyle(fontWeight: FontWeight.w900, fontSize: 29);
    return Text('Panes El Cipitio', style: style);
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
        radius: size.width * 0.15,
        backgroundImage: AssetImage('assets/cipitio_icon.jpg'),
      ),
    );
  }

  Widget _inputNombre(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.1),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        controller: _nombreController,
        decoration: InputDecoration(
          hintText: 'Nombre',
          suffixIcon: Icon(Icons.person),
        ),
      ),
    );
  }

  Widget _inputTelefono(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.1),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        controller: _telefonoController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: 'Telefono',
          suffixIcon: Icon(Icons.phone),
        ),
      ),
    );
  }

  Widget _botonLogin(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(5),
        topLeft: Radius.circular(5),
      ),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.025, horizontal: size.width * 0.025),
        onPressed: _login,
        child: Text(
          'Iniciar Sesion',
          style: TextStyle(fontSize: 18),
        ),
        color: Recursos().colorTerciario,
        textColor: Colors.white,
        splashColor: Recursos().colorSecundario,
      ),
    );
  }

  Widget _botonregister(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(5),
        topLeft: Radius.circular(5),
      ),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.025, horizontal: size.width * 0.025),
        onPressed: _registro,
        child: Text(
          'Registro',
          style: TextStyle(fontSize: 18),
        ),
        color: Recursos().colorTerciario,
        textColor: Colors.white,
        splashColor: Recursos().colorSecundario,
      ),
    );
  }

  void _login() {
    if (_nombreController.text.isEmpty || _telefonoController.text.isEmpty) {
      Recursos().showMessageError(context, "Faltan Datos!");
      return;
    }

    Recursos().showMessageSuccess(
        context, "Bienvenido ${_nombreController.text}", () {
      Navigator.of(context).pushReplacementNamed('home');
    });
  }

  void _registro() {
    Recursos().showMessageSuccess(
        context, "Bienvenido ${_nombreController.text}", () {
      Navigator.of(context).pushReplacementNamed('registro');
    });
  }
}
