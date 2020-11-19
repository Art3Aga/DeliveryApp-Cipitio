import 'dart:convert';

Promocion promocionFromJson(String str) => Promocion.fromJson(json.decode(str));

String promocionToJson(Promocion data) => json.encode(data.toJson());

class Promocion {
  Promocion({
    this.idPromo,
    this.nombre,
    this.precio,
    this.descripcion,
    this.imagen,
    this.nota,
    this.idMenus,
    this.descuento,
    this.cantidad,
    this.subtotal
  });

  String idPromo;
  String nombre;
  double precio;
  String descripcion;
  String imagen;
  String nota;
  String idMenus;
  double descuento;
  int cantidad;
  double subtotal;

  factory Promocion.fromJson(Map<String, dynamic> json) => Promocion(
        idPromo: json["idPromo"],
        nombre: json["nombre"],
        precio: json["precio"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        nota: json["nota"],
        idMenus: json["idMenus"],
        descuento: json["descuento"],
        cantidad: json["cantidad"],
        subtotal: json["subtotal"],
      );

  Map<String, dynamic> toJson() => {
        "idPromo": idPromo,
        "nombre": nombre,
        "precio": precio,
        "descripcion": descripcion,
        "imagen": imagen,
        "nota": nota,
        "idMenus": idMenus,
        "descuento": descuento,
        "cantidad": cantidad,
        "subtotal": subtotal,
      };
}
