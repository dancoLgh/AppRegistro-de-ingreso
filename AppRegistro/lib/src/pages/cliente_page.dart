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
final _controller = TextEditingController();
final formKey          = GlobalKey<FormState>();
final scaffoldKey      = GlobalKey<ScaffoldState>();
final clientesProvider = new ClientesProviders();
String btnNombre;
ClientModel cliente    = new ClientModel();
ClientModelB clienteB    = new ClientModelB();
bool _saveMulti=false;
Registro registro =new Registro();
String _text="";


  @override
  Widget build(BuildContext context) {
  

     ClientModel cliData = ModalRoute.of(context).settings.arguments;

    if(cliData!=null){
      cliente=cliData;
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
                _crearVolver(),
                _checkBox(),


                

              ],
            ),
          ),
        ),
      ),
    );

                  
  }

    Widget _crearCI(){
      return TextFormField(
        controller: _controller,
        keyboardType:TextInputType.number,
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
        onPressed: _submit,  
        icon: Icon(Icons.save), 
        label: Text('Guardar y Registar entrada '),
        textColor: Colors.white,
        );
   }

 Widget _crearVolver(){
      return RaisedButton.icon(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        color: Colors.white,
        onPressed:(){Navigator.popAndPushNamed(context,'home');},
        icon: Icon(Icons.keyboard_backspace), 
        label: Text('Volver y actulizar listado'),
        textColor: Colors.black38
        );
   }

_checkBox(){
   return SwitchListTile(
     title: Text('Entradas Multiples'),
     value: _saveMulti,
     onChanged: (value){
       setState(() {
         _saveMulti=value;
       });
     }, 
   );
 }
 
void registrar (){
   
   registro.fecha=DateTime.now().toString();
   clientesProvider.buscarCliente2(cliente.numDocumento,registro );
   _text='Se Registro la entrada del cliente 😀';
  modtarSnackbar(_text);
  
 }
   
void _submit(){
      final durationRedi= new Duration(seconds:3);
      final durationReg= new Duration(seconds:1);
     if(! formKey.currentState.validate())return;
      formKey.currentState.save();
      clientesProvider.createCliente(cliente);
      _text='Cliente Guardado 💾';
      modtarSnackbar(_text);
      new Timer(durationReg,(){
                registrar();
           });
      if (_saveMulti==false){
          new Timer(durationRedi,(){
          Navigator.popAndPushNamed(context,'home');
           });
      }else _controller.clear();
  
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