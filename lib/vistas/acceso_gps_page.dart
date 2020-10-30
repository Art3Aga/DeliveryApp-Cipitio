

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessoGpsPage extends StatefulWidget {
  @override
  _AccessoGpsPageState createState() => _AccessoGpsPageState();
}

class _AccessoGpsPageState extends State<AccessoGpsPage> with WidgetsBindingObserver {


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
      if(await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, 'home');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Es necesario usar el GPS'),
            MaterialButton(
              shape: StadiumBorder(),
              elevation: 0,
              onPressed: () async {
                final status = await Permission.location.request();
                this.accesoGPS(status);
              },
              child: Text('Solicitar Acceso GPS', style: TextStyle(color: Colors.white),),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  accesoGPS(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'mapa');
        break;
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}