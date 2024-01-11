import 'package:app_almacen/models/purchase_orders.dart';
import 'package:app_almacen/models/user.dart';
import 'package:app_almacen/repository/purchase_order_repository.dart';
import 'package:app_almacen/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:go_router/go_router.dart';

class PurchaseOrderController extends ControllerMVC{
  final PurchaseOrderRepository _purchaseOrderRepository;
  final UserRepository _userRepository;

  User user = User();
  String token = "0";
  List<PurchaseOrders> ordenes = [];
  GlobalKey<ScaffoldState> scaffoldKey;

  PurchaseOrderController({ required PurchaseOrderRepository purchaseOrderRepository, required UserRepository userRepository }): _purchaseOrderRepository = purchaseOrderRepository, _userRepository = userRepository, scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    // cargarOrdenes();
    listenForUser();
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
        cargarOrdenes(token);
       });
    });
  }

  Future<void> cargarOrdenes(String sessionID) async {
    final Stream<List<PurchaseOrders>> stream = await _purchaseOrderRepository.getOrdenesPendientes(sessionID);
    stream.listen((data) {
      setState(() {
        ordenes = data;
      });
    }, onError: (Object error){
      state!.context.push('/');
    }, onDone: (){
      
    });
  }

  
}