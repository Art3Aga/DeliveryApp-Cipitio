import 'dart:convert';

<<<<<<< HEAD
=======

class Promos {

  List<Promocion> items = new List();

  Promos();

  Promos.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final direccion = new Promocion.fromJson(item);
      items.add( direccion );
    }

  }

}
>>>>>>> 564f85d9a41b4a6a1be2bbf7930d16cee046afe8
Promocion promocionFromJson(String str) => Promocion.fromJson(json.decode(str));

String promocionToJson(Promocion data) => json.encode(data.toJson());

class Promocion {
<<<<<<< HEAD
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
=======
    Promocion({
        this.idPromo,
        this.menus,
        this.titulo,
        this.tipo,
        this.descripcion,
        this.precio,
        this.descuento,
        this.imagen,
    });

    String idPromo;
    List<dynamic> menus;
    String titulo;
    String tipo;
    String descripcion;
    double precio;
    double descuento;
    String imagen;

    factory Promocion.fromJson(Map<String, dynamic> json) => Promocion(
        idPromo: json["id_promo"],
        menus: List<dynamic>.from(json["menus"].map((x) => x)),
        titulo: json["titulo"],
        tipo: json["tipo"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        descuento: json["descuento"],
        imagen: json["imagen"],
    );
>>>>>>> 564f85d9a41b4a6a1be2bbf7930d16cee046afe8

    Map<String, dynamic> toJson() => {
        "idPromo": idPromo,
<<<<<<< HEAD
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
=======
        "menus": List<dynamic>.from(menus.map((x) => x)),
        "titulo": titulo,
        "tipo": tipo,
        "descripcion": descripcion,
        "precio": precio,
        "descuento": descuento,
        "imagen": imagen,
    };
>>>>>>> 564f85d9a41b4a6a1be2bbf7930d16cee046afe8
}
