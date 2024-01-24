import 'package:app_almacen/models/purchase_orders.dart';
import 'package:app_almacen/models/user.dart';
import 'package:app_almacen/repository/purchase_order_repository.dart';
import 'package:app_almacen/repository/user_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomeController extends ControllerMVC {
  final PurchaseOrderRepository _purchaseOrderRepository;
  final UserRepository _userRepository;
  
  User user = User();
  String token = "0";

  List<PurchaseOrders> ordenesPendientes = [];

  bool loadingOrdenesPendientes = false;

  HomeController({required PurchaseOrderRepository purchaseOrderRepository, required UserRepository userRepository}) : _purchaseOrderRepository = purchaseOrderRepository, _userRepository = userRepository;

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
        cargarOrdenesPendientes(token);
       });
    });
  }

  void logout(){
    _userRepository.logout();
    listenForUser();// state!.context.push('/');
  }

  Future<void> cargarOrdenesPendientes(String sessionID) async {
    loadingOrdenesPendientes = true;
    final Stream<List<PurchaseOrders>> stream = await _purchaseOrderRepository.getOrdenesPendientes(sessionID);
    stream.listen((data) {
      setState(() {
        ordenesPendientes = data;
      });
    }, onError: (Object error){
      state!.context.push('/');
    }, onDone: (){
      loadingOrdenesPendientes = false;
    });
  }
  // void obtenerToken() {
    
  //   _userRepository.getApiToken().then((value){
  //     token = value;
  //   });

  //   setState((){ });
  // }
}