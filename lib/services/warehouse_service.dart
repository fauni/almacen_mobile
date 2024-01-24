
import 'dart:convert';

import 'package:app_almacen/config/constants/environment.dart';
import 'package:app_almacen/models/warehouse.dart';
import 'package:app_almacen/repository/warehouse_repository.dart';

import 'package:http/http.dart' as http;


class WarehouseService implements WarehouseRepository{
  @override
  Future<Stream<List<Warehouse>>> getWarehousesForItem(String sessionID, String codigo) async{
    try{
      var url = Uri.parse('${Environment.UrlApi}/Wharehouse/ForItem/$codigo');
      var response = await http.get(
        url,
        headers: <String, String>{
          'Cookie': sessionID
        }
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<Warehouse> warehouses = jsonData.map((item) => Warehouse.fromJson(item)).toList();
        return Stream.value(warehouses);
      } else {
        return const Stream.empty();
      }
    } catch(e){
      throw Exception('Error en la solucitud: $e');
    }
  }

}