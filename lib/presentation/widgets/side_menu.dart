import 'package:app_almacen/config/menu/menu_items.dart';
import 'package:app_almacen/controllers/profile_controller.dart';
import 'package:app_almacen/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends StateMVC<SideMenu> {
  ProfileController? _con;
  SideMenuState(): super(
    ProfileController(userRepository: UserService())){
    _con = controller as ProfileController;
  }

  int navDrawerIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hastNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;  
        });
        if(value == 8){
          _con!.logout();
        } else {
          final menuItem = appMenuItems[value];
          context.push(menuItem.link);
          widget.scaffoldKey.currentState!.closeDrawer();
        }
      },
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1)
          ),
          accountName: _con!.user.id != null ? Text(_con!.user.nombre!) : const SizedBox(), 
          accountEmail: _con!.user.id != null ? Text(_con!.user.email!) : const SizedBox(), 
        ),
        // Padding(
        //   padding: EdgeInsets.fromLTRB(28, hastNotch ? 0 : 20, 16, 10),
        //   child: const Text('Menu Principal'),
        // ),
        // ...appMenuItems
        // .sublist(0,7)
        // .map((item) => 
        //   ListTile(
        //     onTap: () {
        //       // Navigator.of(context).pushNamed('/Pages', arguments: 1);
        //     },
        //     leading: Icon(
        //       item.icon,
        //       color: Theme.of(context).focusColor.withOpacity(1),
        //     ),
        //     title: Text(
        //       item.title,
        //       style: Theme.of(context).textTheme.titleSmall,
        //     ),
        //   ),
        // ),
        // const Padding(
        //   padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
        //   child: Divider(),
        // ),
        // ...appMenuItems
        // .sublist(8,9)
        // .map((item) => 
        //   ListTile(
        //     onTap: () {
        //       _con!.logout();
        //     },
        //     leading: Icon(
        //       item.icon,
        //       color: Theme.of(context).focusColor.withOpacity(1),
        //     ),
        //     title: Text(
        //       item.title,
        //       style: Theme.of(context).textTheme.titleSmall,
        //     ),
        //   ),
        // )
        ...appMenuItems
        .sublist(0,8)
        .map((item) => NavigationDrawerDestination(
          icon: Icon(item.icon, color: Theme.of(context).colorScheme.inversePrimary,), 
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