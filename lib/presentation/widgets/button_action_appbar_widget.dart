import 'package:flutter/material.dart';

class ButtonActionAppbarWidget extends StatefulWidget {
  
  const ButtonActionAppbarWidget({
    this.iconColor,
    this.labelColor,
    super.key
  });

  final Color? iconColor;
  final Color? labelColor;

  @override
  State<ButtonActionAppbarWidget> createState() => _ButtonActionAppbarWidgetState();
}

class _ButtonActionAppbarWidgetState extends State<ButtonActionAppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      onPressed: () {
        // Navigator.of(context).pushNamed('/Notifications');
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Icon(
            Icons.notifications_none,
            color: this.widget.iconColor,
            size: 30,
          ),
          Container(
            child: Text(
              '1',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption?.merge(
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 9, height: 1.3)
              ),
            ),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(color: this.widget.labelColor, borderRadius: BorderRadius.all(Radius.circular(10))),
            constraints: const BoxConstraints(minWidth: 13, maxWidth: 13, minHeight: 13, maxHeight: 13),
          )
        ],
      ),
    );
  }
}