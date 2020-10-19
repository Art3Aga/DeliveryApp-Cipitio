import 'dart:convert';

Menu menuFromJson(String str) => Menu.fromJson(json.decode(str));

String menuToJson(Menu data) => json.encode(data.toJson());

class Menu {
    Menu({
        this.idMenu,
        this.nombre,
        this.descripcion,
        this.precio,
        this.imagen,
    });
    String uniqueID;
    int idMenu;
    String nombre;
    String descripcion;
    double precio;
    String imagen;

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        idMenu: json["id_menu"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: json["precio"].toDouble(),
        imagen: json["imagen"],
    );

    Map<String, dynamic> toJson() => {
        "id_menu": idMenu,
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
        "imagen": imagen,
    };
}