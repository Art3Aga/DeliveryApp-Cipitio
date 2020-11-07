import 'dart:convert';

Orden ordenFromJson(String str) => Orden.fromJson(json.decode(str));

String ordenToJson(Orden data) => json.encode(data.toJson());

class Orden {
    Orden({
        this.idOrden,
        this.idCliente,
        this.estado,
        this.total,
        this.fecha,
    });

    String idOrden;
    String idCliente;
    String estado;
    double total;
    String fecha;

    factory Orden.fromJson(Map<String, dynamic> json) => Orden(
        idOrden: json["id_orden"],
        idCliente: json["id_cliente"],
        estado: json["estado"],
        total: json["total"],
        fecha: json["fecha"],
    );

    Map<String, dynamic> toJson() => {
        "id_orden": idOrden,
        "id_cliente": idCliente,
        "estado": estado,
        "total": total,
        "fecha": fecha,
    };
}