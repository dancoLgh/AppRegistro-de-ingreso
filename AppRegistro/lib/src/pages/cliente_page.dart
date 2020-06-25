import 'dart:async';

import 'package:flutter/material.dart';
import 'package:AppRegistro/src/models/cliente_model.dart';
import 'package:AppRegistro/src/models/cliente_model_b.dart';
import 'package:AppRegistro/src/models/cliente_model_registro.dart';
import 'package:AppRegistro/src/providers/clientes_providers.dart';
import 'package:AppRegistro/src/utils/utils.dart' as utils;


class ClientePage extends StatefulWidget {
  
  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {

final formKey          = GlobalKey<FormState>();
final scaffoldKey      = GlobalKey<ScaffoldState>();
final clientesProvider = new ClientesProviders();
String btnNombre;
ClientModel cliente    = new ClientModel();
ClientModelB clienteB    = new ClientModelB();

Registro registro =new Registro();

  bool _guardadno=false;
  String _text="";

  @override
  Widget build(BuildContext context) {

    final ClientModel cliData = ModalRoute.of(context).settings.arguments;
    if(cliData!=null){
      cliente=cliData;
    }
    if(cliente.id==null)
    {
      btnNombre="Guardar y Registar entrada";
    }else{
      btnNombre="Actulizar Datos";

    }
    return Scaffold( 
      key:scaffoldKey,
      appBar:AppBar(
        title: Text('Registro de Clientes'),
      ),
      body: SingleChildScrollView(
        child: Container(
          
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearCI(),
                _crearNombre(),
                _crearPais(),
                _crearCiudad(),
                _crearTelefono(),
                _crearBotonGuardar(),
                

              ],
            ),
          ),
        ),
      ),
    );

                  
  }

    Widget _crearCI(){
      return TextFormField(
        keyboardType:TextInputType.number,
        initialValue: cliente.numDocumento,
        decoration: InputDecoration(
          labelText: 'Número de Documuento'
        ),
        onSaved: (value)=>cliente.numDocumento = value,
        validator:(value){
          if(utils.isNumeric(value)) return null;
          else return 'Solo números';
        } ,
      );
    }

   Widget  _crearPais(){
        
      return TextFormField(
        initialValue: cliente.pais,
       textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'País'
        ),
        onSaved: (value)=>cliente.pais=value,
        validator: (value){
          if(value.length<=0)return'Ingrese un país';
          else return null;
        },
      );
    
  }

    Widget  _crearCiudad(){
        
      return TextFormField(
        initialValue: cliente.ciudad,
       textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Ciudad'
        ),
        onSaved: (value)=>cliente.ciudad=value,
        validator: (value){
          if(value.length<=0)return'Ingrese la ciudad';
          else return null;
        },
      );
    
  }

   Widget _crearNombre(){
     return TextFormField(
       initialValue: cliente.nombreApellido,
       textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Nombre y Apellido'
        ),
        onSaved: (value)=>cliente.nombreApellido=value,
        validator: (value){
          if(value.length<=0) return'Ingrese el Nombre y Apellido del cliente';
          else return null;
        },
      );

   }

   Widget _crearTelefono(){
      return TextFormField(
        initialValue: cliente.telefono,
        keyboardType:TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Celular de Contacto'
        ),
        onSaved: (value)=>cliente.telefono = value,
         validator:(value){
         if(utils.isNumeric(value)) return null;
          else return 'Solo números'; 
         }
      );
   }

   Widget _crearBotonGuardar(){
      return RaisedButton.icon(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        color: Colors.deepPurpleAccent,
        onPressed: (_guardadno) ?null: _submit,  
        icon: Icon(Icons.save), 
        label: Text(btnNombre),
        textColor: Colors.white,
        );
   }


   void registrar (){
   
   registro.fecha=DateTime.now().toString();
   clientesProvider.buscarCliente2(cliente.numDocumento,registro );
   _text='Se Registro la entrada del cliente 😀';
  modtarSnackbar(_text);
  
 }
   void _submit(){
     if(! formKey.currentState.validate())return;

      formKey.currentState.save();
      setState(() {_guardadno=true;});
      if(cliente.id==null)
      {
      clientesProvider.createCliente(cliente);
      _text='Cliente Guardado';
      setState(() {_guardadno=true;});
      modtarSnackbar(_text);
      registrar();
      setState((){});
      Navigator.popAndPushNamed(context,'home');
      
      }
      else
      {
       clientesProvider.editarCliente(cliente);
        _text='Cliente actualizado';
      modtarSnackbar(_text);
       }

 
  
   }
 

  void modtarSnackbar(String mensaje){
    final snackbar= SnackBar(
      backgroundColor: Colors.purple,
      content: Text(mensaje),
      duration: Duration(milliseconds:1000),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);


  }

}