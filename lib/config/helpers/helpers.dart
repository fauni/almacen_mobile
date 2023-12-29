import 'dart:async';

import 'package:app_almacen/presentation/widgets/circular_loading_widget.dart';
import 'package:flutter/material.dart';


class Helper {
  BuildContext? context;
  Helper.of(BuildContext _context) {
    context = _context;
  }


  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: Theme.of(context).primaryColor.withOpacity(0.85),
          child: const CircularLoadingWidget(height: 200),
        ),
      );
    });
    return loader;
  }

  static hideLoader(OverlayEntry loader) {
    Timer(const Duration(milliseconds: 500), () {
      try {
        loader.remove();
      } catch (e) {}
    });
  }


  // static Uri getUri(String path) {
  //   String _path = Uri.parse(GlobalConfiguration().getString('base_url')).path;
  //   if (!_path.endsWith('/')) {
  //     _path += '/';
  //   }
  //   Uri uri = Uri(
  //       scheme: Uri.parse(GlobalConfiguration().getString('base_url')).scheme,
  //       host: Uri.parse(GlobalConfiguration().getString('base_url')).host,
  //       port: Uri.parse(GlobalConfiguration().getString('base_url')).port,
  //       path: _path + path);
  //   return uri;
  // }
}
