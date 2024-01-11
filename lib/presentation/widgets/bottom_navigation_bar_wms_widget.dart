import 'package:flutter/material.dart';

class BottomNavigationBarWmsWidget extends StatefulWidget {
  const BottomNavigationBarWmsWidget({super.key});

  @override
  State<BottomNavigationBarWmsWidget> createState() => _BottomNavigationBarWmsWidgetState();
}

class _BottomNavigationBarWmsWidgetState extends State<BottomNavigationBarWmsWidget> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.blue.shade900])
        ),
        child: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: SizedBox(
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconBottomBar(
                    text: 'Recepcion',
                    icon: Icons.receipt,
                    selected: _selectedIndex == 0,
                    onPressed:(){
                      setState(() {
                        _selectedIndex = 0;
                      });
                    }
                  ),
                  IconBottomBar(
                    text: 'Entrega',
                    icon: Icons.delivery_dining,
                    selected: _selectedIndex == 1,
                    onPressed:(){
                      setState(() {
                        _selectedIndex = 1;
                      });
                    }
                  ),
                  IconBottomBar(
                    text: 'Transferencias',
                    icon: Icons.transfer_within_a_station_rounded,
                    selected: _selectedIndex == 2,
                    onPressed:(){
                      setState(() {
                        _selectedIndex = 2;
                      });
                    }
                  ),
                  IconBottomBar(
                    text: 'Productos',
                    icon: Icons.production_quantity_limits_outlined,
                    selected: _selectedIndex == 3,
                    onPressed:(){
                      setState(() {
                        _selectedIndex = 3;
                      });
                    }
                  ),
                ]
              ),
            ),
          ),
        ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  const IconBottomBar({
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPressed,
    Key? key
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed, 
          icon: Icon(
            icon, 
            size: 25, 
            color: selected 
            ? Colors.white
            : Colors.grey,
          ),
        ),
        Text(text, style: TextStyle(
          fontSize: 12,
          height: .1,
          color: selected 
            ? Colors.white 
            : Colors.grey
        ),)
      ],
    );
  }
}