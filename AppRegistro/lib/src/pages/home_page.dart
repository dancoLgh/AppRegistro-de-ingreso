

import 'package:flutter/material.dart';
import 'package:AppRegistro/src/models/cliente_model.dart';
import 'package:AppRegistro/src/models/cliente_model_registro.dart';
import 'package:AppRegistro/src/providers/clientes_providers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


Registro registro =new Registro();
ClientModel cliente    = new ClientModel();

final clientesProviders = new ClientesProviders();
final scaffoldKey       = GlobalKey<ScaffoldState>();
  List<ClientModel> _clientes = List<ClientModel>();
  List<ClientModel> _clientesForDisplay = List<ClientModel>();
  bool _nombre=false;
  var busqueda;
  String _text="";
  


 @override
  void initState() {
    clientesProviders.buscarCliente().then((value) {
      setState(() {
        _clientes.addAll(value);
        _clientesForDisplay = _clientes;

      });
    });
    super.initState();
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:scaffoldKey,
      appBar: AppBar(
        title: Text('Clientes Registrados')
      ),
      body: Container(
        child:Column(

          children:<Widget>[
            _checkBox(),
            _searchBar(),
            Expanded(
             child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: _clientesForDisplay.length+1,
                itemBuilder: (context, index) {
                  return index == 0 ? _nada(): _listItem(index-1);
                },
            ),
             ),
            
            ),
          ],
        ),
      ),

      floatingActionButton: _crearBoton(context),
    );
  }
  Future<Null> refresh() async{

  }

   _listItem(index) {
    return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title:Text(
                _clientesForDisplay[index].numDocumento,
                style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
                ),
              ),
              subtitle:Text(
              _clientesForDisplay[index].nombreApellido,
              style: TextStyle(
              color: Colors.grey.shade600
              ),
            )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                FlatButton(
                  child: Text('Registrar entrada'),
                  color: Colors.deepPurple,
                  textColor: Colors.deepPurple[50],
                  onPressed:(){registrar(index);
                  _text="Cliente Registrado 😀";
                  modtarSnackbar(_text);
                  },
                  
                  ),
                FlatButton(
                  child: Text('Ver Registros'),
                  
                  textColor: Colors.deepPurple[50],
                  onPressed: (){} ,
                  
                  ),
                  
                  FlatButton(
                  child: Text('Editar'),
                  
                  textColor: Colors.deepPurple,
                  onPressed: () => Navigator.pushNamed(context, 'clienteEdit', arguments: _clientesForDisplay[index])
                              .then((value) => setState((){})),
                  )
              ]
            )
          ],
        ),
      );
    
  }

 

  
  void modtarSnackbar(String mensaje){
    final snackbar= SnackBar(
      backgroundColor: Colors.purple,
      content: Text(mensaje),
      duration: Duration(milliseconds:1000),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
    }
    
  _searchBar() {
    if(_nombre==true){
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Buscar...'
        ),
        onChanged: (text) {
          
          setState(() {
            _clientesForDisplay = _clientes.where((cliente) {
              if(_nombre==true){
               busqueda = cliente.nombreApellido;
              }
              if(_nombre==false){
               busqueda = cliente.numDocumento;
              }
              return busqueda.contains(text);
            }).toList();
          });
        },
      ),
    );
    }else if(_nombre==false){
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Buscar Cliente...'
        ),
        onChanged: (text) {
          setState(() {
            _clientesForDisplay = _clientes.where((cliente) {
              if(_nombre==true){
               busqueda = cliente.nombreApellido;
              }
              if(_nombre==false){
               busqueda = cliente.numDocumento;
              }
              return busqueda.contains(text);
            }).toList();
          });
        },
      ),
    );
    }
    
  } 

 _checkBox(){
   return SwitchListTile(
     title: Text('Buscar por Nombres'),
     value: _nombre,
     onChanged: (value){
       setState(() {
         _nombre=value;
       });
     }, 
   );
 }
 

 void registrar(index){
   registro.fecha=DateTime.now().toString();
   clientesProviders.crearRegistro(registro, _clientesForDisplay[index].id);
 }
 
 _crearBoton(context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=>Navigator.pushNamed((context), 'clientes')
      .then((value) => setState((){})),
    );
  }
  
  _nada(){
     return Container();
 }
}
  
