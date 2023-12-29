
import 'dart:convert';

import 'package:app_almacen/config/constants/environment.dart';
import 'package:app_almacen/models/company.dart';
import 'package:app_almacen/repository/company_repository.dart';

import 'package:http/http.dart' as http;


class CompanyService implements CompanyRepository{
  @override
  Future<Stream<List<Company>>> getCompanies() async{
    try{
      var url = Uri.parse('${Environment.UrlApi}/company');
      var response = await http.get(url);

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        List<Company> companies = jsonData.map((item) => Company.fromJson(item)).toList();
        return Stream.value(companies);
      } else {
        return const Stream.empty();
      }
    } catch(e){
      throw Exception('Error en la solucitud: $e');
    }
  }

}