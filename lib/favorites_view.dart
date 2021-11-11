import 'package:flutter/material.dart';

void main() {
  runApp(FavoritesPage());
}

class FavoritesPage extends StatefulWidget {

  @override
  _FavoritesPageState createState() => _FavoritesPageState();

}

class _FavoritesPageState extends State<FavoritesPage> {

  List names = [
    ["Office Miraflores", "fake street 123", 40],
    ["Office San Isidro", "fake street 564", 150],
    ["Office Monterrico", "fake street 276", 79],
  ];

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index){
                return Card(
                    child: ListTile(
                      onTap: (){},
                      title: Text(names[index][0],
                        style: const TextStyle(
                            fontSize: 20
                        ),),
                      subtitle: Text(
                        "\$ " + names[index][2].toString(),
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                        ),),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite),
                        color: Colors.redAccent,
                        onPressed: () {  },
                      ),
                    )
                );
              },
            ),)
      ),
    );
  }
}
