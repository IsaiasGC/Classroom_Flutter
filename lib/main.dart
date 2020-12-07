import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'dashboard.dart';
import 'cursos.dart';

void main()=>runApp(Splash());

class Splash extends StatefulWidget{
  final uri="http://192.168.100.17:8888/";
  @override
  State<StatefulWidget> createState(){
    return SplashForm();
  }
}

class SplashForm extends State<Splash>{
  bool loged=false;
  Future isLoged() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    loged=(pref.getBool('loged')??false);
  }

  @override
  Widget build(BuildContext context){
    setState(() {
      isLoged();
    });
    return MaterialApp(
      routes: {
        '/login' : (context)=>Login(),
        '/dashboard' : (context)=>Dashboard(),
        '/course' : (context)=>Cursos(),
      },
      home: SplashScreen(
        seconds: 4,
        image: Image.network("https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepng.es%2Fpng-yq9evx%2F&psig=AOvVaw1RAHHL6NDLi3XhMwNtsjg9&ust=1582216412526000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCOjA28yF3ucCFQAAAAAdAAAAABAI"),
        navigateAfterSeconds: loged ?Dashboard() :Login(),
        title: Text("Bienvenido a ClassITC", 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        gradientBackground: new LinearGradient(
          colors: [Colors.white, Colors.green], 
          begin: Alignment.center, 
          end: Alignment.bottomCenter
        ),
      ),
    );
  }
}