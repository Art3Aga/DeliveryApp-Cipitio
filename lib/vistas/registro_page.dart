import 'package:deliveryapplicacion/controladores/clientes_controller.dart';
import 'package:deliveryapplicacion/controladores/ubicacion_cliente_controller.dart';
import 'package:deliveryapplicacion/modelos/cliente_model.dart';
import 'package:deliveryapplicacion/modelos/direccion_model.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/servicios/shared_preferences.dart';
import 'package:deliveryapplicacion/vistas/mapa_add_direccion_page.dart';
import 'package:deliveryapplicacion/widgets/input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {


  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _telefonoController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _claveController = new TextEditingController();
  TextEditingController _direccionesController = new TextEditingController();
  
  final _ubicacionClienteController = new UbicacionClienteController();
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
        ]
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
                  SizedBox(height: size.height * 0.01),
                  _icono(size),
                  SizedBox(height: size.height * 0.01),
                  Input(icon: Icons.person, placeholder: 'Nombre Completo', textController: _nombreController),
                  Input(icon: Icons.phone, placeholder: 'Telefono', textController: _telefonoController, keyboardType: TextInputType.phone),
                  Input(icon: Icons.email, placeholder: 'Email', textController: _emailController, keyboardType: TextInputType.emailAddress, textCapitalization: TextCapitalization.none),
                  Input(icon: Icons.fiber_pin, placeholder: 'Clave', textController: _claveController, isPassword: true, textCapitalization: TextCapitalization.none),
                  _inputDireccionEnvio(),
                  SizedBox(height: size.height * 0.02),
                  _botonLogin(size),
                  SizedBox(height: size.height * 0.02),
                  _textYaTengoUnaCuenta(),
                  SizedBox(height: size.height * 0.02),
                  _botonesRedes(size)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputDireccionEnvio() {
    return StreamBuilder<String>(
      stream: _ubicacionClienteController.direccionStream,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          String direccion = snapshot.data;
          _direccionesController.text = direccion;
          return Input(icon: Icons.directions, placeholder: 'Direccion Envío', textController: _direccionesController, readOnly: true, onTap: _navegarDirecciones);
        }
        else {
          return Input(icon: Icons.directions, placeholder: 'Direccion Envío', textController: _direccionesController, readOnly: true, onTap: _navegarDirecciones);
        }
      }
    );
  }

  Widget _titulo() {
    final style = TextStyle(fontWeight: FontWeight.w900, fontSize: 29);
    return Text('Registro El Cipitio', style: style);
  }

  Widget _icono(Size size) {
    return Container(
      decoration:
        BoxDecoration(
          borderRadius: BorderRadius.circular(50), 
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 11,
              offset: Offset(0, 3),
            ),
          ]
        ),
      child: CircleAvatar(
        radius: size.width * 0.15,
        backgroundImage: AssetImage('assets/cipitio_icon.jpg'),
      ),
    );
  }

  void _navegarDirecciones() {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.push(context, MaterialPageRoute(builder: (context) => MapaAddDireccion(registrarDireccionEnDB: false, direccionActiva: false)));
  }

  Widget _botonLogin(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.025, horizontal: size.width * 0.2
        ),
        onPressed: !_cargando ?  () async {
          _registro();
        } : null,
        child: Text(
          'Registrarme !',
          style: TextStyle(fontSize: 18),
        ),
        color: Recursos().colorTerciario,
        textColor: Colors.white,
        splashColor: Recursos().colorSecundario,
      ),
    );
  }

  Widget _textYaTengoUnaCuenta() {
    final style = TextStyle(
      color: Colors.grey, fontSize: 15, fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline
    );
    return Container(
      child: GestureDetector(
        child: Text('¡Ya Tengo una Cuenta!', style: style),
        onTap: () => Navigator.of(context).pushReplacementNamed('login'),
      ),
    );
  }


  Widget _botonesRedes(Size size) {
    return Container(
      padding: EdgeInsets.all(size.height * 0.01),
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _botonFacebook(size),
          _botonTwitter(size)
        ],
      ),
    );
  }

  Widget _botonFacebook(Size size) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Color.fromRGBO(59, 89, 152, 1),
      child: GestureDetector(
        child: FaIcon(FontAwesomeIcons.facebook, size: 30, color: Colors.white),
        onTap: (){},
      ),
    );
  }

  Widget _botonTwitter(Size size) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Color.fromRGBO(0, 172, 238, 1),
      child: GestureDetector(
        child: FaIcon(FontAwesomeIcons.twitter, size: 30, color: Colors.white),
        onTap: (){},
      ),
    );
  }

  void _registro() async {
    if (_nombreController.text.isEmpty || _telefonoController.text.isEmpty
        || _claveController.text.isEmpty || _emailController.text.isEmpty || _direccionesController.text.isEmpty) {
      Recursos().showMessageError(context, "Faltan Datos!");
      return;
    }

    this._cargando = true;
    setState(() {});

    Cliente cliente = new Cliente(
      nombre: _nombreController.text, telefono: _telefonoController.text,
      email: _emailController.text, clave: _claveController.text
    );

    final response = await this._clientesController.registro(cliente);

    if(response is Cliente) {
      _registroDireccion(response);
    }
    else if (response is String) {
      this._cargando = false;
      setState(() {});
      Recursos().showMessageError(context, response);
    }
  }


  void _registroDireccion(Cliente cliente) async {

    DireccionCliente direccion = new DireccionCliente(
      idCliente: cliente.idCliente,
      direccion: _direccionesController.text,
      referencia: _ubicacionClienteController.referencia,
      coordenadas: _ubicacionClienteController.coordenadas,
      activo: true
    );

    final response = await this._clientesController.registroDireccion(direccion);

    if(response is DireccionCliente) {
      this._cargando = false;
      setState(() {});
      Recursos().showMessageSuccess(context, "Bienvenido ${cliente.nombre}", () {
        _storage.emailStorage = cliente.email;
        _storage.nombreStorage = cliente.nombre;
        _storage.idClienteStorage = cliente.idCliente;
        Navigator.of(context).pushReplacementNamed('loading');
      }); 
    }
    else if (response is String) {
      this._cargando = false;
      setState(() {});
      Recursos().showMessageError(context, response);
    }

  }



}
