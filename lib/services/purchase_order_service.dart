
import 'dart:convert';

import 'package:app_almacen/config/constants/environment.dart';
import 'package:app_almacen/models/purchase_orders.dart';
import 'package:app_almacen/repository/purchase_order_repository.dart';

import 'package:http/http.dart' as http;


class PurchaseOrderService implements PurchaseOrderRepository{
  @override
  Future<Stream<List<PurchaseOrders>>> getOrdenesPendientes(String sessionID) async {
    try{
      var url = Uri.parse('${Environment.UrlApi}/OrdenCompra/GetAll');

      var response = await http.get(
        url,
        headers: <String, String>{
          'Cookie': sessionID
        }
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<PurchaseOrders> orders = jsonData.map((item) => PurchaseOrders.fromJson(item)).toList();
        return Stream.value(orders);
      } else if (response.statusCode == 401){
        return Stream.error(Exception(response.statusCode));
      } else {
        return const Stream.empty();
      }
    } catch(e){
      throw Exception('Error en la solucitud: $e');
    }
  }
}