import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title, 
    required this.subTitle, 
    required this.link, 
    required this.icon
  });
}

const appMenuItems = <MenuItem>[
    MenuItem(
      title: 'Inicio', 
      subTitle: 'Pagina Principal', 
      link: '/', 
      icon: Icons.home_filled
    ),

    MenuItem(
      title: 'Productos', 
      subTitle: 'Pagina de productos', 
      link: '/productos', 
      icon: Icons.poll_rounded
    ),

    MenuItem(
      title: 'Recepcion', 
      subTitle: 'Pagina de recepcion', 
      link: '/recepcion_uno', 
      icon: Icons.receipt_long
    ),

    MenuItem(
      title: 'Entrega', 
      subTitle: 'Pagina de entrega', 
      link: '/entregas', 
      icon: Icons.delivery_dining
    ),

    MenuItem(
      title: 'Transferencias', 
      subTitle: 'Pagina de transferencias', 
      link: '/transferencias', 
      icon: Icons.transform_rounded
    ),

    MenuItem(
      title: 'Conteo de Inventario', 
      subTitle: 'Pagina de conteo de inventarios', 
      link: '/conteo', 
      icon: Icons.inventory_outlined
    ),

    MenuItem(
      title: 'Producción', 
      subTitle: 'Pagina de producción', 
      link: '/produccion', 
      icon: Icons.factory
    ),

    MenuItem(
      title: 'Reportes', 
      subTitle: 'Pagina principal de Reportes', 
      link: '/reportes', 
      icon: Icons.picture_as_pdf_outlined
    ),

    MenuItem(
      title: 'Cerrar Sesión', 
      subTitle: 'Login', 
      link: '/', 
      icon: Icons.logout_outlined
    ),
  ];