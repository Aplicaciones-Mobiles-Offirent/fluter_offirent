
import 'package:flutter/material.dart';
import 'package:flutter_offirent/widgets/drawer_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PublicOffices extends StatefulWidget {

  @override
  _PublicOfficesState createState() => _PublicOfficesState();
}

class _PublicOfficesState extends State<PublicOffices> {


  String url = "https://api-e404.herokuapp.com/api/offices";
  String username = "";


  List data = [];

  Future<String> makeRequest() async{
    var response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json'});

    setState(() {
      var extractdata = json.decode(response.body);      // propio del convert
      data = extractdata;
    });

    print('Name: ' + data[0]["name"]);           //para ver en consola // lo del name y first son atributos propios del api
    print('Address: ' + data[0]["address"]+1.toString());
    print('Floor: ' + data[0]["floor"].toString());
    return response.body;
  }

  void getCred() async {
    SharedPreferences userPrefs = await SharedPreferences.getInstance();
    setState(() {
      username = userPrefs.getString("email")!;
      username = username;
    });

  }

  @override
  void initState() {
    super.initState();
    makeRequest();
    getCred();
  }

  @override
  Widget build(BuildContext context) {

    List<InkWell> _buildGridCards() {
      List<InkWell> cards = List.generate(data.length,
            (int i) => InkWell(
              child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 18.0 / 11.0,
                  child: FadeInImage(
                      placeholder: AssetImage('lib/assets/loading.gif'),
                      image: NetworkImage(data[i]["image"]))
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(data[i]["name"]),
                      SizedBox(height: 8),
                      Text(data[i]["price"].toString())
                    ],
                  ),
                ),
              ],
          ),
        ),
              onTap: () {
                Navigator.of(context).pushNamed('/office_detail');
              },
            ),
      );
      return cards;
    }




    return Scaffold(
      appBar: AppBar(
        /*leading: IconButton(
            onPressed: () {
              print('Menu button');   // solo para pinter en consola
            },
            icon: const Icon(
              Icons.menu,
              //semanticLabel: 'menu',
            )
        ),*/
        title: Text("Oficinas"),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
              onPressed: (){
                print('Filter Button');   // consola
              },
              icon: const Icon(
                Icons.tune,
                semanticLabel: 'filter',
              )
          )
        ],
      ),
      drawer: DrawerWidget(user: username,),
      body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0, // width over height

          children: _buildGridCards()
      ),
    );
  }
}

