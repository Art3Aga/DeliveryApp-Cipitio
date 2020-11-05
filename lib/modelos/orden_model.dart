import 'dart:convert';

Orden ordenFromJson(String str) => Orden.fromJson(json.decode(str));

String ordenToJson(Orden data) => json.encode(data.toJson());

class Orden {
    Orden({
        this.idOrden,
        this.idMenu,
        this.nombre,
        this.descripcion,
        this.precio,
        this.imagen,
        this.cantidad,
        this.precioOrden,
    });

    String idOrden;
    String idMenu;
    String nombre;
    String descripcion;
    double precio;
    String imagen;
    int cantidad;
    double precioOrden;

    factory Orden.fromJson(Map<String, dynamic> json) => Orden(
        idOrden: json["id_orden"],
        idMenu: json["id_menu"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        imagen: json["imagen"],
        cantidad: json["cantidad"],
        precioOrden: json["precio_orden"],
    );

    Map<String, dynamic> toJson() => {
        "id_orden": idOrden,
        "id_menu": idMenu,
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
        "imagen": imagen,
        "cantidad": cantidad,
        "precio_orden": precioOrden,
    };
}