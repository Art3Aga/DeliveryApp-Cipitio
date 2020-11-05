


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

class Recursos {


  Color colorPrimario = Color.fromRGBO(80, 47, 4, 1);
  Color colorSecundario = Color.fromRGBO(255, 175, 13, 1);
  Color colorTerciario = Color.fromRGBO(151, 89, 38, 1);




  showMessageSuccess(BuildContext context, String titulo, Function callback, [String subtitulo, bool returnTrue = false]) {
    SweetAlert.show(
      context,
      title: titulo,
      subtitle: subtitulo,
      style: SweetAlertStyle.success,
      onPress: (confirmar) {
        if(confirmar) {
          callback();
          return returnTrue ? true : false;
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


  mostrarDialog(Widget widget, BuildContext context, double width, double height) {
    final dialog = Dialog(
      child: Container(width: width, height: height, child: widget),
      insetAnimationCurve: Curves.easeIn,
      insetAnimationDuration: Duration(milliseconds: 500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );
    showDialog(context: context, builder: (_) => dialog);
  }




}