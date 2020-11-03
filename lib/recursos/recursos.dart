


import 'package:flutter/cupertino.dart';
import 'package:sweetalert/sweetalert.dart';

class Recursos {


  Color colorPrimario = Color.fromRGBO(80, 47, 4, 1);
  Color colorSecundario = Color.fromRGBO(255, 175, 13, 1);
  Color colorTerciario = Color.fromRGBO(151, 89, 38, 1);




  showMessageSuccess(BuildContext context, String titulo, Function callback, [String subtitulo]) {
    SweetAlert.show(
      context,
      title: titulo,
      subtitle: subtitulo,
      style: SweetAlertStyle.success,
      onPress: (confirmar) {
        if(confirmar) {
          callback();
          return true;
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


  showMessageConfirmar(BuildContext context, Function callback, [String titulo, String subtitulo]) {
    SweetAlert.show(
      context,
      title: titulo,
      subtitle: subtitulo,
      style: SweetAlertStyle.confirm,
      showCancelButton: true,
      cancelButtonText: 'No',
      confirmButtonText: 'Si',
      onPress: (confirmar) {
        if(confirmar) {
          callback();
        }
        else {
          return true;
        }
        return false; //Mantener el Dialog
      }
    );
  }




}