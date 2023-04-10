import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/adduser_screen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case '/add_user' :
        return MaterialPageRoute(builder: (_) => AddUserScreen());
      default :
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title:const Text('No Route'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Sorry no Route found',style: TextStyle(color: Colors.red,fontSize: 18),),
        ),
      );
    });
  }
}