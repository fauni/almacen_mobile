
import 'dart:convert';

import 'package:app_almacen/config/constants/environment.dart';
import 'package:app_almacen/config/helpers/helpers.dart';
import 'package:app_almacen/models/error_response_sap.dart';
import 'package:app_almacen/models/purchase_delivery_notes.dart';
import 'package:app_almacen/repository/purchase_delivery_notes_repository.dart';

import 'package:http/http.dart' as http;

class PurchaseDeliveryNotesService implements PurchaseDeliveryNotesRepository{
  @override
  Future<Stream<(PurchaseDeliveryNotes? result, ErrorResponseSap? error)>> guardarEntradaMercancia(String sessionID, PurchaseDeliveryNotes data) async{
    try{
      var url = Uri.parse('${Environment.UrlApi}/PurchaseDeliveryNotes');

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': sessionID
        },
        body: json.encode(data)
      );
      String cuerpo = jsonEncode(data);
      print(cuerpo);
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        PurchaseDeliveryNotes purchaseDeliveryNotes = PurchaseDeliveryNotes.fromJson(jsonData);
        return Stream.value((purchaseDeliveryNotes, null));
      } else if (response.statusCode == 401 ){
        return Stream.error(Exception(response));
      } else {  
        final errorData = jsonDecode(response.body);
        final errorSap = Helper.getErrorSap(errorData);
        
        return Stream.value((null, errorSap));
      }
    } catch(e){
      throw Exception('Error en la solucitud: $e');
    }
  }
}