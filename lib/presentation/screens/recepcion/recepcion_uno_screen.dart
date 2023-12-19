import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecepcionUnoScreen extends StatelessWidget {
  const RecepcionUnoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Recepción (Compras)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.switch_camera_rounded),
            onPressed: () {
              context.push('/recepcion_dos');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Documento base',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Fecha de Doc',
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Cod. de cliente',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Cod. de item',
                prefixIcon: Icon(Icons.inventory),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Almacén',
                prefixIcon: Icon(Icons.store),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Scan'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Buscar'),
                ),
              ],
            ),
          ],
        ),
      ),
      // drawer: SideMenu(scaffoldKey: scaffoldKey,),
    );
  }
}
