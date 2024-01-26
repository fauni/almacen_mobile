import 'dart:convert';

import 'package:app_almacen/controllers/recepcion_controller.dart';
import 'package:app_almacen/models/purchase_delivery_notes.dart';
import 'package:app_almacen/services/purchase_delivery_notes_service.dart';
import 'package:app_almacen/services/purchase_order_service.dart';
import 'package:app_almacen/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_almacen/models/purchase_orders.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';



class DetalleRecepcionScreen extends StatefulWidget {
  final PurchaseOrders? orden;
  const DetalleRecepcionScreen({super.key, this.orden});

  @override
  DetalleRecepcionScreenState createState() => DetalleRecepcionScreenState();
} 

class DetalleRecepcionScreenState extends StateMVC<DetalleRecepcionScreen> {
  late RecepcionController _con;

  DetalleRecepcionScreenState(): super(RecepcionController(userRepository: UserService(), purchaseOrderRepository: PurchaseOrderService(), purchaseDeliveryNotesRepository: PurchaseDeliveryNotesService())){
    _con = controller as RecepcionController;
    // _con.orden = widget.orden!;
  }

  @override
  void initState() {
    _con.cargarOrdenPorEntry(widget.orden!.docEntry!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _con.orden = GoRouterState.of(context).extra! as PurchaseOrders;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Nueva Recepción'),
      ),
      body: _con.loading  
      ? const Center(child: CircularProgressIndicator())
      : Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onTertiary.withOpacity(1),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).focusColor.withOpacity(0.1), 
                        //blurRadius: 100, 
                        offset: const Offset(0, 2)
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Proveedor:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${_con.recepcion.cardCode} - ${_con.recepcion.cardName}',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fecha del Documento:',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy').format(_con.recepcion.docDate!),
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          TextButton.icon(
                            onPressed: (){
                              _con.seleccionarFecha(context);
                            }, 
                            label: const Text('Cambiar'),
                            icon: const Icon(Icons.date_range),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Buscar Item',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).focusColor.withOpacity(0.2)
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))
                        )
                      ),
                    )
                  )
                ),
                const SizedBox(height: 15,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: (){}, 
                        icon: const Icon(Icons.qr_code_scanner),
                        label: const Text('ESCANEAR QR'),
                      ),
                      ElevatedButton.icon(
                        onPressed: (){}, 
                        icon: const Icon(Icons.barcode_reader),
                        label: const Text('ESCANEAR CB'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    DocumentLineDeliveryNotes line = _con.recepcion.documentLines.elementAt(index);
                    int numline = line.lineNum! + 1;
                    return InkWell(
                      onTap: (){
                        // context.push('/detalle_recepcion', extra: order);
                        // print('Redirigir');
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onTertiary.withOpacity(0.9),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary,
                            width: 2.0
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2)
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                                alignment: AlignmentDirectional.center,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                                      border: Border.all(
                                        color: Theme.of(context).colorScheme.inversePrimary,
                                        width: 2.0
                                      ),
                                    ),
                                    child: Center(
                                      child: Text((numline).toString(), style: TextStyle(color: Theme.of(context).primaryColor),),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 15,),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Item: ',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context).textTheme.titleSmall,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              Text(
                                                '${line.itemCode}',
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context).textTheme.titleSmall,
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${line.itemDescription}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Cantidad: ',
                                                  style: Theme.of(context).textTheme.titleSmall,
                                                ),
                                              ),
                                              Text(
                                                '${line.quantity}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Precio por unidad: ',
                                                  style: Theme.of(context).textTheme.titleSmall,
                                                ),
                                              ),
                                              Text(
                                                '${line.unitPrice} ${line.currency}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Almacen: ',
                                                  style: Theme.of(context).textTheme.titleSmall,
                                                ),
                                              ),
                                              Text(
                                                '${line.warehouseCode}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          line.batchNumbers != null ? const Divider(): const SizedBox(),
                                          line.batchNumbers != null ? Text('(${line.batchNumbers!.length}) Lotes Creados', style: Theme.of(context).textTheme.titleSmall,) : const SizedBox(),
                                          line.batchNumbers != null ? Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Numero de Lote', style: Theme.of(context).textTheme.titleSmall,),
                                              Text('Cantidad', style: Theme.of(context).textTheme.titleSmall,)
                                            ],
                                          ) : const SizedBox(),
                                          line.batchNumbers != null
                                          ? SizedBox(
                                            height: 50,
                                            child: ListView.separated(
                                                shrinkWrap: false,
                                                itemBuilder: (context, index) {
                                                  BatchNumber loteItem = line.batchNumbers!.elementAt(index);
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(loteItem.batchNumber!),
                                                      Text(loteItem.quantity.toString())
                                                    ],
                                                  );
                                                }, 
                                                separatorBuilder: (context, index) {
                                                  return const SizedBox();
                                                }, 
                                                itemCount: line.batchNumbers!.length
                                              ),
                                          )
                                          : const SizedBox()
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    IconButton(
                                      onPressed: () async {
                                        final result = await context.push('/detalle_item_recepcion', extra: line);
                                        setState(() {
                                          DocumentLineDeliveryNotes dataResult = DocumentLineDeliveryNotes.fromJson(jsonDecode(jsonEncode(result)));
                                          line = dataResult;
                                        });
                                      }, 
                                      icon: Icon(
                                        Icons.edit,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    )
                                  ],
                                ),
                              )
                          ]
                        ),
                      )
                    );
                  }, 
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10,);
                  }, 
                  itemCount: _con.recepcion.documentLines.length
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Theme.of(context).focusColor,
              height: 70,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: (){
                      ScaffoldMessenger.of(context).showMaterialBanner(
                        MaterialBanner(
                          content: const Text('Se agrego correctamente la entrada de mercancia'), 
                          actions: [
                            TextButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                context.replace('/home');        
                              },
                              icon: const Icon(Icons.check), 
                              label: const Text('Volver al Inicio')
                            )
                          ]
                        )
                      );
                    }, 
                    icon: const Icon(Icons.attach_file),
                    label: const Text('ADJUNTAR'),
                  ),
                  _con.loading 
                  ? const LinearProgressIndicator()
                  : ElevatedButton.icon(
                    onPressed: (){
                      _con.crearEntradaMercancia();
                    }, 
                    icon: const Icon(Icons.create),
                    label: const Text('CREAR'),
                  ),
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}