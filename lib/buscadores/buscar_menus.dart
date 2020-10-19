


import 'package:flutter/material.dart';

class BuscarMenus extends SearchDelegate {

  @override
  String get searchFieldLabel => 'Buscando Menus...';


  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          Navigator.pop(context);
        },
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      return Container();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}