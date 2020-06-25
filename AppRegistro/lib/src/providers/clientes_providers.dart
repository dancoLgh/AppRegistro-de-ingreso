
import 'package:AppRegistro/src/models/cliente_model.dart';
import 'package:AppRegistro/src/models/cliente_model_b.dart';
import 'package:AppRegistro/src/models/cliente_model_registro.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ClientesProviders{


final String _url='https://app-registro-55ccf.firebaseio.com';

Future<bool> createCliente( ClientModel cliente) async{

    final url='$_url/clientes.json';

 
  final resp= await  http.post(url, body: clientModelToJson(cliente));

   final decodeData = json.decode(resp.body);

  print(decodeData);

  return true;
}


Future<bool> crearRegistro( Registro registro, String id) async{

   final url='$_url/clientes/'+id+'.json';

 
  final resp= await  http.post(url, body: registroToJson(registro));

  final decodeData = json.decode(resp.body);

  print(decodeData);

  return true;
}

Future<bool> editarCliente( ClientModel cliente) async{

 final url='$_url/clientes/${cliente.id}.json';
 
  final resp= await  http.put(url, body: clientModelToJson(cliente));

  final decodeData = json.decode(resp.body);

  print(decodeData);

  return true;
}


Future<List<ClientModel>> buscarCliente()async{


  final url='$_url/clientes.json';


  final resp = await http.get(url);
  
  final Map<String, dynamic> decodeData = json.decode(resp.body);
  final List<ClientModel> clientes = new List();

  if(decodeData==null) return [];

  decodeData.forEach((id, cliente) {
    
    final clienteTemp=ClientModel.fromJson(cliente);
    clienteTemp.id= id;
    clientes.add(clienteTemp);
  });
  
  //print(clientes);
  return clientes;
  
}


Future<List<ClientModelB>> buscarCliente2(String ci, Registro registro)async{


  final url='$_url/clientes.json?orderBy="num_documento"&equalTo="$ci"';


  final resp = await http.get(url);
  
  final Map<String, dynamic> decodeData = json.decode(resp.body);
  final List<ClientModelB> clientes = new List();

  if(decodeData==null) return [];

  decodeData.forEach((id, cliente) {
    
    final clienteTemp=ClientModelB.fromJson(cliente);
    clienteTemp.id= id;
    clientes.add(clienteTemp);
  });
  
  print(clientes);
  crearRegistro(registro,clientes[0].id);

  return clientes;


  
}
Future<int> eliminarCliente(String id)async{

   final url='$_url/clientes/$id.json';

  final resp = await http.delete(url);
  print(json.decode(resp.body));
  return 1;
}


}