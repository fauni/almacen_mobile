
import 'package:app_almacen/models/error_response_sap.dart';
import 'package:app_almacen/models/purchase_delivery_notes.dart';

abstract class PurchaseDeliveryNotesRepository {
  Future<Stream<(PurchaseDeliveryNotes? result, ErrorResponseSap? error)>> guardarEntradaMercancia(String sessionID, PurchaseDeliveryNotes data);
}