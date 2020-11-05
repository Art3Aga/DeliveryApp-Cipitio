import 'dart:convert';

Promocion promoFromJson(String str) => Promocion.fromJson(json.decode(str));

String promoToJson(Promocion data) => json.encode(data.toJson());

class Promocion {
  Promocion({
    this.idPromo,
    this.nombrePromo,
    this.descripcionPromo,
    this.precio,
    this.imagen,
  });

  String idPromo;
  String nombrePromo;
  String descripcionPromo;
  double precio;
  String imagen;

  factory Promocion.fromJson(Map<String, dynamic> json) => Promocion(
        idPromo: json["idPromo"],
        nombrePromo: json["nombrePromo"],
        descripcionPromo: json["descripcionPromo"],
        precio: json["precio"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "idPromo": idPromo,
        "nombrePromo": nombrePromo,
        "descripcionPromo": descripcionPromo,
        "precio": precio,
        "imagen": imagen,
      };
}
