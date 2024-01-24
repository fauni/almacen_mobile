import 'package:app_almacen/controllers/purchase_order_controller.dart';
import 'package:app_almacen/models/purchase_orders.dart';
import 'package:app_almacen/presentation/widgets/empty_generic_widget.dart';
import 'package:app_almacen/services/purchase_order_service.dart';
import 'package:app_almacen/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class OrdenesPendientesScreen extends StatefulWidget {
  const OrdenesPendientesScreen({super.key});

  @override
  OrdenesPendientesScreenState createState() => OrdenesPendientesScreenState();
}

class OrdenesPendientesScreenState extends StateMVC<OrdenesPendientesScreen> {
  late PurchaseOrderController _con;

  OrdenesPendientesScreenState(): super(PurchaseOrderController(purchaseOrderRepository: PurchaseOrderService(), userRepository: UserService())){
    _con = controller as PurchaseOrderController;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Pedidos Abiertos',
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: (){
                setState(() {
                  _con.ordenes = [];
                  _con.cargarOrdenes(_con.token);
                });
              }, 
              icon: Icon(Icons.refresh, color: Theme.of(context).colorScheme.inversePrimary, size: 30,)
            ),
          )
        ],
      ),
      body: _con.ordenes.isEmpty
        ? const EmptyGenericWidget(icono: Icons.analytics_outlined, mensaje: 'No encontramos compras',)
        : SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Buscar',
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
                itemBuilder: (context, index){
                  PurchaseOrders order = _con.ordenes.elementAt(index);

                  return InkWell(
                    onTap: (){
                      context.push('/detalle_orden', extra: order);
                      // print('Redirigir');
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor.withOpacity(0.9),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.tertiary,
                          width: 2.0
                        ),
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
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.inversePrimary,
                                    width: 2.0
                                  ),
                                ),
                                child: Center(
                                  child: Text('OC', style: TextStyle(color: Theme.of(context).primaryColor),),
                                ),
                              ),
                              // Container(
                              //   height: company.selected ? 40 : 0,
                              //   width: company.selected ? 40 : 0,
                              //   decoration: BoxDecoration(
                              //     borderRadius: const BorderRadius.all(Radius.circular(40)),
                              //     color: Theme.of(context).dividerColor.withOpacity(company.selected ? 0.85 : 0),
                              //   ),
                              //   child: Icon(
                              //     Icons.check,
                              //     size: company.selected ? 24: 0,
                              //     color: Theme.of(context).colorScheme.primary.withOpacity(company.selected ? 0.85 : 0),
                              //   ),
                              // )
                            ],
                          ),
                          const SizedBox(width: 15,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Código Doc.: ${order.docNum.toString()}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  'Proveedor : ${order.cardName!}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Text(
                                  'Fecha: ${order.docDate.toString()}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.open_in_new, color: Theme.of(context).colorScheme.inversePrimary,), 
                              onPressed: () {},
                            )
                        ],
                      ),
                    ),
                  );
                }, 
                separatorBuilder: (context, index){
                  return const SizedBox(height: 10,);
                }, 
                itemCount: _con.ordenes.length
              )
            ],
          ),
        )
    );
  }
}