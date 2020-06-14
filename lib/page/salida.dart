import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_reader/page/qr_scan.dart';

Future<ConfirmAction> salidaDialog(BuildContext context) async {
  String Codigo=''; 
  final codigo = TextEditingController(); 
  final _formKey = GlobalKey<FormState>();  
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return Theme(
      data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
      child: AlertDialog(
        title: Text('Codigo de Salida de invitados'),         
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
                            
                              if(value.length>6){
                                return null;
                              }else{
                                return 'Longitud de Nombre debe ser al menos de 6';
                              }                                              
                          }                                               
                        },
                        onSaved: (String val) {
                          Codigo = val;
                        },
                        controller: codigo,
                        autofocus: true,              
                        decoration: InputDecoration(      
                          icon: Icon(Icons.credit_card),          
                          labelText: 'Codigo Alumno', hintText: 'Codigo'
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
                delGuest(Codigo);                
                Navigator.of(context).pop(ConfirmAction.ACCEPT);   
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

void delGuest(String codigo){ 
 final Stream<QuerySnapshot> result = Firestore.instance.collection('invitados').where("codigo", isEqualTo: codigo).snapshots();
    result.listen((snapshot) {
      snapshot.documents.forEach((doc) {  
    Firestore.instance.runTransaction((transaction) async {
      await transaction.delete(Firestore.instance.collection('invitados').document(doc.documentID),);
    });
});}); 
 }