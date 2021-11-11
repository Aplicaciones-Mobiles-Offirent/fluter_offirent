import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_offirent/model/office.dart';
import 'favorites_view.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(OfficePage());
}

class OfficePage extends StatefulWidget {

  @override
  _OfficePageState createState() => _OfficePageState();

}


class _OfficePageState extends State<OfficePage> {

  Future getOfficeData() async {
    var response =
        await http.get(Uri.http('api-mobil.herokuapp.com/api/', 'offices'));
    var jsonData = jsonDecode(response.body);
    List<Office> offices = [];

    for (var ele in jsonData){
      Office office = Office(ele["id"],
          ele["address"],
          ele["floor"],
          ele["capacity"],
          ele["allowResource"],
          ele["score"],
          ele["description"],
          ele["price"],
          ele["status"],
          ele["comment"]);
      offices.add(office);
    }
    print(offices.length);
    return offices;
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
              child: FutureBuilder(
                future: getOfficeData(),
                builder: (context, AsyncSnapshot snapshot){
                  if (snapshot.data == null){
                    return const Center(
                      child: Text(
                      "No offices found :(",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      )
                      ));
                  }
                  else {
                    return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index){
                      return Card(
                          child: ListTile(
                            onTap: (){},
                            title: Text(snapshot.data[index][1],
                              style: const TextStyle(
                                  fontSize: 20
                              ),),
                            subtitle: Text(
                              "\$ " + snapshot.data[index][5].toString(),
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold
                              ),),
                            trailing: IconButton(
                              icon: const Icon(Icons.favorite),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => FavoritesPage()));
                              },
                            ),
                          )
                      );
                    }
                  );
                  }
                },
              ),)
        ),
    );
    }
}