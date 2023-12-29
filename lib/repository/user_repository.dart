
import 'package:app_almacen/models/login.dart';
import 'package:app_almacen/models/user.dart';

abstract class UserRepository {
  Future<Stream<List<User>>> getAllUsers();

  Future<User> login(Login user);

  void setCurrentUser(String jsonString);
}