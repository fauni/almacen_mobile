
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/helpers/app_config.dart' as config;

class EmptyGenericWidget extends StatefulWidget {
  final IconData icono;
  final String mensaje;
  const EmptyGenericWidget({required this.icono, required this.mensaje, super.key});

  @override
  State<EmptyGenericWidget> createState() => EmptyGenericWidgetState();
}

class EmptyGenericWidgetState extends State<EmptyGenericWidget> {
  bool loading = true;

  @override
  void initState() {
    Timer(const Duration(seconds: 10), (){
      if(mounted){
        setState(() {
          loading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        loading 
        ? SizedBox(
          height: 3,
          child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ),
        )
        : Container(
          alignment: AlignmentDirectional.center,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: config.App(context).appHeight(70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                          Theme.of(context).primaryColor.withOpacity(0.7),
                          Theme.of(context).colorScheme.secondary.withOpacity(0.05),
                        ])),
                    child: Icon(
                      widget.icono,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 70,
                    ),
                  ),
                  Positioned(
                    right: -30,
                    bottom: -50,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -20,
                    top: -50,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Opacity(
                opacity: 0.4,
                child: Text(
                  widget.mensaje,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                  ),
                  // style: Theme.of(context).textTheme.headline3.merge(TextStyle(fontWeight: FontWeight.w300)),
                ),
              ),
              const SizedBox(height: 50),
              !loading 
              ? MaterialButton(
                elevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                onPressed: (){
                  context.pop();
                },
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                color: Theme.of(context).colorScheme.primary.withOpacity(1),
                shape: const StadiumBorder(),
                child: Text(
                  'Volver al Inicio',
                  style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                ),
                
              ) 
              : const SizedBox()
            ],
          )
        )
      ],
    );
  }
}