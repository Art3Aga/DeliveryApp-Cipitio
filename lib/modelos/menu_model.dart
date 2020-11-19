import 'dart:convert';

class Menus {

  List<Menu> items = new List();

  Menus();

  Menus.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final direccion = new Menu.fromJson(item);
      items.add( direccion );
    }

  }

}

Menu menuFromJson(String str) => Menu.fromJson(json.decode(str));

String menuToJson(Menu data) => json.encode(data.toJson());

class Menu {
    Menu({
        this.idMenu,
        this.nombre,
        this.descripcion,
        this.precio,
        this.imagen,
        this.nota = '',
        this.cantidad = 0,
        this.subtotal = 0
    });
    String idMenu;
    String nombre;
    String descripcion;
    double precio;
    String imagen;
    String nota;
    int cantidad;
    double subtotal;

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        idMenu: json["id_menu"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: json["precio"].toDouble(),
        imagen: json["imagen"],
        nota: json["nota"],
        cantidad: json["cantidad"],
        subtotal: json["subtotal"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id_menu": idMenu,
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
        "imagen": imagen,
        "nota": nota,
        "cantidad": cantidad,
        "subtotal": subtotal
    };
}