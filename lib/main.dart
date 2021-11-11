import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offirent/public_offices/public_offices.dart';
import 'package:flutter_offirent/route_generator.dart';

import 'package:flutter_offirent/profile_config_view.dart';

import 'office.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/public_offices',
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}


