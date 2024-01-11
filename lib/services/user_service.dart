import 'dart:convert';

import 'package:app_almacen/config/constants/environment.dart';
import 'package:app_almacen/models/login.dart';
import 'package:app_almacen/models/user.dart';
import 'package:app_almacen/repository/user_repository.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService implements UserRepository{

  @override
  Future<Stream<List<User>>> getAllUsers() async {
    try{
      var url = Uri.parse('${Environment.UrlApi}/User');
      var response = await http.get(url);

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<User> users = jsonData.map((item) => User.fromJson(item)).toList();
        return Stream.value(users);
      } else {
        return const Stream.empty();
      }
    } catch(e){
      throw Exception('Error en la solicitud: $e');
    }
  }

  @override
  Future<User> login(Login data) async{
    try{
      var url = Uri.parse('${Environment.UrlApi}/User/Login');
      var response = await http.post(
        url, 
        headers: {
          'Content-Type': 'application/json'
        },
        body: json.encode(data)
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        User user = User.fromJson(jsonData);
        setCurrentUser(response.body);
        return user;
      } else {
        return User();
      }
    } catch(e){
      throw Exception('Error en la solucitud: $e');
    }
  }
  
  @override
  void setCurrentUser(String jsonString) async {
    if (json.decode(jsonString) != null){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', json.encode(json.decode(jsonString)));
    }
  }
  
  @override
  Future<User> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? currentUser = await prefs.getString('current_user');
    final String? userString = prefs.getString('current_user');
    if(userString == null) {
      return User();
    } else {
      User usuario = User.fromJson(json.decode(userString));
      return usuario;
    }
  }

  

  @override
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');
  }
  
  @override
  Future<String> getApiToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString('current_user');
    if(userString == null) {
      return "";
    } else {
      User usuario = User.fromJson(json.decode(userString));
      return usuario.apiToken!;
    }
  }

}