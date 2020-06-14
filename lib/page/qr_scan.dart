import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:qr_reader/page/datos.dart';
import 'package:qr_reader/page/registrar.dart';
import 'package:qr_reader/page/salida.dart';
import 'package:qr_reader/src/pages/login/login.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class QrScan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QrScanState();
  }
}

class QrScanState extends State<QrScan> {
  String _barcode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipOval(child: Image.asset(
                'assets/barcode.png',
                height: 120,
              ),),
              SizedBox(
                height: 20,
              ),
               Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 5.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.black,
                        splashColor: Colors.blueGrey,
                        onPressed: scan,
                        child: const Text('Scanear el código QR.'),
                      ),
                    ),
                     Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 5.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.black,
                        splashColor: Colors.blueGrey,
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>registrarPage()), );
                        },
                        child: const Text('Registar Invitado'),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 5.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.black,
                        splashColor: Colors.blueGrey,
                        onPressed: (){
                                  FutureBuilder<ConfirmAction>(
                            future: salidaDialog(context),
                            builder: (context, snapshot){
                              print('In Builder');
                    }
          );
                        },
                        child: const Text('Ingresar Pin de Salida'),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        _barcode,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
            ],
          ),
        ),
        
        drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                Icon(Icons.person),
                Text('Informacion del Trabajador'),
                Text('Id del Trabajador'),
                Text('3456722'),
                Text('Nombre del Trabajador'),
                Text('Juan Perez Juarez'),
                Text('Acceso'),
                Text('Acceso A'),
                ]),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Ayuda (?)'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Informacion de la App'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Cerrar Sesion'),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>LoginPage()), );
              },
            ),
          ],
        ),
      ),
        );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      //setState(() => this._barcode = barcode);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => mostrardatos(data: barcode),
          ),
        );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this._barcode = 'El usuario no dio permiso para el uso de la cámara!';
        });
      } else {
        setState(() => this._barcode = 'Error desconocido $e');
      }
    } on FormatException {
      setState(() => this._barcode =
          'nulo, el usuario presionó el botón de volver antes de escanear algo)');
    } catch (e) {
      setState(() => this._barcode = 'Error desconocido : $e');
    }
  }

}