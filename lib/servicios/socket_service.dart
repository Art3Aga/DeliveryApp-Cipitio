import 'package:deliveryapplicacion/servicios/shared_preferences.dart';
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
  final _storage = new StorageCliente();


  void connectar() {

    //'https://cipitiobackend.herokuapp.com'
    //'http://192.168.1.15:3000'

     this._socket = IO.io('http://192.168.1.15:3000', {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'id_usuario': _storage.idClienteStorage
      }
    });

    this._socket.on('connect', (_) {
      print('conectado al socket');
      this._serverStatus = ServerStatus.Online;
    });

    this._socket.on('disconnect', (_)  {
      print('desconectado del socket');
      this._serverStatus = ServerStatus.Offline;
    });
  }

  void desconectar() {
    this._socket.disconnect();
  }


}