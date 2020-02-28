import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return LoginForm();
  }
}

class LoginForm extends State<Login>{
  var checked=false;
  
  isLoged(BuildContext context) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    bool loged=(pref.getBool('loged')??false);
    if(loged){
      Navigator.pushReplacementNamed(context, "/dashboard");
    }
  }
  login(BuildContext context) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    
    await pref.setBool('loged', checked);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    isLoged(context);
    final txtUserController = TextEditingController();
    final txtPwdController = TextEditingController();
    final logo = CircleAvatar(
      radius: 45.0,
      child: Image.network("https://dms.com.pe/wp-content/uploads/2017/02/acceso-web.png"),
    );
    final txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: txtUserController,
      decoration: InputDecoration(
        hintText: "Introduce el Usuario",
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0))
      ),
    );
    final txtPwd = TextFormField(
      controller: txtPwdController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Introduce el Usuario",
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(45.0))
      ),
    );
    final check=Checkbox(
      value: checked, 
      onChanged: (bool val){
        setState((){
          checked=val;
        });
      },
      tristate: false,
      activeColor: Colors.pink,
      checkColor: Colors.white,
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
//          var codigo = await validateUser();
          //print(codigo);
//          if( codigo == 200 ){
            // Navigator.push(context, MaterialPageRoute(builder:(context)=>Dashboard()));
            login(context);
            Navigator.pushReplacementNamed(context, "/dashboard");
//          }else{
//            showDialog(
//                context: context,
//                builder: (BuildContext context){
//                  return AlertDialog(
//                    title: Text("Mensaje de la APP"),
//                    content: Text("Error al Autenticarse"),
//                    actions: <Widget>[
//                      new FlatButton(
//                        child: Text("Cerrar"),
//                        onPressed: (){
//                          Navigator.of(context).pop();
//                        },
//                      )
//                    ],
//                  );
//                }
//            );
//          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlue,
        child: Text('Entrar', style: TextStyle(color: Colors.white)),
      ),
    );

    return MaterialApp(

      home:  Scaffold(
//        appBar: AppBar(
//          title: Text("Log-in"),
//          backgroundColor: Colors.lightGreen,
//        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 30),
              txtUser,
              SizedBox(height: 30),
              txtPwd,
              SizedBox(height: 10),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  check,
                  Text("Mantener Sesion", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),),
                ],
              ),
              SizedBox(height: 10,),
              loginButton,

            ],
          ),
        ),
      ),
    );
  }

}