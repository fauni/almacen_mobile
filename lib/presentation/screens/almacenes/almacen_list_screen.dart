import 'package:app_almacen/controllers/warehouse_controller.dart';
import 'package:app_almacen/models/purchase_delivery_notes.dart';
import 'package:app_almacen/models/warehouse.dart';
import 'package:app_almacen/services/user_service.dart';
import 'package:app_almacen/services/warehouse_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AlmacenListScreen extends StatefulWidget {
  final DocumentLineDeliveryNotes data;
  
  const AlmacenListScreen({ super.key, required this.data });

  @override
  AlmacenListScreenState createState() => AlmacenListScreenState();
}

class AlmacenListScreenState extends StateMVC<AlmacenListScreen> {
  late WarehouseController _con;

  AlmacenListScreenState(): super(WarehouseController(warehouseRepository: WarehouseService(), userRepository: UserService())){
    _con = controller as WarehouseController;
  }

  List<Warehouse> almacenes = [];


  @override
  void initState() {
    // print(widget.codigoAlmacen);
    _con.dataItem = widget.data;
    _con.listenForUser(widget.data.itemCode!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Almacenes Relacionados',
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          if(_con.selectedWarehouse.warehouseCode.isNotEmpty){
            GoRouter.of(context).pop(_con.selectedWarehouse); 
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Selecciona un almacen!'))
            );
          }
        }, 
        label: const Text('Seleccionar y volver'),
        icon:  const Icon(Icons.check),
      ),
      body: _con.loading
      ? const LinearProgressIndicator()
      : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                Warehouse warehouse = _con.warehouses.elementAt(index);
                return InkWell(
                  onTap: (){
                    _con.selectedWarehouse = warehouse;
                    _con.warehouses.forEach((w) {
                      if(int.parse(w.warehouseCode) == int.parse(warehouse.warehouseCode)){
                        w.selected = true;
                      } else {
                        w.selected = false;
                      }
                      setState(() { 
                        // GoRouter.of(context).pop(_con.selectedWarehouse);
                      });
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2)
                        )
                      ]
                    ),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(40)),
                                color: Theme.of(context).colorScheme.inversePrimary
                              ),
                              child: Center(
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.background
                                  ),
                                )
                              ),
                            ),
                            Container(
                              height: warehouse.selected ? 40 : 0,
                              width: warehouse.selected ? 40 : 0,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(40)),
                                color: Theme.of(context).dividerColor.withOpacity(warehouse.selected ? 0.85 : 0),
                              ),
                              child: Icon(
                                Icons.check,
                                size: warehouse.selected ? 24: 0,
                                color: Theme.of(context).colorScheme.primary.withOpacity(warehouse.selected ? 0.85 : 0),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                warehouse.warehouseCode,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                warehouse.warehouseName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }, 
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10,);
              }, 
              itemCount: _con.warehouses.length
            )
          ],
        )
      ),
    );
  }
}