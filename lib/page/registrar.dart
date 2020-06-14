import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class registrarPage extends StatelessWidget {
  registrarPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invitados"),
        backgroundColor: Colors.blue, 
      ),
      body: ListPage20(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          FutureBuilder<ConfirmAction>(
                    future: addActividadDialog(context),
                    builder: (context, snapshot){
                      print('In Builder');
                    }
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),        
      ),
    );
  }

    //---------------Dialogo Insertar Alumnos-------------------------------
 
 Future<ConfirmAction> addActividadDialog(BuildContext context) async {
  String Nombre='',Descripcion='',Marca='',Modelo='',Color='',Facultad='',Matricula='',Codi='';
  final nombre = TextEditingController(); 
  final descripcion = TextEditingController(); 
  final marca = TextEditingController();   
  final modelo = TextEditingController();  
  final matricula = TextEditingController(); 
  final color = TextEditingController(); 
  final facultad = TextEditingController();
  final _formKey = GlobalKey<FormState>();  
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return Theme(
      data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
      child: AlertDialog(
        title: Text('Registrar Invitados'),         
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,             
              child: new Form(
                key: _formKey,           
                  child: Column(     
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,         
                    children: <Widget>[          
                      TextFormField(
                        validator: (value){
                          if (value.isEmpty) {
                            return 'Nombre es Requerido';
                          }else{        
                            
                              if(value.length>4){
                                return null;
                              }else{
                                return 'Longitud de Nombre debe ser al menos de 5';
                              }                                              
                          }                                               
                        },
                        onSaved: (String val) {
                          Nombre = val;
                        },
                        controller: nombre,
                        autofocus: true,              
                        decoration: InputDecoration(      
                          icon: Icon(Icons.credit_card),          
                          labelText: 'Nombre del Alumno', hintText: 'Nombre'
                        )                                                                                       
                      ),
                      TextFormField(
                        validator: (value){
                          if (value.isEmpty) {                            
                            return 'Matricula es Requerida';
                          }else{        
                            
                              if(value.length==9){
                                return null;
                              }else{
                                return 'Longitud de Matricula debe ser igual a 9';
                              }     
                          }                                                                     
                        },
                        onSaved: (String val) {
                          Matricula = val;
                        },
                        controller: matricula,
                        autofocus: true,              
                        decoration: InputDecoration(   
                          icon: Icon(Icons.account_circle),                       
                          labelText: 'Matricula del ALumno', hintText: '201900000'
                        )                                                                                       
                      ),
                      TextFormField(
                        validator: (value){
                          if (value.isEmpty) {                            
                            return 'Facultad es Requerida';
                          }                                                                   
                        },
                        onSaved: (String val) {
                          Facultad = val;
                        },
                        controller: facultad,
                        autofocus: true,              
                        decoration: InputDecoration(   
                          icon: Icon(Icons.account_circle),                       
                          labelText: 'Facultad del Alumno', hintText: 'Facultad'
                        )                                                                                       
                      ),
                      TextFormField(
                        validator: (value){
                          if (value.isEmpty) {                            
                            return 'Marca es Requerida';
                          }                                                                    
                        },
                        onSaved: (String val) {
                          Marca = val;
                        },
                        controller: marca,
                        autofocus: true,              
                        decoration: InputDecoration(   
                          icon: Icon(Icons.account_circle),                       
                          labelText: 'Marca de la Bicicleta', hintText: 'Marca'
                        )                                                                                       
                      ),
                      TextFormField(
                        validator: (value){
                          if (value.isEmpty) {                            
                            return 'Modelo es Requerido';
                          }                                                                     
                        },
                        onSaved: (String val) {
                          Modelo = val;
                        },
                        controller: modelo,
                        autofocus: true,              
                        decoration: InputDecoration(   
                          icon: Icon(Icons.account_circle),                       
                          labelText: 'Modelo de la Bicicleta', hintText: 'Modelo'
                        )                                                                                       
                      ),
                      TextFormField(
                        validator: (value){
                          if (value.isEmpty) {                            
                            return 'Color es Requerido';
                          }                                                                    
                        },
                        onSaved: (String val) {
                          Color = val;
                        },
                        controller: color,
                        autofocus: true,              
                        decoration: InputDecoration(   
                          icon: Icon(Icons.account_circle),                       
                          labelText: 'Color de la Bicicleta', hintText: 'Color'
                        )                                                                                       
                      ),
                      TextFormField(
                        validator: (value){
                          if (value.isEmpty) {                            
                            return 'Descripcion es Requerida';
                          }                                                                     
                        },
                        onSaved: (String val) {
                          Descripcion = val;
                        },
                        controller: descripcion,
                        autofocus: true,              
                        decoration: InputDecoration(   
                          icon: Icon(Icons.account_circle),                       
                          labelText: 'Descripcion Adicional de la Bicicleta', hintText: 'Caracteristicas Adicionales'
                        )                                                                                       
                      ),
                    ]     
                  )
              ),        
            ),    
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCELAR'),
            onPressed: () {                         
              Navigator.of(context).pop(ConfirmAction.CANCEL);              
            },
          ),
          FlatButton(
            child: const Text('ACEPTAR'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                print('Form valido');
                print('◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤');
                //Si la informacion ha sido validada entonces Procedemos a insertar
                Codi=addActividad(context, Nombre, Matricula, Facultad,Marca,Modelo,Color,Descripcion);                
                Navigator.of(context).pop(ConfirmAction.ACCEPT); 
                _showDialog3(context,"Pin de Salida",Codi);  
              }else{
                print('◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤');
                print('Datos en el Form NO validos');
                print('◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤');
              }
            },
          )
        ],
      ));
    },
  );
}
//Validador
  bool isUnsignedIntegers(String str) {
      Pattern pattern = r'^[0-9]*$';
      RegExp regex = new RegExp(pattern);      
        if(regex.hasMatch(str)){        
          return true;
        }else{          
          return false;
        }                  
    }

bool isValidName(String str){
      Pattern pattern = r'^[a-zA-Z ]*$';
      RegExp regex = new RegExp(pattern);      
        if(regex.hasMatch(str)){          
          return true;
        }else{          
          return false;
        }      
    }

//Funcion que añade alumno
  String addActividad(context,String nombre,String matricula, String facultad,String marca,String modelo,String color,String descripcion){
    var rng = new Random();
    String codi=nombre.substring(0,3)+rng.nextInt(10000).toString()+facultad.substring(0,3);
      Firestore.instance.runTransaction((transaction) async {
          await transaction.set(Firestore.instance.collection('invitados').document(), {
            'nombre': nombre,
            'descripcion': descripcion,
            'matricula': matricula,
            'facultad': facultad,
            'marca': marca,
            'modelo': modelo,
            'color': color,
            'codigo': codi,
          });
        });
        return codi;
    } 

     void _showDialog3(context,String titulo, String subtitulo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(titulo),
          content: new Text(subtitulo),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class ListPage20 extends StatefulWidget {
  String idmat;
  String docid;
  ListPage20();
  @override
  _ListPageState20 createState() => _ListPageState20(this.idmat,this.docid);
}

class _ListPageState20 extends State<ListPage20> {  
  String idmat;
  String docid;
  _ListPageState20(this.idmat,this.docid);
  
  @override

  Widget build(BuildContext context) {
  print(idmat);
  return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('invitados').snapshots() ,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {          
           return Center(             
              child:  new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[       
                new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue)),                   
                Text('  Cargando...',style: TextStyle(fontWeight: FontWeight.bold) ) 
                ]));
        }
        return new ListView(children: getActividad(snapshot));        
      }
    );
  }

getActividad(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => GestureDetector(
          onHorizontalDragUpdate:(a){deleteAlumnoDialog(doc["codigo"].toString(),doc.documentID);
                  },
          child:
          new Card( child : 
          new ListTile(
            leading: FlutterLogo(),            
            //-----------------------------------------------------------
            title: Column(                
                children: <Widget>[new Text(doc["nombre"].toString()),
                new Text(doc["facultad"].toString())]),
            subtitle: Column(                
                children: <Widget>[
                  new Text(doc["marca"].toString()),
                  new Text(doc["modelo"].toString()),
                  new Text(doc["color"].toString()), 
                  new Text(doc["descripcion"].toString()),                                            
                ],                                                                                                 
              ),
            //Visualizar matricula alumnos
            //-----------------------------------------------------------                      
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.cancel),
                  onPressed:(){
                    deleteAlumnoDialog(doc["codigo"].toString(),doc.documentID);
                  }, 
                ) 
              ]
            ),
          ),
        )
      )
      ).toList();
  }

  Future<void> deleteAlumnoDialog(String codigo,String id2) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Theme(
            data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.blue),
            child: AlertDialog(
            title: Text(
              'Eliminar Actividad',
              style: TextStyle(
                color: Colors.white,                                   
              ),              
              textAlign: TextAlign.center,
            ),                        
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical, 
              child: Column(                
                children: <Widget>[
                  Text("¿Esta seguro que desea salir esta bicicleta ?",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white)),
                  Text('\n' + "Codigo: "+ codigo , style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white)),                                              
                ],                                                                                                 
              ),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.white,
                child: const Text('CANCELAR'),
                onPressed: () {                         
                  Navigator.of(context).pop(ConfirmAction.CANCEL);   
                  print('◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤');
                  print('Cancelar Eliminacion');
                  print('◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤');           
                },
              ),
              FlatButton(
                color: Colors.white,
                child: const Text('ACEPTAR'),
                onPressed: () {
                  print('◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤');
                  print('Preparando para eliminar documento');
                  print('◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤◢◤');
                  //AQUI FUNC ELIMINAR
                  deleteAlumno(codigo,id2);
                  Navigator.of(context).pop(ConfirmAction.ACCEPT);
                },
              )
            ],      
         )
      );
    },
  );}

  //Función que elimina a un usuario de la BD
 void deleteAlumno(String codigo,String id2){ 
 
    Firestore.instance.runTransaction((transaction) async {
      await transaction.delete(Firestore.instance.collection("invitados").document(id2),);
    });
  
 }
}