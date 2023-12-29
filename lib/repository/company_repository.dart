
import 'package:app_almacen/models/company.dart';

abstract class CompanyRepository {
  Future<Stream<List<Company>>> getCompanies();
}