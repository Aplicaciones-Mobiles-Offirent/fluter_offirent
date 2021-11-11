import 'package:flutter/material.dart';
import 'package:flutter_offirent/login.dart';
import 'package:flutter_offirent/my_reservations.dart';
import 'package:flutter_offirent/office.dart';
import 'package:flutter_offirent/office_detail.dart';
import 'package:flutter_offirent/profile_config_view.dart';
import 'package:flutter_offirent/provider_offices.dart';
//import 'package:flutter_offirent/main.dart';
import 'package:flutter_offirent/public_offices/public_offices.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch(settings.name) {

      //case '/':
        //return MaterialPageRoute(builder: (_) => FirstPage());
      case '/public_offices':
        return MaterialPageRoute(builder: (_) => PublicOffices());

      case '/profile_config_view':
        return MaterialPageRoute(builder: (_) => ProfileConfigPage());

      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case '/office_page':
        return MaterialPageRoute(builder: (_) => OfficePage());

      case '/office_detail':
        return MaterialPageRoute(builder: (_) => OfficeDetail());

      case '/provider_offices':
        return MaterialPageRoute(builder: (_) => ProviderOffices());

      case '/my_reservations':
        return MaterialPageRoute(builder: (_) => MyReservations());
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