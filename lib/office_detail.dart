import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OfficeDetail extends StatelessWidget {

  final office;
  final username;

  OfficeDetail(this.office, this.username);

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          title:  Text("Información de la oficina",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.indigo,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child:  Text(office["name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: Image.network(office["image"],
                  fit: BoxFit.cover),


              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child:  Text(office["description"],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: Text("Direccion: ${office["address"]}",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child:  Text("Aforo: ${office["capacity"]} personas",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child:  Text("Precio: S/.${office["price"]}0 ",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),

            Container(
              child: const Text("Calificacion: ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: RatingBar.builder(
                initialRating: office["score"],
                minRating: 0.5,
                itemCount: 5,
                allowHalfRating: true,
                itemSize: 20,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              alignment: Alignment.center,
            ),
            Container(
              child: MaterialButton(
                  color: Colors.tealAccent,
                  child: const Text("Reservar",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),),
                  onPressed: (){

                  }),
              margin: EdgeInsets.all(10.0),
            ),
            TextButton.icon(
                icon: Icon(Icons.favorite),
                label: const Text("Agregar a favoritos",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),),
                onPressed: (){}),
          ],
        ),
      );

  }

}