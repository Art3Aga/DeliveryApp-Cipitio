

import 'package:animate_do/animate_do.dart';
import 'package:deliveryapplicacion/controladores/ubicacion_cliente_controller.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:deliveryapplicacion/widgets/dialog_input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaAddDireccion extends StatefulWidget {
  @override
  _MapaAddDireccionState createState() => _MapaAddDireccionState();
}

class _MapaAddDireccionState extends State<MapaAddDireccion> {

  CameraPosition _cameraPosition;
  GoogleMapController _mapController;
  final _ubicacionClienteController = new UbicacionClienteController();


  @override
  void initState() { 
    _ubicacionClienteController.startSeguimiento();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: _body(context, size)
    );
  }

  Widget _body(BuildContext context, Size size) {
    return StreamBuilder<LatLng>(
      stream: _ubicacionClienteController.ubicacionStream,
      builder: (context, snapshot) {

        if(snapshot.hasData) {
          final ubicacion = snapshot.data;
          return Stack(
            children: [
              crearMapa(ubicacion),
              _marcadorCentral(),
              _btnRegresar(context),
              _btnConfirmarDestino(context, size)
            ],
          );
        }
        else {
          return Center(child: CupertinoActivityIndicator(radius: 25));
        }
        
      }
    );
  }



  Widget crearMapa(LatLng ubicacion) {

    final positionInitial = new CameraPosition(
      target: ubicacion,
      zoom: 15
    );

    return GoogleMap(
      initialCameraPosition: positionInitial,
      compassEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      onMapCreated: (controller) {
        _mapController = controller;
      },
      onCameraMove: (cameraPosition) {},
    );
  }


  Widget _marcadorCentral() {
    return Center(
      child: Transform.translate(
        child: BounceInDown(
          from: 250,
          duration: Duration(milliseconds: 1100),
          child: Icon(Icons.location_on, size: 50, color: Recursos().colorPrimario),
        ),
        offset: Offset(0, -25),
      ),
    );
  }

  Widget _btnRegresar(BuildContext context) {
    return Positioned(
      top: 70,
      left: 20,
      child: FadeInLeft(
        duration: Duration(milliseconds: 1100),
        child: CircleAvatar(
          maxRadius: 25,
          backgroundColor: Recursos().colorPrimario,
          child: IconButton(
            splashColor: Recursos().colorSecundario,
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  Widget _btnConfirmarDestino(BuildContext context, Size size) {
    return Positioned(
      bottom: size.height * 0.07,
      left: size.width * 0.1,
      child: FadeInRight(
        duration: Duration(milliseconds: 1100),
        child: MaterialButton(
          color: Recursos().colorPrimario,
          shape: StadiumBorder(),
          splashColor: Recursos().colorSecundario,
          elevation: 0,
          minWidth: size.width - 120,
          child: Text('Confirmar Ubicación', style: TextStyle(color: Colors.white),),
          onPressed: () {
            final dialog = Dialog(
                child: Container(width: size.width * 0.9, height: size.height * 0.35, child: DialogInput()),
                insetAnimationCurve: Curves.easeIn,
                insetAnimationDuration: Duration(milliseconds: 500),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              );
            showDialog(context: context, builder: (_) => dialog);
          },
        ),
      )
    );
  }
  
}