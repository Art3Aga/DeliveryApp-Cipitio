import 'dart:convert';

Pedido pedidoFromJson(String str) => Pedido.fromJson(json.decode(str));

String pedidoToJson(Pedido data) => json.encode(data.toJson());

class Pedido {
    Pedido({
        this.idPedido,
        this.idCliente,
        this.idMenuPromo, // o id menu o de la promocion ya que el cliente puede pedir un menu o promocion
        this.nombre,
        this.descripcion,
        this.precio,
        this.imagen,
        this.cantidad,
        this.subtotal,
    });

    String idPedido;
    String idCliente;
    String idMenuPromo;
    String nombre;
    String descripcion;
    double precio;
    String imagen;
    int cantidad;
    double subtotal;

    factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        idPedido: json["id_pedido"],
        idCliente: json["id_cliente"],
        idMenuPromo: json["id_menu_promo"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        imagen: json["imagen"],
        cantidad: json["cantidad"],
        subtotal: json["subtotal"],
    );

    Map<String, dynamic> toJson() => {
        "id_pedido": idPedido,
        "id_cliente": idCliente,
        "id_menu_promo": idMenuPromo,
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
        "imagen": imagen,
        "cantidad": cantidad,
        "subtotal": subtotal,
    };
}