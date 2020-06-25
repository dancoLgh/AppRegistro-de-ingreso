import 'package:AppRegistro/src/bloc/provider.dart';
import 'package:AppRegistro/src/pages/cliente_page.dart';
import 'package:AppRegistro/src/pages/home_page.dart';
import 'package:AppRegistro/src/pages/login_page.dart';
import 'package:flutter/material.dart';


 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'login'    : ( BuildContext context ) => LoginPage(),
          'home'     : ( BuildContext context ) => HomePage(),
          'clientes' :(BuildContext context) => ClientePage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
      
  }
}