import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OfficeDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Información de la oficina",
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.tealAccent,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child: const Text("OFICINA",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: Image.network("https://cdn.pixabay.com/photo/2015/05/15/14/22/conference-room-768441_960_720.jpg",
                  fit: BoxFit.cover),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: const Text("Correo: offi@hotmail.com",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: const Text("Telefono: +51 985 265 412",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: MaterialButton(
                  color: Colors.tealAccent,
                  child: const Text("Alquilar local S/.390",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),),
                  onPressed: (){}),
              margin: EdgeInsets.all(10.0),
            ),
            TextButton.icon(
                icon: Icon(Icons.favorite),
                label: const Text("Agregar a favoritos",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),),
                onPressed: (){}),
            Container(
              child: const Text("Reseña",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 23.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: RatingBar.builder(
                initialRating: 3,
                minRating: 0.5,
                itemCount: 5,
                allowHalfRating: true,
                itemSize: 30,
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
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Escribe una reseña",
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              width: 50,
              child: TextButton(
                  child: const Text("Publicar reseña",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),),
                  onPressed: (){}),
              margin: EdgeInsets.all(10.0),
            ),
          ],
        ),
      ),
    );
  }
}