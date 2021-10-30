import 'package:flutter/material.dart';
import 'office_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: OfficeDetail()
    );
  }
}
