import 'package:flutter/material.dart';
import 'package:classroom_flutter/cursos.dart';

class Dashboard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dasboard"),
          backgroundColor: Colors.teal,
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("El Isa"),
                accountEmail: Text("15030094@itcelaya.edu.mx"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage("https://avatars2.githubusercontent.com/u/44481689?s=460&v=4"),
                ),
              ),
              ListTile(
                title: Text("Cursos"),
                leading: Icon(Icons.golf_course),
                trailing: Icon(Icons.arrow_right),
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder:(context)=>Cursos()));
                  Navigator.pushNamed(context, '/course');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

}