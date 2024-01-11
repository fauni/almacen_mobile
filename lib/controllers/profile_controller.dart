

import 'package:app_almacen/models/user.dart';
import 'package:app_almacen/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProfileController extends ControllerMVC {
  final UserRepository _userRepository;
  
  GlobalKey<ScaffoldState> scaffoldKey;

  
  User user = User();

  ProfileController({required UserRepository userRepository}) : _userRepository = userRepository, scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    listenForUser();
    super.initState();
  }

  void listenForUser(){
    _userRepository.getCurrentUser().then((value){
      if(value.apiToken == null){
        state!.context.push('/');
      } else {
        user = value;
      }
      setState(() { });
    });
  }

  void logout(){
    _userRepository.logout();
    listenForUser();// state!.context.push('/');
  }
}