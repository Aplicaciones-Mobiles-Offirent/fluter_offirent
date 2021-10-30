import 'package:flutter/material.dart';
//import 'package:flutter_offirent/main.dart';
import 'package:flutter_offirent/public_offices/public_offices.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch(settings.name) {

      //case '/':
        //return MaterialPageRoute(builder: (_) => FirstPage());
      case '/public offices':
        return MaterialPageRoute(builder: (_) => PublicOffices());

      default:
        return _errorRoute();
    }

  }


  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}