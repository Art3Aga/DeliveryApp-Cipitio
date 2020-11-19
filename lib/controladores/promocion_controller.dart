import 'package:deliveryapplicacion/modelos/promo_model.dart';
import 'package:deliveryapplicacion/modelos/promo_model.dart';
import 'package:deliveryapplicacion/servicios/crud_service.dart';

class PromocionController{
   final _crud = new Crud();


  Future<List<Promocion>> getPromos() async {
    final data = await this._crud.getPromos();
    final menus = new Promos.fromJsonList(data['promo']);
    //print(data['menus']);
    return menus.items;
  }
}