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
        if (promos[index].imagen != null) {
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
    String nombrePromo = promocion.titulo;
    if (nombrePromo.length >= 25) {
      nombrePromo = nombrePromo.substring(0, 23) + ' ...';
    }

    final card = Container(
      child: Column(
        children: [
          FadeInImage(
            height: size.height * 0.12,
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(promocion.imagen),
            fit: BoxFit.fill,
          ),
          Container(
            padding: EdgeInsets.all(size.height * 0.007),
            child: Column(
              children: [
                Text(
                  nombrePromo,
                  style: TextStyle(
                    color: Recursos().colorPrimario,
                  ),
                ),
                Text(
                  '\$ ${promocion.precio.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Recursos().colorPrimario,decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.red,
                    decorationThickness: 2.0,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  '\$ ${(promocion.precio -  promocion.descuento).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Recursos().colorPrimario,
                    
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    if (promocion == null) {
      return Container();
    } else {
      return Container(
        height: size.height * 0.24,
        margin: EdgeInsets.all(size.height * 0.009),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.height * 0.009),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Recursos().colorTerciario,
                  blurRadius: 3.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.0, 0.5))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size.height * 0.009),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'promocion_detalle',
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
