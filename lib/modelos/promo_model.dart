import 'dart:convert';

import 'menu_model.dart';

Promocion promocionFromJson(String str) => Promocion.fromJson(json.decode(str));

String promocionToJson(Promocion data) => json.encode(data.toJson());

class Promocion {
  Promocion({
    this.idPromo,
    this.menu,
  });

  int idPromo;
  Menu menu;

  factory Promocion.fromJson(Map<String, dynamic> json) => Promocion(
        idPromo: json["idPromo"],
        menu: Menu.fromJson(json["menu"]),
      );

  Map<String, dynamic> toJson() => {
        "idPromo": idPromo,
        "menu": menu.toJson(),
      };
}
