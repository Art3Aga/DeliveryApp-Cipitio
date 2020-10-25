import 'package:deliveryapplicacion/modelos/menu_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Menu> menus;

  CardSwiper({@required this.menus});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.45,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          menus[index].uniqueID = "${menus[index].idMenu}-menu";
          return Hero(
            tag: Text(menus[index].uniqueID),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'menu_detalle',
                      arguments: menus[index]);
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _imgMenu(menus[index], context),
                    _tituloMenu(size, menus[index]),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: menus.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.75,
        //pagination: SwiperPagination(),
        //control: SwiperControl(),
        //autoplay: true,
      ),
    );
  }

  Widget _imgMenu(Menu menu, BuildContext context) {
    return FadeInImage(
        fit: BoxFit.cover,
        placeholder: AssetImage('assets/no-image.jpg'),
        image: NetworkImage(menu.imagen));
  }

  Widget _tituloMenu(Size size, Menu menu) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: size.width,
        color: Colors.white70,
        height: size.height * 0.1,
        child: Center(
          child: Text(
            menu.nombre,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
