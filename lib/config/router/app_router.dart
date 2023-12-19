
import 'package:app_almacen/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';


final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/reportes',
      builder: (context, state) => const ReportesScreen(),
    ),
    GoRoute(
      path: '/login',
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
      builder: (context, state) => const DetalleRecepcionScreen(),
    )
  ]
);