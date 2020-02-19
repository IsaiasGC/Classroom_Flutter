import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:convert';

void main()=>runApp(Cursos());

class Cursos extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return CursosForm();
  }
}

class CursosForm extends State<Cursos>{
  var isLoading=false;
  List dataCursos;

  Future<String> gerCursos() async{
    this.setState((){
      isLoading=true;
    });
    var response=await http.get(
      Uri.encodeFull("http://192.168.100.17:8888/courses"),
      headers: {"Acept": "application/json"}
    );
    this.setState((){
      isLoading=false;
      dataCursos=json.decode(response.body);
    });
    return "Accept";
  }

  @override
  Widget build(BuildContext context){
    gerCursos();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Cursos"),
          backgroundColor: Colors.greenAccent,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle),
          onPressed: (){
            //Accion del boton
          },
        ),
        body: isLoading ? Center(child: CircularProgressIndicator(),)
              : ListView.builder(
                itemCount: dataCursos==null ? 0 : dataCursos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Card(
                      elevation: 8.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        decoration: BoxDecoration(color: Color.fromRGBO(121, 181, 237, .9)),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                          leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: BoxDecoration(
                                border: Border( right: BorderSide(width: 1.0, color: Colors.black))
                              ),
                              child: Icon(Icons.language, color: Colors.black)
                            ),
                          
                            title: Text(
                                dataCursos[index]['name'],
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),

                            subtitle: Row(
                              children: <Widget>[
                                //Icon(Icons.touch_app, color: Colors.yellowAccent),
                                Text(dataCursos[index]['despription'], style: TextStyle(color: Colors.black))
                              ],
                            ),

                            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0,),
                          ),
                        ),
                    ),
                  );
                },
        ),
      ),
    );
  }
}