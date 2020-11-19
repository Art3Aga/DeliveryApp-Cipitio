import 'dart:convert';


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
Promocion promocionFromJson(String str) => Promocion.fromJson(json.decode(str));

String promocionToJson(Promocion data) => json.encode(data.toJson());

class Promocion {
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

    Map<String, dynamic> toJson() => {
        "idPromo": idPromo,
        "menus": List<dynamic>.from(menus.map((x) => x)),
        "titulo": titulo,
        "tipo": tipo,
        "descripcion": descripcion,
        "precio": precio,
        "descuento": descuento,
        "imagen": imagen,
    };
}
