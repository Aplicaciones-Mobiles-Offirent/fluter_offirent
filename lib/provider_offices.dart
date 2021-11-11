import 'package:flutter/material.dart';
import 'package:flutter_offirent/http_helper.dart';
import 'package:flutter_offirent/widgets/drawer_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


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
  late String emailProvider ="flavio.s.m@gmail.com";

  Icon visibleIcon = Icon(Icons.search);

  Future initialize(emailProvider) async {
    myOffices = await helper.getMyOffices(emailProvider);
    setState(() {
      myOfficesCount = myOffices.length;
      myOffices = myOffices;
    });
  }



  @override
  void initState() {
    helper = HttpHelper();
    initialize(emailProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Oficinas"),
      ),
      drawer: DrawerWidget(),
      body: ListView.builder(
          itemCount: (this.myOfficesCount == null) ? 0: this.myOfficesCount,
          itemBuilder: (BuildContext context, int position) {
            if(myOfficesCount == null) {
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
                  subtitle: Text('Score:'+ myOffices[position].score + ' - Price: S/.' +myOffices[position].price.toString()),
                ),
              );
            }
           }
          ),
    );
  }
}
