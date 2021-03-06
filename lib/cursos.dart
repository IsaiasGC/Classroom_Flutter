import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:convert';

class Cursos extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return CursosForm();
  }
}

class CursosForm extends State<Cursos>{
  var isLoading=false;
  List dataCursos;
  TextEditingController txtName=TextEditingController();
  TextEditingController txtDesc=TextEditingController();

  Future<String> getCursos() async{
    this.setState((){
      isLoading=true;
    });
    var response=await http.get(
      Uri.encodeFull("http://192.168.101.17:8888/courses"),
      headers: {
        "Acept": "application/json",
        "Authorization": "bear"
      }
    );
    this.setState((){
      isLoading=false;
      dataCursos=json.decode(response.body);
    });
    return "Accept";
  }
  Future<int> insCurso() async{
    this.setState((){
      isLoading=true;
    });
    var name=txtName.text;
    var desc=txtDesc.text;

    Map<String, String> headers={
        "Acept": "application/json",
        "Authorization": "bear"
      };
    String cadJSON='{"name":"$name,"description":"$desc"}';

    var response=await http.post(
      Uri.encodeFull("http://192.168.100.17:8888/courses"),
      headers: headers,
      body: cadJSON
    );

    getCursos();
  }
  Future<int> updateCurso(int id) async{
    this.setState((){
      isLoading=true;
    });
    var name=txtName.text;
    var desc=txtDesc.text;

    Map<String, String> headers={
        "Acept": "application/json",
        "Authorization": "bear"
      };
    String cadJSON='{"name":"$name,"description":"$desc"}';

    var response=await http.put(
      Uri.encodeFull("http://192.168.100.17:8888/courses$id"),
      headers: headers,
      body: cadJSON
    );

    getCursos();
  }

  @override
  void initState(){
    getCursos();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Courses"),
          backgroundColor: Colors.greenAccent,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle),
          onPressed: (){
            //Accion del boton
            showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text("New Course"),
                  content: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: txtName,
                          decoration: InputDecoration(hintText: "Name of Course"),
                        ),
                        TextField(
                          controller: txtDesc,
                          decoration: InputDecoration(hintText: "Description of Course"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: RaisedButton(
                            child: Text("Save Course"),
                            onPressed: (){
                              insCurso();
                            }
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            );
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
                                Text(dataCursos[index]['description'], style: TextStyle(color: Colors.black))
                              ],
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0,),
                          ),
                        ),
                    ),
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Edit',
                        color: Color.fromARGB(255, 23, 162, 184),
                        icon: Icons.edit,
                        onTap: () => {
                          txtName=dataCursos[index]['name'],
                          txtDesc=dataCursos[index]['description'],
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: Text("Update Course"),
                                content: Form(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextField(
                                        controller: txtName,
                                        decoration: InputDecoration(hintText: "Name of Course"),
                                      ),
                                      TextField(
                                        controller: txtDesc,
                                        decoration: InputDecoration(hintText: "Description of Course"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20, right: 20),
                                        child: RaisedButton(
                                          child: Text("update Course"),
                                          onPressed: (){
                                            updateCurso(dataCursos[index]['description']);
                                          }
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        },
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Eliminar',
                        color: Color.fromARGB(255, 52, 58, 64),
                        icon: Icons.delete_outline,
                        onTap: () => {}
                      )
                    ],
                  );
                },
        ),
      ),
    );
  }
}