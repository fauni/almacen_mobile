import 'dart:convert';

import 'package:app_almacen/models/purchase_delivery_notes.dart';
import 'package:app_almacen/models/user.dart';
import 'package:app_almacen/models/warehouse.dart';
import 'package:app_almacen/repository/user_repository.dart';
import 'package:app_almacen/repository/warehouse_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:go_router/go_router.dart';


class WarehouseController extends ControllerMVC{
  final WarehouseRepository _warehouseRepository;
  final UserRepository _userRepository;

  DocumentLineDeliveryNotes dataItem = DocumentLineDeliveryNotes();
  User user = User();
  String token = "0";
  List<Warehouse> warehouses = [];
  GlobalKey<ScaffoldState> scaffoldKey;

  bool loading = false;

  Warehouse selectedWarehouse = Warehouse(
    warehouseCode: '',
    warehouseName: '',
    selected: false
  );

   WarehouseController({ required WarehouseRepository warehouseRepository, required UserRepository userRepository }): _warehouseRepository = warehouseRepository,_userRepository=userRepository, scaffoldKey = GlobalKey<ScaffoldState>();

  void listenForUser(String codigo){
    _userRepository.getCurrentUser().then((value){
      if(value.apiToken == null){
        state!.context.push('/');
      } else {
        user = value;
      }
      setState(() {
        token = value.apiToken!;
        cargarWarehouses(codigo);
       });
    });
  }
  Future<void> cargarWarehouses(String codigoItem) async {
    loading = true;
    final Stream<List<Warehouse>> stream = await _warehouseRepository.getWarehousesForItem(token, codigoItem);
    stream.listen((data) {
      if(data.isNotEmpty){
        setState(() {
          warehouses = data;  
          verificarSeleccionWarehouse();
        });
      }
      
    }, onError: (a){
      
    }, onDone: (){
      setState(() { 
        loading = false;
      });
      if(warehouses.isEmpty){
        
      }
      
    });
  }

  verificarSeleccionWarehouse(){
    warehouses.forEach((w) {
      if(int.parse(w.warehouseCode) == dataItem.warehouseCode){
        w.selected = true;
      } else {
        w.selected = false;
      }
      setState(() { 
        // GoRouter.of(context).pop(_con.selectedWarehouse);
      });
    });
  }
  
}