import 'package:flutter/material.dart';

class BlockButtonOptionsWidget extends StatelessWidget {
  const BlockButtonOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WmsOutlinedIconButtonFb5(
                icon: const Icon(Icons.view_in_ar_outlined), 
                outlineColor: Colors.orange, 
                onPressed: (){}
              ),
              WmsOutlinedIconButtonFb5(
                icon: const Icon(Icons.shopping_cart), 
                outlineColor: Colors.orange, 
                onPressed: (){}
              ),
              WmsOutlinedIconButtonFb5(
                icon: const Icon(Icons.fire_truck_sharp), 
                outlineColor: Colors.orange, 
                onPressed: (){}
              ),
              WmsOutlinedIconButtonFb5(
                icon: const Icon(Icons.sync_alt_outlined), 
                outlineColor: Colors.orange, 
                onPressed: (){}
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WmsOutlinedIconButtonFb5(
                icon: const Icon(Icons.onetwothree), 
                outlineColor: Colors.orange, 
                onPressed: (){}
              ),
              WmsOutlinedIconButtonFb5(
                icon: const Icon(Icons.factory), 
                outlineColor: Colors.orange, 
                onPressed: (){}
              ),
              WmsOutlinedIconButtonFb5(
                icon: const Icon(Icons.analytics_outlined), 
                outlineColor: Colors.orange, 
                onPressed: (){}
              ),
              WmsOutlinedIconButtonFb5(
                icon: const Icon(Icons.date_range_outlined), 
                outlineColor: Colors.orange, 
                onPressed: (){}
              )
            ],
          )
        ],
      ),
    );
  }
}



class WmsOutlinedIconButtonFb5 extends StatelessWidget {
  final double radius;
  final Widget icon;
  final Color outlineColor;
  final Function() onPressed;

  const WmsOutlinedIconButtonFb5(
      {required this.icon,
      required this.outlineColor,
      required this.onPressed,
      this.radius = 48.0,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: radius,
      height: radius,
      decoration:  ShapeDecoration(
        color: Colors.transparent,
        shape: CircleBorder(side: BorderSide(color: outlineColor)),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        splashRadius: radius / 2,
        iconSize: radius / 1.5,
        icon: icon,
        color: Colors.blue,
        onPressed: onPressed,
      ),
    );
  }
}



