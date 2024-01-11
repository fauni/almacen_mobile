import 'dart:convert';

import 'package:app_almacen/controllers/login_controller.dart';
import 'package:app_almacen/models/company.dart';
import 'package:app_almacen/presentation/widgets/block_button_widget.dart';
import 'package:app_almacen/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:app_almacen/config/helpers/app_config.dart' as config;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends StateMVC<LoginScreen> {
  late LoginController _con;

  LoginScreenState(): super(
    LoginController(userRepository: UserService())){
    _con = controller as LoginController;
  }

  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: config.App(context).appWidth(100),
              height: config.App(context).appHeight(37),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Positioned(
            width: config.App(context).appWidth(84),
            height: config.App(context).appHeight(37),
            top: config.App(context).appHeight(37) - 280,
            child: Container(
              child: const Image(
                image: AssetImage('assets/images/logo-almacen-facil.png'),
              ),
            ),
          ),
          Positioned(
            top: config.App(context).appHeight(37) - 50,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor, 
                borderRadius: const BorderRadius.all(Radius.circular(10)), 
                boxShadow: [
                  BoxShadow(
                    blurRadius: 50,
                    color: Theme.of(context).hintColor.withOpacity(0.2)
                  )
                ]),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 50,
                  horizontal: 27
                ),
                width: config.App(context).appWidth(88),
                child: Form(
                  key: _con.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        onSaved: (input) => _con.userLogin.userName = input,
                        decoration: InputDecoration(
                          labelText: 'Usuario',
                          labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                          contentPadding: const EdgeInsets.all(12),
                          hintText: 'UserName',
                          hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                          prefixIcon: Icon(Icons.person_pin_outlined, color: Theme.of(context).colorScheme.secondary,),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => _con.userLogin.passwordHash = input,
                        obscureText: _con.hidePassword,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                          contentPadding: const EdgeInsets.all(12),
                          hintText: '***********',
                          hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                          prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).colorScheme.secondary,),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() { });
                              _con.hidePassword = !_con.hidePassword;
                            }, 
                            color: Theme.of(context).focusColor,
                            icon: Icon(_con.hidePassword ? Icons.visibility : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ListTile(
                        onTap: () async{
                          // '/lista_companias'
                          final result = await context.push('/lista_companias');
                          _con.company = Company.fromJson(jsonDecode(jsonEncode(result)));
                          
                          setState(() { });
                        },
                        title: Row(
                          children: <Widget>[
                            Icon(
                              Icons.factory,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Compañia',
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ]
                        ),
                        trailing: _con.company.id>0
                        ? Text(_con.company.razonSocial)
                        : Text(
                          'Seleccionar',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      BlockButtonWidget(
                        text: const Text(
                          'INGRESAR',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          if(_con.company.id > 0){
                            _con.login();
                          } else {
                             ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Selecciona una compañia!'))
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 25,),
                    ],
                  ),
                ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Column(
              children: <Widget>[
                MaterialButton(
                  elevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  onPressed: (){},
                  textColor: Theme.of(context).hintColor,
                  child: const Text('Olvide mi contraseña'),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
