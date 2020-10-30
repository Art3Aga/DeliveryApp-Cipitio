
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {


  @override
  void initState() { 
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if(state == AppLifecycleState.resumed ) {
      // ignore: deprecated_member_use
      if(await Geolocator.isLocationServiceEnabled()) {
        Navigator.of(context).pushNamed('home');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            return Center(
              child: Text(snapshot.data),
            );
          }
          else {
            return Center(
              child: CupertinoActivityIndicator(radius: 25,),
            );
          }
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async {

    final permisoGPS = await Permission.location.isGranted;
    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    if(permisoGPS && gpsActivo) {
      Navigator.of(context).pushNamed('home');
      return '';
    }
    else if(!permisoGPS) {
      Navigator.of(context).pushNamed('acceso_gps');
      return 'Es necesario el permiso del GPS';
    }
    else return 'Active el GPS';
  }
}