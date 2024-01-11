
import 'package:app_almacen/presentation/screens/companias/company_list_screen.dart';
import 'package:app_almacen/presentation/screens/ordenes/ordenes_pendientes_screen.dart';
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
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: DetalleRecepcionScreen(), 
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation), child: child,);
          },
        );
      },
      builder: (context, state) => const DetalleRecepcionScreen(),
    ),
    GoRoute(
      path: '/lista_companias',
      builder: (context, state) => const CompanyListScreen(),
    ),
    GoRoute(
      path: '/recepcion_compras',
      builder: (context, state) => const RecepcionComprasScreen(),
    ),
    GoRoute(
      path: '/ordenes_abiertas',
      builder: (context, state) => const OrdenesPendientesScreen(),
    )
  ]
);