import 'dart:convert';

import 'package:app_almacen/config/constants/environment.dart';
import 'package:app_almacen/models/login.dart';
import 'package:app_almacen/models/user.dart';
import 'package:app_almacen/repository/user_repository.dart';

import 'package:http/http.dart' as http;

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
      throw Exception('Error en la solucitud: $e');
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
    // if (json.decode(jsonString))
  }


}