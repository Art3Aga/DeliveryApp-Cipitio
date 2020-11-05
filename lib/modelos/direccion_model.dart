import 'dart:convert';


class Direcciones {

  List<DireccionCliente> items = new List();

  Direcciones();

  Direcciones.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final direccion = new DireccionCliente.fromJson(item);
      items.add( direccion );
    }

  }

}

DireccionCliente direccionClienteFromJson(String str) => DireccionCliente.fromJson(json.decode(str));

String direccionClienteToJson(DireccionCliente data) => json.encode(data.toJson());

class DireccionCliente {
    DireccionCliente({
        this.idCliente,
        this.direccion,
        this.referencia,
        this.coordenadas,
        this.activo,
    });

    String idCliente;
    String direccion;
    String referencia;
    String coordenadas;
    bool activo;

    factory DireccionCliente.fromJson(Map<String, dynamic> json) => DireccionCliente(
        idCliente: json["id_cliente"],
        direccion: json["direccion"],
        referencia: json["referencia"],
        coordenadas: json["coordenadas"],
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "id_cliente": idCliente,
        "direccion": direccion,
        "referencia": referencia,
        "coordenadas": coordenadas,
        "activo": activo
    };
}