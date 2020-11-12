import 'package:deliveryapplicacion/controladores/clientes_controller.dart';
import 'package:deliveryapplicacion/modelos/cliente_model.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/servicios/shared_preferences.dart';
import 'package:deliveryapplicacion/widgets/input_widget.dart';
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
  bool _cargando = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          _body(size),
          _cargando ? Center(child: CupertinoActivityIndicator(radius: 25)) : Container(),
        ],
      ),
    );
  }

  Widget _body(Size size) {
    return Container(
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
                  Input(icon: Icons.email, placeholder: 'Email', textController: _emailController, keyboardType: TextInputType.emailAddress, textCapitalization: TextCapitalization.none),
                  Input(icon: Icons.fiber_pin, placeholder: 'Clave', textController: _claveController, isPassword: true),
                  SizedBox(height: size.height * 0.15),
                  _botonLogin(size),
                  SizedBox(height: size.height * 0.05),
                  _textRegistrarme(),
                ],
              ),
            ),
          ],
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

  Widget _botonLogin(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.025, horizontal: size.width * 0.2
        ),
        onPressed: !_cargando ? () async {
          _login();
        } : null,
        child: Text(
          'Iniciar!',
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

    this._cargando = true;
    setState(() {});

    Cliente cliente = new Cliente(clave: _claveController.text, email: _emailController.text);

    
    final response = await this._clientesController.login(cliente);

    if(response is Cliente) {
      this._cargando = false;
      setState(() {});
      Recursos().showMessageSuccess(
        context, "Bienvenido ${response.nombre}", () => _saveStorage(context, response));
    }
    else if (response is String) {
      this._cargando = false;
      setState(() {});
      Recursos().showMessageError(context, response);
    }

  }

  _saveStorage(BuildContext context, Cliente cliente) async {

    final direccionActual = await _getDireccionActual(cliente);

    _storage.emailStorage = cliente.email;
    _storage.nombreStorage = cliente.nombre;
    _storage.idClienteStorage = cliente.idCliente;
    _storage.direccionStorage = direccionActual.direccion;
    _storage.coordenadasStorage = direccionActual.coordenadas;
    _storage.referenciaStorage = direccionActual.referencia;

    Navigator.of(context).pushReplacementNamed('loading');
  }


  Future<DireccionCliente> _getDireccionActual(Cliente cliente) async {
    final direcciones = await _clientesController.direccionesByCliente(cliente.idCliente);
    return direcciones.firstWhere((direccion) => direccion.activo = true);
  }


}
