import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_offirent/public_offices/public_offices.dart';
import 'package:flutter_offirent/route_generator.dart';
import 'create_reservation.dart';


import 'package:flutter_offirent/profile_config_view.dart';

import 'office.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', 'US'),
    ],
    initialRoute: '/login',
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}




