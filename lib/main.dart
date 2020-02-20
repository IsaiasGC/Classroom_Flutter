import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main()=>runApp(Splash());

class Splash extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return SplashForm();
  }
}

class SplashForm extends State<Splash>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      // routes: {
      //   '/login' : (context)=>Login(),
      //   '/dash' : (context)=>Dash(),
      //   '/course' : (context)=>Course(),
      // },
      home: SplashScreen(
        seconds: 3,
        image: Image.network("https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepng.es%2Fpng-yq9evx%2F&psig=AOvVaw1RAHHL6NDLi3XhMwNtsjg9&ust=1582216412526000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCOjA28yF3ucCFQAAAAAdAAAAABAI"),
        // navigateAfterSeconds: Login(),
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