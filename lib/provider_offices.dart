// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_offirent/http_helper.dart';
import 'package:flutter_offirent/provider_create_offices.dart';
import 'package:flutter_offirent/widgets/drawer_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProviderOffices extends StatefulWidget {
  const ProviderOffices({Key? key}) : super(key: key);

  @override
  _ProviderOfficesState createState() => _ProviderOfficesState();
}

class _ProviderOfficesState extends State<ProviderOffices> {
  late String result;
  late HttpHelper helper;
  int myOfficesCount = 0;
  late List myOffices;
  String emailProvider = "";

  Icon visibleIcon = Icon(Icons.search);

  Future initialize() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    emailProvider = userPrefs.getString("email")!;
    myOffices = await helper.getMyOffices(emailProvider);
    print(emailProvider);
    setState(() {
      emailProvider = emailProvider;
      myOfficesCount = myOffices.length;
      myOffices = myOffices;
    });
  }

  void getCred() async {
    //funcion como modelo, si se quita no hay diferencia
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      emailProvider = userPrefs.getString("email")!;
    });
  }

  @override
  void initState() {
    getCred();
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProviderCreateOffices()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      appBar: AppBar(
        title: Text("Mis Oficinas"),
        backgroundColor: Colors.indigo,
      ),
      drawer: DrawerWidget(
        user: emailProvider,
      ),
      body: ListView.builder(
          itemCount: (this.myOfficesCount == null) ? 0 : this.myOfficesCount,
          itemBuilder: (BuildContext context, int position) {
            if (myOfficesCount == null) {
              return Card(
                color: Colors.white,
                elevation: 4.0,
                child: ListTile(
                  onTap: () {},
                  leading: CircleAvatar(),
                  title: Text("No posees ninguna oficina"),
                ),
              );
            } else {
              return Card(
                color: Colors.white,
                elevation: 4.0,
                child: ListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(myOffices[position].image),
                  ),
                  title: Text(myOffices[position].name),
                  subtitle: Text('Score:' +
                      myOffices[position].score.toString() +
                      ' - Precio: S/.' +
                      myOffices[position].price.toString() +
                      '0'),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[Icon(Icons.create_sharp)]),
                ),
              );
            }
          }),
    );
  }
}
