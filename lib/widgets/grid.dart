import 'package:deliveryapplicacion/modelos/promo_model.dart';
import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  final List<Promocion> promos;
  final int columns;
  Grid({@required this.promos, this.columns});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        children: getRows(context),
      ),
    );
  }

  List<TableRow> getRows(BuildContext context) {
    final List<TableRow> rows = new List<TableRow>();
    Size size = MediaQuery.of(context).size;
    int nrows = (promos.length) ~/ columns;
    int mod = (promos.length) % columns;
    int index = 0;
    if (mod > 0) {
      nrows = nrows + 1;
    }
    int rest = columns - mod;
    for (int l = 0; l < rest; l++) {
      promos.add(new Promocion());
    }
    for (int i = 1; i <= nrows; i++) {
      final List<Widget> itemsPerRow = new List<Widget>();
      for (int j = 1; j <= columns; j++) {
        if (promos[index].menu.imagen != null) {
          itemsPerRow.add(_item(promos[index], context, size));
        } else {
          itemsPerRow.add(Container());
        }

        index = index + 1;
      }
      rows.add(_row(itemsPerRow));
    }
    return rows;
  }

  Widget _item(Promocion promocion, BuildContext context, Size size) {
    final card = Container(
      child: Column(
        children: [
          FadeInImage(
            height: 80.0,
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(promocion.menu.imagen),
            fit: BoxFit.fill,
          ),
          Container(
              padding: EdgeInsets.all(25.0),
              child: Text(
                promocion.menu.nombre,
                style: TextStyle(
                  color: Recursos().colorPrimario,
                ),
              ))
        ],
      ),
    );
    if (promocion.menu == null) {
      return Container();
    } else {
      return Container(
        height: 150.0,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Recursos().colorTerciario,
                  blurRadius: 3.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.0, 0.5))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'menu_detalle',
                  arguments: promocion.menu);
            },
            child: card,
          ),
        ),
      );
    }
  }

  TableRow _row(List<Widget> itemsPerRow) {
    return TableRow(children: itemsPerRow);
  }
}
