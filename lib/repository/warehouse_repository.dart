
import 'package:app_almacen/models/warehouse.dart';

abstract class WarehouseRepository {
  Future<Stream<List<Warehouse>>> getWarehousesForItem(String sessionID, String codigo);
}