import 'dart:async';
import 'dart:convert';

import 'package:app_almacen/controllers/recepcion_controller.dart';
import 'package:app_almacen/models/purchase_delivery_notes.dart';
import 'package:app_almacen/models/warehouse.dart';
import 'package:app_almacen/services/purchase_delivery_notes_service.dart';
import 'package:app_almacen/services/purchase_order_service.dart';
import 'package:app_almacen/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DetalleItemRecepcionScreen extends StatefulWidget {
  final DocumentLineDeliveryNotes? item;
  const DetalleItemRecepcionScreen({super.key, this.item});

  @override
  DetalleItemRecepcionScreenState createState() => DetalleItemRecepcionScreenState();
}

class DetalleItemRecepcionScreenState extends StateMVC<DetalleItemRecepcionScreen> {
  late RecepcionController _con;
  DetalleItemRecepcionScreenState(): super(RecepcionController(userRepository: UserService(), purchaseOrderRepository: PurchaseOrderService(), purchaseDeliveryNotesRepository: PurchaseDeliveryNotesService())){
    _con = controller as RecepcionController;
  }

  @override
  void initState() {
    _con.cantidadMaxima = widget.item!.quantity!;
    
    if(widget.item!.batchNumbers != null){
      _con.lotes = widget.item!.batchNumbers!;
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(widget.item!.itemDescription!),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          widget.item!.batchNumbers = _con.lotes;
          context.pop(widget.item);
        }, 
        label: const Text('Guardar y Volver'), 
        icon: const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onTertiary.withOpacity(1),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.1)
                  )
                ]
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Item Code:',
                          style: Theme.of(context).textTheme.titleMedium,
                          
                        ),
                      ),
                      Text(
                        '${widget.item!.itemCode}',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Descripcion:',
                          style: Theme.of(context).textTheme.titleMedium,
                          
                        ),
                      ),
                      Text(
                        '${widget.item!.itemDescription}',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Cantidad Pendiente:',
                          style: Theme.of(context).textTheme.titleMedium,
                          
                        ),
                      ),
                      Text(
                        '${_con.cantidadMaxima}',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Cantidad Recibida:',
                          style: Theme.of(context).textTheme.titleMedium,
                          
                        ),
                      ),
                      Text(
                        '${widget.item!.quantity}',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      IconButton(
                        onPressed: () async {
                          mostrarDialogCantidad(context);
                        }, 
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                        )
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Precio:',
                          style: Theme.of(context).textTheme.titleMedium,
                          
                        ),
                      ),
                      Text(
                        '${widget.item!.unitPrice}',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Almacen:',
                              style: Theme.of(context).textTheme.titleMedium,
                              
                            ),
                          ),
                          Text(
                            '${widget.item!.warehouseCode}',
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          IconButton(
                            onPressed: () async {
                              final result = await context.push('/lista_almacenes', extra: widget.item!);
                              setState(() {
                                Warehouse resultWarehouse = Warehouse.fromJson(jsonDecode(jsonEncode(result)));
                                widget.item!.warehouseCode = resultWarehouse.warehouseCode;
                              });
                            }, 
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).primaryColor,
                            )
                          )
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.5),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(10, 20),
                            blurRadius: 10,
                            spreadRadius: 0,
                            color: Colors.grey.withOpacity(.05)),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '(${_con.lotes.length}) Lotes agregados',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextButton.icon(
                              onPressed: (){
                                setState(() {
                                  _con.loteNuevo.quantity = widget.item!.quantity;  
                                });
                                
                                mostrarDialogLotes(context);
                              }, 
                              icon: const Icon(Icons.add, size: 30,), 
                              label: const Text('Agregar')
                            )
                          ],
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.separated(
                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                            itemCount: _con.lotes.length,
                            itemBuilder: (BuildContext context, int index) {
                              BatchNumber lote = _con.lotes.elementAt(index);
                              return Card(
                                child: ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Lote Nro.: ', style: Theme.of(context).textTheme.titleMedium,),
                                      Text('${lote.batchNumber}'),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Cantidad: ', style: Theme.of(context).textTheme.titleMedium,),
                                      Text('${lote.quantity}'),
                                    ],
                                  ),
                                  leading: const Icon(Icons.check),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete, 
                                      color: Colors.red,
                                    ), 
                                    onPressed: (){
                                      setState(() {
                                        _con.lotes.removeAt(index);
                                      });
                                    },
                                  )
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  Future mostrarDialogLotes(BuildContext context) {
    return showDialog(
      context: context, 
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          titlePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          title: Row(
            children: [
              const Icon(Icons.add),
              const SizedBox(width: 10,),
              Text(
                'Agregar Lote',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
          children: [
            Form(
              key: _con.batchNumberFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (newValue) {
                      _con.loteNuevo.batchNumber = newValue;
                    },
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Ingrese el Numero de Lote';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Ingrese el Nro de lote', labelText: 'Lote'
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: _con.loteNuevo.quantity.toString(),
                    onSaved: (newValue) {
                      _con.loteNuevo.quantity = double.parse(newValue!);
                    },
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Tiene que ingresar una cantidad';
                      }
                      if(double.parse(value) > widget.item!.quantity!){
                        return 'No puede ser mayor a ${widget.item!.quantity}';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Cantidad', labelText: 'Cantidad'
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: const Text('Cancelar'),
                ),
                MaterialButton(
                  onPressed: (){
                    // _con.loteNuevo.baseLineNumber = widget.item!.baseLine;  // esto era la linea anterior
                    _con.loteNuevo.baseLineNumber = widget.item!.lineNum;
                    _con.loteNuevo.itemCode = widget.item!.itemCode;
                    
                    _con.agregarLote(context);
                  },
                  child: Text(
                    'Guardar',
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
          ],
        );  
      },
    );
  }

  Future mostrarDialogCantidad(BuildContext context) {
    _con.controllerCantidad.text = widget.item!.quantity.toString();
    return showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Modificar Cantidad'),
          content: SizedBox(
            height: 100,
            child: Column(
              children: [
                TextFormField(
                  controller: _con.controllerCantidad,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese la cantidad'
                  ),
                ),
                const SizedBox(height: 5,),
                _con.mensajeError.isNotEmpty 
                ? Text(
                  _con.mensajeError,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300, 
                    fontSize: 11,
                    color: Colors.red
                  ),
                )
                : Container()
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                _con.mensajeError = '';
                Navigator.of(context).pop();
              }, 
              child: const Text('Cancelar')
            ),
            TextButton(
              onPressed: (){               
                Navigator.of(context).pop();
                if(!_con.validarCantidadMaxima()){
                  _con.mensajeError = 'Ingresa una cantidad menor o igual a ${_con.cantidadMaxima}';
                } else {
                  _con.mensajeError = '';
                  widget.item!.quantity = double.parse(_con.controllerCantidad.text);
                  
                  
                }
                setState(() {
                  if(_con.mensajeError.isNotEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_con.mensajeError),
                        backgroundColor: Colors.red,
                      )
                    );
                  }
                 });
              }, 
              child: const Text('Aceptar')
            ),
          ],
        );  
      },
    );
  }
}

