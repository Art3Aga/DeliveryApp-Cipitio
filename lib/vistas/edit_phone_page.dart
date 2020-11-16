import 'package:deliveryapplicacion/controladores/clientes_controller.dart';
import 'package:deliveryapplicacion/servicios/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';

class EditPhone extends StatefulWidget {
  @override
  _EditPhoneState createState() => _EditPhoneState();
}

class _EditPhoneState extends State<EditPhone> {
  TextEditingController _telefono_controller = new TextEditingController();
  bool _cargando = false;
  final _change = new ClientesController();
  StorageCliente sharedCliente = new StorageCliente();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Cambiar numero de telefono')),
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
                    _saludo2(),
                    _cargando
                        ? Center(child: CupertinoActivityIndicator(radius: 25))
                        : Container(),
                    SizedBox(height: size.height * 0.05),
                    //_body(size)
                    _inputTelefono(size),
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

  Widget _inputTelefono(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.015, horizontal: size.width * 0.1),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        controller: _telefono_controller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: 'Telefono',
          suffixIcon: Icon(Icons.phone),
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
    return Text('Edita tu numero de telefono ', style: style);
  }

  Widget _saludo() {
    final style = TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 25,
        color: Recursos().colorPrimario);
    return Text('Numero Actual', style: style);
  }

  Widget _saludo2() {
    final style = TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 25,
        color: Recursos().colorPrimario);
    return Text('${sharedCliente.telefono}', style: style);
  }

  Widget _icono(Size size) {
    return Container(
      child: Icon(
        Icons.phone,
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
          _cambiarTelefono();
        },
        child: Text(
          'Confirmar Numero!',
          style: TextStyle(fontSize: 18),
        ),
        color: Recursos().colorTerciario,
        textColor: Colors.white,
        splashColor: Recursos().colorSecundario,
      ),
    );
  }

  void _cambiarTelefono() async {
    if (_telefono_controller.text.isEmpty) {
      Recursos().showMessageError(context, "Faltan Datos!");
      return;
    }

    this._cargando = true;
    setState(() {});

    final response = await this
        ._change
        .updatePhone(sharedCliente.idClienteStorage, _telefono_controller.text);

    if (response is Cliente) {
      this._cargando = false;
      setState(() {});
      Recursos().showMessageSuccess(
          context,
          "Se ha cambiado el telefono a ${response.telefono}",
          () => {sharedCliente.telefono = response.telefono, Navigator.pop(context), Navigator.pop(context)});
    } else if (response is String) {
      this._cargando = false;
      setState(() {});
      Recursos().showMessageError(context, response);
    }
  }
}
