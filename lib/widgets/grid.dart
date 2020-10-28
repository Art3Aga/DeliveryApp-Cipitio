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
        if (promos[index].imagen != null) {
          itemsPerRow.add(_item(promos[index], context));
        } else {
          itemsPerRow.add(Container());
        }

        index = index + 1;
      }
      rows.add(_row(itemsPerRow));
    }
    return rows;
  }

  Widget _item(Promocion promocion, BuildContext context) {
    final card = Container(
      child: Column(
        children: [
          FadeInImage(
            height: 80.0,
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(promocion.imagen),
            fit: BoxFit.fill,
          ),
          Container(
              padding: EdgeInsets.all(25.0),
              child: Text(
                promocion.nombrePromo,
                style: TextStyle(
                  color: Recursos().colorPrimario,
                ),
              ))
        ],
      ),
    );
    if (promocion.imagen == null) {
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
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                  offset: Offset(2.0, 10.0))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'promo_detalle',
                  arguments: promocion);
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
