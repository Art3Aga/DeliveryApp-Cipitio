import 'package:deliveryapplicacion/controladores/clientes_controller.dart';
import 'package:deliveryapplicacion/modelos/cliente_model.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/servicios/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _telefonoController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _claveController = new TextEditingController();

  final _clientesController = new ClientesController();
  final _storage = new StorageCliente();

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
                    SizedBox(height: size.height * 0.05),
                    _icono(size),
                    SizedBox(height: size.height * 0.1),
                    //_inputTelefono(size),
                    _inputEmail(size),
                    _inputClave(size),
                    SizedBox(height: size.height * 0.15),
                    _botonLogin(size),
                    SizedBox(height: size.height * 0.05),
                    _textRegistrarme(),
                    //SizedBox(height: size.height * 0.03),
                    //_textOlvideMiClave()
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

  Widget _inputTelefono(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.015, horizontal: size.width * 0.1),
      child: Theme(
        data: Theme.of(context).copyWith(primaryColor: Recursos().colorPrimario),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          controller: _telefonoController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Telefono',
            suffixIcon: Icon(Icons.phone),
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Recursos().colorPrimario, width: 2),
              borderRadius: BorderRadius.circular(15)
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputEmail(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.015, horizontal: size.width * 0.1),
      child: Theme(
        data: Theme.of(context).copyWith(primaryColor: Recursos().colorPrimario),
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            suffixIcon: Icon(Icons.email),
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Recursos().colorPrimario, width: 2),
              borderRadius: BorderRadius.circular(15)
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputClave(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.015, horizontal: size.width * 0.1),
      child: Theme(
        data: Theme.of(context).copyWith(primaryColor: Recursos().colorPrimario),
        child: TextFormField(
          controller: _claveController,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Clave',
            suffixIcon: Icon(Icons.fiber_pin),
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Recursos().colorPrimario, width: 2),
              borderRadius: BorderRadius.circular(15)
            ),
          ),
        ),
      ),
    );
  }

  Widget _botonLogin(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.025, horizontal: size.width * 0.2
        ),
        onPressed: () async {
          _login();
        },
        child: Text(
          'Iniciar !',
          style: TextStyle(fontSize: 18),
        ),
        color: Recursos().colorTerciario,
        textColor: Colors.white,
        splashColor: Recursos().colorSecundario,
      ),
    );
  }

  Widget _textRegistrarme() {
    final style = TextStyle(
      color: Colors.grey, fontSize: 15, fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline
    );
    return Container(
      child: GestureDetector(
        child: Text('¡Registrarme!', style: style),
        onTap: () => Navigator.of(context).pushReplacementNamed('registro'),
      ),
    );
  }

  Widget _textOlvideMiClave() {
    final style = TextStyle(
      color: Colors.grey, fontSize: 15, fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline
    );
    return Container(
      child: GestureDetector(
        child: Text('¿Olvidaste tu contraseña?', style: style),
        onTap: () {},
      ),
    );
  }

  void _login() async {

    if (_emailController.text.isEmpty || _claveController.text.isEmpty) {
      Recursos().showMessageError(context, "Faltan Datos!");
      return;
    }

    Cliente cliente = new Cliente(clave: _claveController.text, email: _emailController.text);

    
    final response = await this._clientesController.login(cliente);

    if(response is Cliente) {
      Recursos().showMessageSuccess(
        context, "Bienvenido ${response.nombre}", () {
        _storage.emailStorage = response.email;
        Navigator.of(context).pushReplacementNamed('home');
      });
    }
    else if (response is String) {

      Recursos().showMessageError(context, response);

    }

  }


}
