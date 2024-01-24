
import 'package:app_almacen/models/purchase_delivery_notes.dart';
import 'package:app_almacen/models/purchase_orders.dart';
import 'package:app_almacen/presentation/screens/almacenes/almacen_list_screen.dart';
import 'package:app_almacen/presentation/screens/companias/company_list_screen.dart';
import 'package:app_almacen/presentation/screens/ordenes/detalle_orden_screen.dart';
import 'package:app_almacen/presentation/screens/ordenes/ordenes_pendientes_screen.dart';
import 'package:app_almacen/presentation/screens/recepcion/detalle_item_recepcion_screen.dart';
import 'package:app_almacen/presentation/screens/recepcion/recepcion_compras_screen.dart';
import 'package:app_almacen/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/reportes',
      builder: (context, state) => const ReportesScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/recepcion_uno',
      builder: (context, state) => const RecepcionUnoScreen(),
    ),
    GoRoute(
      path: '/recepcion_dos',
      builder: (context, state) => const RecepcionDosScreen(),
    ),
    GoRoute(
      path: '/detalle_recepcion',
      name: 'detalle_recepcion',
      builder: (context, state) {
        PurchaseOrders orden = state.extra as PurchaseOrders;
        return DetalleRecepcionScreen(orden: orden);
      },
    ),
    GoRoute(
      path: '/detalle_item_recepcion',
      name: 'detalle_item_recepcion',
      builder: (context, state) {
        DocumentLineDeliveryNotes data = state.extra as DocumentLineDeliveryNotes;
        return DetalleItemRecepcionScreen(item: data,);
      },
    ),
    GoRoute(
      path: '/lista_companias',
      builder: (context, state) => const CompanyListScreen(),
    ),
    GoRoute(
      path: '/lista_almacenes',
      name: 'lista_almacenes',
      builder: (context, state) {
        final data = state.extra as DocumentLineDeliveryNotes;
        return AlmacenListScreen(data: data,);
      },
    ),
    GoRoute(
      path: '/recepcion_compras',
      builder: (context, state) => const RecepcionComprasScreen(),
    ),
    GoRoute(
      path: '/ordenes_abiertas',
      builder: (context, state) => const OrdenesPendientesScreen(),
    ),
    GoRoute(
      path: '/detalle_orden',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const DetalleOrdenScreen(), 
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation), child: child,);
          },
        );
      },
      builder: (context, state) => const DetalleOrdenScreen(),
    ),
  ]
);