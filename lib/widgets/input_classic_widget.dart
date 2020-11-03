



import 'package:deliveryapplicacion/recursos/recursos.dart';
import 'package:flutter/material.dart';

class InputClassic extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool readOnly;
  final Function onTap;

  const InputClassic({
    Key key, 
    @required this.icon, 
    @required this.placeholder, 
    @required this.textController, 
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.05),
      child: Theme(
        data: Theme.of(context).copyWith(primaryColor: Recursos().colorPrimario),
        child: TextFormField(
          autocorrect: false,
          keyboardType: this.keyboardType,
          obscureText: this.isPassword,
          controller: this.textController,
          readOnly: this.readOnly,
          onTap: this.onTap,
          decoration: InputDecoration(
            hintText: this.placeholder,
            suffixIcon: Icon(this.icon),
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Recursos().colorPrimario, width: 2),
              borderRadius: BorderRadius.circular(15)
            ),
          ),
        ),
      ),
    );
  }
}