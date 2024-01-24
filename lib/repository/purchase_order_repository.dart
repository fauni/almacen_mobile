
import 'package:app_almacen/models/purchase_orders.dart';

abstract class PurchaseOrderRepository {
  Future<Stream<List<PurchaseOrders>>> getTodosOrdenes(String sessionID);
  Future<Stream<List<PurchaseOrders>>> getOrdenesPendientes(String sessionID);
  Future<Stream<PurchaseOrders>> getOrdenesPorEntry(String sessionID, int id);

}