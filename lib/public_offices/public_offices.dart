
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PublicOffices extends StatefulWidget {

  @override
  _PublicOfficesState createState() => _PublicOfficesState();
}

class _PublicOfficesState extends State<PublicOffices> {


  String url = "https://api-e404.herokuapp.com/api/offices";

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


  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {

    List<Card> _buildGridCards() {
      List<Card> cards = List.generate(data.length,
            (int i) => Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.network(data[i]["image"]),
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
      );
      return cards;
    }




    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              print('Menu button');   // solo para pinter en consola
            },
            icon: const Icon(
              Icons.menu,
              //semanticLabel: 'menu',
            )
        ),
        title: Text("Oficinas"),
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
      body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0, // width over height

          children: _buildGridCards()
      ),
    );
  }
}