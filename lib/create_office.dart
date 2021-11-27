
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateOfficePage extends StatefulWidget {
  const CreateOfficePage({Key? key}) : super(key: key);

  @override
  _CreateOfficePageState createState() => _CreateOfficePageState();
}

class _CreateOfficePageState extends State<CreateOfficePage> {

  File? sampleImage;

  late String _nameOfficeValue;
  late String _descriptionOfficeValue;
  late String _addressOfficeValue;
  late String _capacityOfficeValue;
  late double _priceOfficeValue;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creación de Oficina"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Imagen de la oficina"),
                    SizedBox(width: 80,),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:  MaterialStateProperty.all<Color>(Colors.indigo)
                        ),
                        onPressed: (){
                          getImage();
                        },
                        child: Text("Subir imagen"))
                  ],
                ),
                SizedBox(height: 50,),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        sampleImage == null ? Text("Selecciona una imagen")
                            : enableUpload(),
                        SizedBox(height: 30.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Nombre"
                          ),
                          validator: (value){
                            return value!.isEmpty ? "Nombre es requerido":null;
                          },
                          onSaved: (value){
                            setState(() {
                              _nameOfficeValue = value!;
                            });
                          },
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Descripción"
                          ),
                          validator: (value){
                            return value!.isEmpty ? "Descripción es requerida":null;
                          },
                          onSaved: (value){
                            setState(() {
                              _descriptionOfficeValue = value!;
                            });
                          },
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Dirección"
                          ),
                          validator: (value){
                            return value!.isEmpty ? "Dirección es requerida":null;
                          },
                          onSaved: (value){
                            setState(() {
                              _addressOfficeValue = value!;
                            });
                          },
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Aforo"
                          ),
                          validator: (value){
                            return value!.isEmpty ? "Aforo es requerido":null;
                          },
                          onSaved: (value){
                            setState(() {
                              _capacityOfficeValue = value!;
                            });
                          },
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Precio"
                          ),
                            keyboardType: TextInputType.number,
                          validator: (value){
                            return value!.isEmpty ? "Precio es requerido":null;
                          },
                          onSaved: (value){
                            setState(() {
                              final doubleNumber = double.tryParse(value!);
                                _priceOfficeValue = doubleNumber!;
                            });
                          },
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                        ),
                        SizedBox(height: 15.0),
                        ElevatedButton(
                          child: Text("Crear Oficina"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.tealAccent)
                          ),
                          onPressed: (){
                            validateAndSave();
                          },
                        )
                      ],
                    )),

              ],
            ),
          )

        ),
      )
    );
  }

  bool validateAndSave(){
    final form= formKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future getImage() async {
    var tempImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
    var imageFile = File(tempImage!.path);
    setState(() {
      sampleImage = imageFile;
    });
  }

  Widget enableUpload(){
    return Image.file(
      sampleImage!,
      height: 300.0,
      width: 600.0,
    );
  }
}
