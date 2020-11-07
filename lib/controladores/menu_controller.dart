import 'package:deliveryapplicacion/modelos/menu_model.dart';
import 'package:deliveryapplicacion/servicios/crud_service.dart';

class MenuController {


  final _crud = new Crud();


  Future<List<Menu>> getMenus() async {
    final data = await this._crud.getMenus();
    final menus = new Menus.fromJsonList(data['menus']);
    return menus.items;
  }


  
}
