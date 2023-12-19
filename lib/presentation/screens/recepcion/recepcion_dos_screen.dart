import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecepcionDosScreen extends StatelessWidget {
  const RecepcionDosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Recepción'),
        actions: [
          IconButton(
            icon: const Icon(Icons.switch_camera_rounded),
            onPressed: () {
              context.push('/recepcion_uno');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Buscar',
                      suffixIcon: Icon(Icons.barcode_reader),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                const SizedBox(width: 16,),
                ElevatedButton(onPressed: (){}, child: const Icon(Icons.refresh))
                // Expanded(
                //   child: FloatingActionButton.small(onPressed: (){}, child: const Icon(Icons.refresh)),
                // ),
              ],
            ),
            
            const SizedBox(height: 16.0),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(242, 242, 242, 1),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Center(
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      ListTile(
                        leading: const CircleAvatar(
                          child: Text('OC'),
                        ),
                        title: const Text('Cod. Doc.: 4876'),
                        subtitle: const Text('Proveedor: ABC s.r.l.'),
                        trailing: IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: (){},),
                        onTap:() {
                          context.push('/detalle_recepcion');
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const CircleAvatar(
                          child: Text('OC'),
                        ),
                        title: const Text('Cod. Doc.: 4876'),
                        subtitle: const Text('Proveedor: ABC s.r.l.'),
                        trailing: IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: (){},),
                      ),
                      const Divider()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // drawer: SideMenu(scaffoldKey: scaffoldKey,),
      bottomNavigationBar: BottomAppBar(
        // color: Colors.blue,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {}, 
              icon: Icon(Icons.barcode_reader),
              label: Text('Scan'),
            ),
            ElevatedButton.icon(
              onPressed: () {}, 
              icon: Icon(Icons.search),
              label: Text('Buscar'),
            ),
          ],
        ),
      ),
    );
  }
}
