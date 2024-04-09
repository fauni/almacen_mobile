
import 'dart:async';
import 'dart:convert';

import 'package:material_dialogs/material_dialogs.dart';


import 'package:app_almacen/models/error_response_sap.dart';
import 'package:app_almacen/models/purchase_delivery_notes.dart';
import 'package:app_almacen/models/purchase_orders.dart';
import 'package:app_almacen/models/user.dart';
import 'package:app_almacen/repository/purchase_delivery_notes_repository.dart';
import 'package:app_almacen/repository/purchase_order_repository.dart';
import 'package:app_almacen/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:go_router/go_router.dart';

class RecepcionController extends ControllerMVC{
  final UserRepository _userRepository;
  final PurchaseOrderRepository _purchaseOrderRepository;
  final PurchaseDeliveryNotesRepository _purchaseDeliveryNotesRepository;

  PurchaseOrders orden = PurchaseOrders();
  PurchaseDeliveryNotes recepcion = PurchaseDeliveryNotes(documentLines: []);
  PurchaseDeliveryNotes recepcionGuardado = PurchaseDeliveryNotes(documentLines: []);
  List<BatchNumber> lotes = [];
  BatchNumber loteNuevo = BatchNumber();

  DateTime? selectedDate;

  User user = User();
  String token = "0";
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> batchNumberFormKey; 

  bool loading = false;

  double cantidadMaxima = 0;
  String mensajeError = '';
  final controllerCantidad = TextEditingController();
  TextEditingController dateInputFechaVencimiento = TextEditingController();


  RecepcionController({ required UserRepository userRepository, required PurchaseOrderRepository purchaseOrderRepository, required PurchaseDeliveryNotesRepository purchaseDeliveryNotesRepository})
    : _userRepository = userRepository, 
      _purchaseOrderRepository = purchaseOrderRepository, 
      _purchaseDeliveryNotesRepository = purchaseDeliveryNotesRepository,
      scaffoldKey = GlobalKey<ScaffoldState>(), 
      batchNumberFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // orden = GoRouterState.of(state!.context).extra! as PurchaseOrders; // borrar
    cargarValoresIniciales();
    super.initState();
  }

  void cargarValoresIniciales(){
    recepcion.docEntry = 0;
  }
  // void listenForUser(){
  //   _userRepository.getCurrentUser().then((value){
  //     if(value.apiToken == null){
  //       state!.context.push('/');
  //     } else {
  //       user = value;
  //     }
  //     setState(() {
  //       token = value.apiToken!;
  //     });
  //   });
  // }
  void crearEntradaMercancia(BuildContext context)async {
    loading = true;
    final stream = await _purchaseDeliveryNotesRepository.guardarEntradaMercancia(token, recepcion);
    stream.listen((data) {
      // print(jsonEncode(data));
      if(data.$2 == null){
        recepcionGuardado = data.$1!;
        Dialogs.materialDialog(
          context: context,
          msg: 'Se creo la entrada de Mercancia #${recepcionGuardado.docEntry}',
          title: 'Correcto',
          color: Colors.white,
          barrierDismissible: false,
          actions: [
            IconsOutlineButton(
              onPressed: (){
                Navigator.pop(context);
                context.replace('/home');        
              }, 
              text: 'Volver al Inicio',
              iconData: Icons.home,
            )
          ]
        );
      } else {
        ErrorResponseSap error = data.$2!;
        ScaffoldMessenger.of(state!.context).showSnackBar(
          SnackBar(
            content: Text('${error.message}'), 
            duration: const Duration(seconds: 5), 
            backgroundColor: Colors.red,
          )
        );
      }
      setState(() {});
    }, onError: (Object error){   
      state!.context.push('/');
    }, onDone: (){
      loading = false;
    });
  }

  void agregarLote(BuildContext context){
    setState(() { });
    if(batchNumberFormKey.currentState!.validate()){
      batchNumberFormKey.currentState!.save();
      lotes.add(loteNuevo);
      loteNuevo = BatchNumber();
      Navigator.pop(context);
    }
  }
  void cargarOrdenPorEntry(int id) {
    loading = true;
    _userRepository.getCurrentUser().then((value) async {
      if(value.apiToken == null){
        state!.context.push('/');
      } else {
        user = value;
      }
      setState(() {
        token = value.apiToken!;
      });

      final Stream<PurchaseOrders> stream = await _purchaseOrderRepository.getOrdenesPorEntry(token, id);
      stream.listen((data) {
        setState(() {
          orden = data;
          cargarDatos();
        });
      }, onError: (Object error){
        
      }, onDone: (){
        loading = false;
      });
    });
  }

  Future<void> seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2024,1), 
      lastDate: DateTime(2101)
    );

    if(picked != null && picked != recepcion.docDate) {
      setState(() {
        recepcion.docDate = picked;
      });
    }
  }

  bool validarCantidadMaxima(){
    if(double.parse(controllerCantidad.text) > cantidadMaxima){
      return false;
    }
    return true;
  }

  void cargarDatos(){
    int numeroLinea = 0;
    recepcion.cardCode = orden.cardCode;
    recepcion.cardName = orden.cardName;
    recepcion.docDate = DateTime.now();

    orden.documentLines!.forEach((element) {
      if(element.lineStatus == 'bost_Open'){
        DocumentLineDeliveryNotes lines = DocumentLineDeliveryNotes();
        lines.lineNum = numeroLinea;
        lines.itemCode = element.itemCode;
        lines.itemDescription = element.itemDescription;
        lines.quantity = element.remainingOpenInventoryQuantity;
        lines.currency = element.currency;
        lines.taxCode = element.taxCode;
        lines.unitPrice = element.unitPrice;
        lines.warehouseCode = int.parse(element.warehouseCode!);
        lines.baseType = 22;
        lines.baseEntry = orden.docEntry;
        lines.baseLine = element.lineNum;

        recepcion.documentLines.add(lines);
        numeroLinea++;
      }
    },);
    setState(() { });
  }
}