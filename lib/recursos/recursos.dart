


import 'package:flutter/cupertino.dart';
import 'package:sweetalert/sweetalert.dart';

class Recursos {


  Color colorPrimario = Color.fromRGBO(80, 47, 4, 1);
  Color colorSecundario = Color.fromRGBO(255, 175, 13, 1);
  Color colorTerciario = Color.fromRGBO(151, 89, 38, 1);




  showMessageSuccess(BuildContext context, String titulo, Function callback) {
    SweetAlert.show(
      context,
      title: titulo,
      style: SweetAlertStyle.success,
      onPress: (confirmar) {
        if(confirmar) {
          callback();
        }
        return false; //Mantener el Dialog
      }
    );
  }

  showMessageError(BuildContext context, String titulo) {
    SweetAlert.show(
      context,
      title: titulo,
      style: SweetAlertStyle.error
    );
  }




}