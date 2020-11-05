


import 'package:deliveryapplicacion/controladores/clientes_controller.dart';
import 'package:deliveryapplicacion/controladores/ubicacion_cliente_controller.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/servicios/shared_preferences.dart';
import 'package:deliveryapplicacion/widgets/input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogInput extends StatefulWidget {

  final bool registrarDireccionEnDB;
  final bool direccionActiva;
  DialogInput({Key key, @required this.registrarDireccionEnDB, @required this.direccionActiva}) : super(key: key);

  @override
  _DialogInputState createState() => _DialogInputState();
}

class _DialogInputState extends State<DialogInput> {


  TextEditingController _direccionController = new TextEditingController();
  TextEditingController _referenciaController = new TextEditingController();


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
          _body(size, context),
          _cargando ? Center(child: CupertinoActivityIndicator(radius: 25)) : Container(),
        ]
      )
    );
  }


  Widget _body(Size size, BuildContext context) {

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(icon: Icon(Icons.close), onPressed: () => _cerrarDialog(context))
            ],
          ),
          Input(icon: Icons.directions, placeholder: 'Nombre del Lugar...', textController: _direccionController),
          Input(icon: Icons.pin_drop, placeholder: 'Punto de Referencia', textController: _referenciaController),
          _btnSaveUbicacion(size, context)
        ],
      ),
    );

  }

  Widget _btnSaveUbicacion(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.025),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.015, horizontal: size.width * 0.15
          ),
          onPressed: !_cargando ? () async {
            _saveUbicacion(context);
          } : null,
          child: Text('Guardar Ubicación!', style: TextStyle(fontSize: 15)),
          color: Recursos().colorPrimario,
          textColor: Colors.white,
          splashColor: Recursos().colorSecundario,
        ),
      ),
    );
  }

  void _saveUbicacion(BuildContext context) {

    if(_direccionController.text.isEmpty || _referenciaController.text.isEmpty) {
      Recursos().showMessageError(context, 'Faltan Datos!');
      return;
    }
    if(widget.registrarDireccionEnDB) {

      DireccionCliente direccion = new DireccionCliente(
        idCliente: _storage.idClienteStorage,
        direccion: _direccionController.text,
        referencia: _referenciaController.text,
        coordenadas: _ubicacionClienteController.coordenadas,
        activo: widget.direccionActiva
      );

      _saveDireccion(direccion, context);

    }
    else {

      _ubicacionClienteController.addDireccion(_direccionController.text);
      _ubicacionClienteController.addReferencia(_referenciaController.text);
      Navigator.of(context).pop();
      Recursos().showMessageSuccess(context, 'Ubicacion Guardada!', (){}, 'La Ubicación "${_direccionController.text}" estará en su perfil!', true);

    }

  }

  _saveDireccion(DireccionCliente direccion, BuildContext context) async {

    final response = await _clientesController.registroDireccion(direccion);

    if(response is DireccionCliente) {
      this._cargando = false;
      setState(() {});
      Navigator.of(context).pop();
      Recursos().showMessageSuccess(context, 'Ubicacion Guardada!', (){}, 'La Ubicación "${_direccionController.text}" estará en su perfil!', true);
    }

    else if (response is String) {
      this._cargando = false;
      setState(() {});
      Recursos().showMessageError(context, response);
    }
  }

  void _cerrarDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}