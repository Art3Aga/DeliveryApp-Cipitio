import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.idUsuario,
        this.nombre,
        this.clave,
        this.telefono,
        this.rol,
        this.color,
    });

    String idUsuario;
    String nombre;
    String clave;
    String telefono;
    String rol;
    String color;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["id_usuario"],
        nombre: json["nombre"],
        clave: json["clave"],
        telefono: json["telefono"],
        rol: json["rol"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "nombre": nombre,
        "clave": clave,
        "telefono": telefono,
        "rol": rol,
        "color": color,
    };
}