import 'package:app_almacen/controllers/home_controller.dart';
import 'package:app_almacen/presentation/widgets/block_button_options_widget.dart';
import 'package:app_almacen/presentation/widgets/button_action_appbar_widget.dart';
import 'package:app_almacen/presentation/widgets/side_menu.dart';
import 'package:app_almacen/services/purchase_order_service.dart';
import 'package:app_almacen/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends StateMVC<HomeScreen> {
  late HomeController _con;

  HomeScreenState(): super(HomeController(purchaseOrderRepository: PurchaseOrderService() , userRepository: UserService())){
    _con = controller as HomeController;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: SideMenu(scaffoldKey: scaffoldKey,),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Almacen Facil'),
        actions: <Widget>[
          ButtonActionAppbarWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).colorScheme.inversePrimary,)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: const Image(
              height: 70,
              image: AssetImage('assets/images/logo-almacen-facil.png')
            )
          ),
          Row(
            children: [
              WsInfoCard(
                onPressed: () {
                  context.push('/recepcion_uno');
                },
                borderColor: Theme.of(context).colorScheme.inversePrimary,
                title: 'Pedidos a entregar hoy',
                data: '12/22',
              ),
              // SizedBox(width: 10,),
              WsInfoCard(
                onPressed: () {
                  
                },
                borderColor: Theme.of(context).colorScheme.tertiary,
                title: 'Pedidos Abiertos',
                data: '35',
              ),
            ],
          ),
          Row(
            children: [
              WsInfoCard(
                onPressed: () {
                  context.push('/ordenes_abiertas');
                },
                borderColor: Theme.of(context).colorScheme.primary,
                title: 'Ordenes de compra \n abiertas',
                data: _con.ordenesPendientes.length.toString(),
                loading: _con.loadingOrdenesPendientes,
              ),
              // SizedBox(width: 10,),
              WsInfoCard(
                onPressed: () {
                  context.push('/recepcion_compras');
                },
                borderColor: Theme.of(context).colorScheme.inverseSurface,
                title: 'Pendientes de \n aprobación',
                data: '4',
              ),
            ],
          ),
          const BlockButtonOptionsWidget()
        ],

      ),
      // bottomNavigationBar: BottomNavigationBarWmsWidget(),
    );
  }
}

class WsInfoCard extends StatelessWidget {
  final Color borderColor;
  final String title;
  final String data;
  bool loading;
  final Function() onPressed;
  
  WsInfoCard({required this.borderColor, required this.title, required this.data, this.loading = false, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: borderColor,
            width: 2.0
          ),
          borderRadius: BorderRadius.circular(5.0),
          // gradient: LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.inversePrimary])
        ),

        child: Stack(
          children: [
            Positioned(
              right: 5,
              child: Ink(
                    child: IconButton(
                      icon: Icon(
                        Icons.open_in_new,
                        size: 30,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      onPressed: onPressed,
                    ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15,),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
                loading 
                ? CircularProgressIndicator(color: Theme.of(context).colorScheme.inversePrimary,)
                : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      data, 
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      )
                    )
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
