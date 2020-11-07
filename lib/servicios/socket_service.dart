import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online, Offline, Connecting
}

class SocketService {

  //Propiedades
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;
  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {

    //'https://cipitiobackend.herokuapp.com'
    //'http://192.168.1.15:3000'

     this._socket = IO.io('http://192.168.1.15:3000', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    this._socket.on('connect', (_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
    });

    this._socket.on('disconnect', (_)  {
      print('disconnect');
      this._serverStatus = ServerStatus.Offline;
    });

    /*this._socket.on('get-ordenes', (data) {
      //final valor = data.containsKey('propiedad') ? data['propiedad'] : 'nel no hay';
      print(data);
    });*/

  }


}