

import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/vistas/mapa_add_direccion_page.dart';
import 'package:deliveryapplicacion/widgets/input_widget.dart';
import 'package:flutter/material.dart';

class NuevaDireccion extends StatelessWidget {

  final TextEditingController _direccionController = TextEditingController();
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    

    return Scaffold(
      appBar: AppBar(title: Text('Nueva Direccion'),),
      body: PageView(
        controller: _pageController,
        children: [
          _body(size, context),
          MapaAddDireccion(),
        ],
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Input(icon: Icons.directions, placeholder: 'Direccion Envío', textController: _direccionController),
          _btnNext(size, context),
        ],
      )
    );
  }

  Widget _btnNext(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.025, horizontal: size.width * 0.2
          ),
          onPressed: () => _next(context),
          child: Text(
            'Siguiente!',
            style: TextStyle(fontSize: 18),
          ),
          color: Recursos().colorTerciario,
          textColor: Colors.white,
          splashColor: Recursos().colorSecundario,
        ),
      ),
    );
  }


  void _next(BuildContext context) {
    /*if(_direccionController.text.isEmpty) {
      Recursos().showMessageError(context, "Falta Direccion de Envío!");
      return;
    }*/
    _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }
}