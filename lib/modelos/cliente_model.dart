import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
    Cliente({
        this.idCliente,
        this.nombre,
        this.telefono,
        this.clave,
        this.email,
    });

    int idCliente;
    String nombre;
    String telefono;
    String clave;
    String email;

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        idCliente: json["id_cliente"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        clave: json["clave"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id_cliente": idCliente,
        "nombre": nombre,
        "telefono": telefono,
        "clave": clave,
        "email": email,
    };
}