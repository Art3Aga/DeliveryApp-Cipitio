


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


  showMessageConfirmar(BuildContext context, Function callback, [String titulo, String subtitulo, String cancelText = 'No', String confirmText = 'Si']) {
    SweetAlert.show(
      context,
      title: titulo,
      subtitle: subtitulo,
      style: SweetAlertStyle.confirm,
      showCancelButton: true,
      cancelButtonText: cancelText,
      confirmButtonText: confirmText,
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


  showMessageConfirmarDireccion(BuildContext context, String titulo, String subtitulo, String cancelText, String confirmText, Function callbackContinuar) {
    SweetAlert.show(
      context,
      title: titulo,
      subtitle: subtitulo,
      style: SweetAlertStyle.confirm,
      showCancelButton: true,
      cancelButtonText: cancelText,
      confirmButtonText: confirmText,
      onPress: (confirmar) {
        if(confirmar) {
          callbackContinuar();
        }
        else {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed('administrar_direccion');
        }
        return false;
      }
    );
  }




}