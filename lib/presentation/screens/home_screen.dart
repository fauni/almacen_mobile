import 'package:app_almacen/config/constants/environment.dart';
import 'package:app_almacen/presentation/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Almacen Facil 2'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.amber,),
            onPressed: (){}, 
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: (){}, 
          )
        ],
      ),
      body: const _HomeScreenView(),
      drawer: SideMenu(scaffoldKey: scaffoldKey,),
    );
  }
}


class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(Environment.UrlApi),
        const Image(image: AssetImage('assets/images/easystore.jpg')),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ItemInformation(
              title: 'Pedidos a \nEntregar hoy',
              data: '12/22',
              color: Color.fromRGBO(224, 236, 224, 1)
            ),
            SizedBox(width: 2),
            ItemInformation(
              title: 'Pedidos a \nAbiertos',
              data: '35',
              color: Color.fromRGBO(254, 237, 217, 1)
            ),
          ]
        ),
        const SizedBox(height: 4,),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ItemInformation(
              title: 'Ordenes de \nCompra abiertas',
              data: '18',
              color: Color.fromRGBO(226, 236, 249, 1)
            ),
            SizedBox(width: 2,),
            ItemInformation(
              title: 'E/S Pendientes \nde Aprobación',
              data: '4',
              color: Color.fromRGBO(242, 242, 242, 1)
            ),
          ]
        )
      ],
    );
  }
}


class ItemInformation extends StatelessWidget {

  final String title;
  final String data;
  final Color color;

  const ItemInformation({super.key, required this.title, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;


    return Expanded(
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: color
        ), 
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title, 
                    style: const TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    data,
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 35.0
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: FloatingActionButton(
                backgroundColor: colorScheme.surface,
                child: const Icon(Icons.arrow_outward_sharp),
                onPressed: () {
                  
                },
              )
            )
          ],
        ),
      ),
    );
  }
}