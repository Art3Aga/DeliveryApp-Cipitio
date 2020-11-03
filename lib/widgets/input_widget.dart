



import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool readOnly;
  final Function onTap;
  final TextCapitalization textCapitalization;

  const Input({
    Key key, 
    @required this.icon, 
    @required this.placeholder, 
    @required this.textController, 
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    this.textCapitalization = TextCapitalization.sentences
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Recursos().colorPrimario.withOpacity(0.2), offset: Offset(0,5)),
        ]
      ),
      child: TextFormField(
        autocorrect: false,
        textCapitalization: this.textCapitalization,
        keyboardType: this.keyboardType,
        obscureText: this.isPassword,
        controller: this.textController,
        readOnly: this.readOnly,
        onTap: this.onTap,
        decoration: InputDecoration(
          prefixIcon: Icon(this.icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeholder,
        ),
      ),
    );
  }
}