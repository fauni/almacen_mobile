import 'package:app_almacen/models/user.dart';
import 'package:app_almacen/repository/user_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomeController extends ControllerMVC {
  final UserRepository _userRepository;
  
  User user = User();
  String token = "0";

  HomeController({required UserRepository userRepository}) : _userRepository = userRepository;

  @override
  void initState() {
    listenForUser();
    // obtenerToken();
    super.initState();
  }

  void listenForUser(){
    _userRepository.getCurrentUser().then((value){
      if(value.apiToken == null){
        state!.context.push('/');
      } else {
        user = value;
      }
      setState(() {
        token = value.apiToken!;
       });
    });
  }

  void logout(){
    _userRepository.logout();
    listenForUser();// state!.context.push('/');
  }

  // void obtenerToken() {
    
  //   _userRepository.getApiToken().then((value){
  //     token = value;
  //   });

  //   setState((){ });
  // }
}