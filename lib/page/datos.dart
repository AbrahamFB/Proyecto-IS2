import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_reader/page/qr_scan.dart';

class mostrardatos extends StatefulWidget {
  final String data;
  mostrardatos({Key key,@required this.data}) : super(key: key);
  @override
  _mostrardatosState createState() => _mostrardatosState(data: this.data);
  
}

class _mostrardatosState extends State<mostrardatos> {
  final String data;
_mostrardatosState({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Datos del Estudiante'),
        ),
        body: new Container(
      child:new Center(
        child: StreamBuilder(
          stream: Firestore.instance.collection('alumnos').where("matricula", isEqualTo: data).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return FirestoreListView(documents: snapshot.data.documents, matricula: data);
          }
        )
      )
    )
    );
  }
}

class FirestoreListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  final String matricula;
  FirestoreListView({this.documents,this.matricula});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemExtent: 910.0,
      itemBuilder: (BuildContext context, int index) {
        String nombre = documents[index].data['nombre'];
        String score = documents[index].data['matricula'];
        String imagen = documents[index].data['foto_perfil'];
        String imagen_bici = documents[index].data['foto_bici'];
        String facultad = documents[index].data['facultad'];
        String color = documents[index].data['color'];
        String descripcion = documents[index].data['descripcion'];
        String marca = documents[index].data['marca'];
        String modelo = documents[index].data['modelo'];
        String tipo = documents[index].data['tipo'];
        if(score==matricula){
        return ListTile(
            title: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(children: [
                FlatButton(
         onPressed: () {_showDialog(context,imagen,"Alumno");},
         padding: EdgeInsets.all(0.0),
         child: Image.network(
                    imagen,width: 150,height: 150,
                  ),),     
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                    Text("Nombre",style: TextStyle(color: Colors.blue,fontSize: 20) ),
                    Text(nombre,style: TextStyle(fontSize: 15)),
                    Text("Matricula",style: TextStyle(color: Colors.blue,fontSize: 20)),
                    Text(score,style: TextStyle(fontSize: 15)),
                    Text("Facultad",style: TextStyle(color: Colors.blue,fontSize: 20)),
                    Text(facultad,style: TextStyle(fontSize: 15)),
                  ],))          
              ]),
              Row(children: <Widget>[
                Text("Descripcion de la Bicicleta",style: TextStyle(color: Colors.blue,fontSize: 25))
              ],),
              Row(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Text("Tipo",style: TextStyle(color: Colors.blue,fontSize: 20)),),
                Padding(
                    padding: EdgeInsets.all(10.0),
                child: Text(tipo,style: TextStyle(fontSize: 20)),)
              ],),
              Row(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Text("Modelo",style: TextStyle(color: Colors.blue,fontSize: 20)),),
                Padding(
                    padding: EdgeInsets.all(10.0),
                child: Text(modelo,style: TextStyle(fontSize: 20)),)
              ],),
              Row(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Text("Marca",style: TextStyle(color: Colors.blue,fontSize: 20)),),
                Padding(
                    padding: EdgeInsets.all(10.0),
                child: Text(marca,style: TextStyle(fontSize: 20)),)
              ],),
              Row(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Text("Color",style: TextStyle(color: Colors.blue,fontSize: 20)),),
                Padding(
                    padding: EdgeInsets.all(10.0),
                child: Text(color,style: TextStyle(fontSize: 20)),)
              ],),
              Row(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Text("Descripcion",style: TextStyle(color: Colors.blue,fontSize: 20)),),
                Padding(
                    padding: EdgeInsets.all(10.0),
                child: Text(descripcion,style: TextStyle(fontSize: 20)),)
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                FlatButton(
         onPressed: () {_showDialog(context,imagen_bici,"Alumno");},
         padding: EdgeInsets.all(0.0),
         child: Image.network(
                    imagen_bici,width: 150,height: 150,
                  ),),     
                  
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child:
                    FloatingActionButton(
                        onPressed: () {
                          addBitacora(context,matricula);
                        },
                    child: Icon(Icons.power_settings_new),
                    backgroundColor: Colors.green,
                  ),
                  ) 
              ],)
              ],) 
        ));
      }}
    );
  }
  void _showDialog(context,String imagen, String titulo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(titulo),
          content: new Image.network(
                    imagen,width: 300,height: 300,
                  ),
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
void _showDialog2(context, String titulo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(titulo),
          content: new Text(
                    titulo
                  ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>QrScan()), );
              },
            ),
          ],
        );
      },
    );
  }
  void addBitacora(context,String matricula){
    bool band=false;
    final Stream<QuerySnapshot> result = Firestore.instance.collection('bitacora').where("matricula", isEqualTo: matricula).snapshots();
    result.listen((snapshot) {
      if(snapshot.documents.length==0){
      Firestore.instance.runTransaction((transaction) async {
          await transaction.set(Firestore.instance.collection('bitacora').document(), {
            'matricula': matricula,
            'activo': "1",
            'hora_entrada': DateTime.now(),
            'hora_salida': "",
          });
        });
        _showDialog2(context,"Ingreso Exitoso");
      }
      else { 
        snapshot.documents.forEach((doc) { 
          while(band==false){
                    if(doc['activo']=='0'){
                        Firestore.instance.runTransaction((transaction) async {
                    await Firestore.instance..collection('bitacora').document(doc.documentID).updateData({'activo':'1','hora_entrada': DateTime.now()});
                }); 
                band=true;
                _showDialog2(context,"Ingreso Exitoso");
              }
              if(doc['activo']=='1'){
                Firestore.instance.runTransaction((transaction) async {
                  await Firestore.instance..collection('bitacora').document(doc.documentID).updateData({'activo':'0','hora_salida': DateTime.now()});
                });
                band=true;
                _showDialog2(context,"Salida Exitosa");
              }   
        }         
        });
      }
      
    });
  }
  }