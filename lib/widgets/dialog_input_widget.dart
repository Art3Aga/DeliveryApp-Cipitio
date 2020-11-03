


import 'package:deliveryapplicacion/controladores/ubicacion_cliente_controller.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/widgets/input_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DialogInput extends StatelessWidget {


  TextEditingController _direccionController = new TextEditingController();
  TextEditingController _referenciaController = new TextEditingController();

  final _ubicacionClienteController = new UbicacionClienteController();
  


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
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
          onPressed: () => _saveUbicacion(context),
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
    _ubicacionClienteController.addDireccion(_direccionController.text);
    _ubicacionClienteController.addReferencia(_referenciaController.text);
    Navigator.of(context).pop();
    Recursos().showMessageSuccess(context, 'Ubicacion Guardada!', (){}, 'La Ubicación ${_direccionController.text} estará en su perfil!');
  }

  void _cerrarDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}