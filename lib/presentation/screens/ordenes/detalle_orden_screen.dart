import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_almacen/models/purchase_orders.dart';


class DetalleOrdenScreen extends StatefulWidget {
  const DetalleOrdenScreen({super.key});

  @override
  State<DetalleOrdenScreen> createState() => DetalleOrdenScreenState();
}

class DetalleOrdenScreenState extends State<DetalleOrdenScreen> {
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PurchaseOrders order = GoRouterState.of(context).extra! as PurchaseOrders;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Detalle de Pedido'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    leading: Icon(
                      Icons.receipt,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      'Codigo Doc: ${order.docNum}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      'Proveedor: ${order.cardName}'
                    ),
                  ),
                ),
            
                const SizedBox(height: 15,),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Form(
                //     child: TextFormField(
                //       decoration: InputDecoration(
                //         hintText: 'Buscar Item',
                //         prefixIcon: const Icon(Icons.search),
                //         border: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             color: Theme.of(context).focusColor.withOpacity(0.2)
                //           )
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))
                //         )
                //       ),
                //     )
                //   )
                // ),
                // const SizedBox(height: 15,),
                // Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       ElevatedButton.icon(
                //         onPressed: (){}, 
                //         icon: const Icon(Icons.qr_code_scanner),
                //         label: const Text('ESCANEAR QR'),
                //       ),
                //       ElevatedButton.icon(
                //         onPressed: (){}, 
                //         icon: const Icon(Icons.barcode_reader),
                //         label: const Text('ESCANEAR CB'),
                //       ),
                //     ],
                //   ),
                const SizedBox(height: 15,),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    DocumentLine line = order.documentLines!.elementAt(index);
                    int numline = line.lineNum! + 1;
                    return InkWell(
                      onTap: (){
                        // context.push('/detalle_recepcion', extra: order);
                        // print('Redirigir');
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: line.lineStatus == 'bost_Open'
                           ? Theme.of(context).cardColor.withOpacity(0.9)
                           : Theme.of(context).colorScheme.inverseSurface.withOpacity(0.9),
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
                                      child: Text((numline).toString(), style: TextStyle(color: Theme.of(context).hintColor),),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 15,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Codigo Item: ${line.itemCode}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      'Nombre: ${line.itemDescription}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      'Cantidad: ${line.quantity} ${line.measureUnit}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      'Cantidad Pendiente: ${line.remainingOpenInventoryQuantity} ${line.measureUnit}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      'Almacen: ${line.warehouseCode}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
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
                  itemCount: order.documentLines!.length
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
                  // ElevatedButton.icon(
                  //   onPressed: (){}, 
                  //   icon: const Icon(Icons.attach_file),
                  //   label: const Text('ADJUNTAR'),
                  // ),
                  ElevatedButton.icon(
                    onPressed: (){
                      context.push('/detalle_recepcion', extra: order);
                    }, 

                    icon: const Icon(Icons.create),
                    label: const Text('CREAR ENTRADA DE MERCANCIA'),
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