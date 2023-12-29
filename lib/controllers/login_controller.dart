

import 'package:app_almacen/config/helpers/helpers.dart';
import 'package:app_almacen/models/company.dart';
import 'package:app_almacen/models/login.dart';
import 'package:app_almacen/models/user.dart';
import 'package:app_almacen/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class LoginController extends ControllerMVC{
  final UserRepository _userRepository;

  bool hidePassword = true;
  bool loading = false;

  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry? loader;

  Company company = Company(id: 0, nit: '', razonSocial: '', companyDb: '', userName: '', password: '', numMaximoUser: 0, selected: false);
  User user = User();
  Login userLogin = Login();

  LoginController({ required UserRepository userRepository }): _userRepository = userRepository, loginFormKey = GlobalKey<FormState>(), scaffoldKey = GlobalKey<ScaffoldState>();

  

    
  @override
  void initState() {
    super.initState();
  }

  void login2() async {
    
    // loader = Helper.overlayLoader(state.context);
    // FocusScope.of(state.context).unfocus();
    // if (loginFormKey.currentState.validate()) {
    //   loginFormKey.currentState.save();
    //   Overlay.of(state.context).insert(loader);
    //   repository.login(user).then((value) {
    //     if (value != null && value.apiToken != null) {
    //       Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 1);
    //     } else {
    //       ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
    //         content: Text(S.of(state.context).wrong_email_or_password),
    //       ));
    //     }
    //   }).catchError((e) {
    //     loader.remove();
    //     ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
    //       content: Text(S.of(state.context).thisAccountNotExist),
    //     ));
    //   }).whenComplete(() {
    //     Helper.hideLoader(loader);
    //   });
    // }
  }  
  Future<void> login() async {
    loader = Helper.overlayLoader(state!.context);
    FocusScope.of(state!.context);

    loginFormKey.currentState!.save();
    Overlay.of(state!.context).insert(loader!);
    userLogin.idCompany = company.id;
    //final Stream<User> stream = await _userRepository.login(userLogin);
    _userRepository.login(userLogin).then((value) {
      if (value != null && value.apiToken != null) {
        state!.context.push('/home');
      } else{
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(const SnackBar(
          content: Text("El usuario o contraseña es incorrecto"),
        ));
      }
    }).catchError((e){
      loader!.remove();
    }).whenComplete(() => Helper.hideLoader(loader!));
    // stream.listen((data) {
    //   if(data != null && data.apiToken != null){
    //     state!.context.push('/home');
    //   } else {
    //     ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(const SnackBar(
    //       content: Text("El usuario o contraseña es incorrecto"),
    //     ));
    //   }
    //   setState(() {});
    // }, onError: (a){
    //   loader!.remove();
    // }, onDone: (){
    //   Helper.hideLoader(loader!);
    // });
  }

}