import 'package:app_almacen/config/menu/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hastNotch = MediaQuery.of(context).viewPadding.top > 35;

    

    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;  
        });
        
        final menuItem = appMenuItems[value];
        context.push(menuItem.link);
        widget.scaffoldKey.currentState!.closeDrawer();

      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hastNotch ? 0 : 20, 16, 10),
          child: const Text('Menu Principal'),
        ),

        ...appMenuItems
        .sublist(0,8)
        .map((item) => NavigationDrawerDestination(
          icon: Icon(item.icon), 
          label: Text(item.title)
          )
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        ...appMenuItems
        .sublist(8,9)
        .map((item) => NavigationDrawerDestination(
          icon: Icon(item.icon), 
          label: Text(item.title)
          )
        ),
      ]
    );
  }
}