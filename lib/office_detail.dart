
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'db/favorites_database.dart';
import 'model/office.dart';

class OfficeDetail extends StatefulWidget {

  final office;
  final username;

  OfficeDetail(this.office, this.username);

  @override
  State<OfficeDetail> createState() => _OfficeDetailState();
}

class _OfficeDetailState extends State<OfficeDetail> {


  createFavoriteConfirmDialog() {
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Oficina guardada"),
        content: Text("La oficina se guardó con éxito en la sección de Favoritos"),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("Ok")
          ),
          TextButton(
              onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil("/my_reservations",
                    ModalRoute.withName("/favorite_offices"));
              },
              child: Text("Ver Oficina"))
        ],
      );
    });
  }

  createFavoriteErrormDialog() {
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Oficina ya existente!!!"),
        content: Text("La oficina ya está guardada en la vista de Mis Favoritos"),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("Ok"))
        ],
      );
    });
  }


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
              child:  Text(widget.office["name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: Image.network(widget.office["image"],
                  fit: BoxFit.cover),


              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child:  Text(widget.office["description"],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: Text("Direccion: ${widget.office["address"]}",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child:  Text("Aforo: ${widget.office["capacity"]} personas",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child:  Text("Precio: S/.${widget.office["price"]}0 ",
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
                initialRating: widget.office["score"],
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
                    Navigator.of(context).pushNamed('/create_reservation',
                    arguments: widget.office["id"]);
                  }),
              margin: EdgeInsets.all(10.0),
            ),
            TextButton.icon(
                icon: Icon(Icons.favorite),
                label: const Text("Agregar a favoritos",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),),
                onPressed: () => saveFavorite()
            )
          ],
        ),
      );

  }

  saveFavorite() async {
    if( await DatabaseHelper.instance.exist(widget.office["name"]) == true){
      createFavoriteErrormDialog();
    }
    else {
      await DatabaseHelper.instance.add(
          Office(widget.office["id"],
            widget.office["address"],
            widget.office["name"],
            widget.office["image"],
            widget.office["floor"],
            widget.office["capacity"],
            widget.office["allowResource"],
            widget.office["score"],
            widget.office["description"],
            widget.office["price"],
            widget.office["status"],
            widget.office["comment"],)
      );
      createFavoriteConfirmDialog();
      print("Favorite with id ${widget.office["id"]} saved");
    }

  }



}