
import 'package:app_almacen/models/company.dart';
import 'package:app_almacen/repository/company_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class CompanyController extends ControllerMVC{
  final CompanyRepository _companyRepository;
  List<Company> companies = [];

  GlobalKey<ScaffoldState> scaffoldKey;

  Company selectedCompany = Company(
    id: 0, 
    razonSocial: '', 
    nit: '', 
    companyDb: '', 
    userName: '', 
    password: '', 
    numMaximoUser: 0, 
    selected: false
  );

   CompanyController({ required CompanyRepository companyRepository }): _companyRepository = companyRepository, scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    cargarCompanias();
  }

  Future<void> cargarCompanias() async {
    final Stream<List<Company>> stream = await _companyRepository.getCompanies();
    stream.listen((data) {
      setState(() {
        companies = data;  
      });
    }, onError: (a){

    }, onDone: (){
      // if(scaffoldKey.currentState != null){
      //   ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(        
      //     const SnackBar(
      //       content: Text('Se cargo correctamente las compañias.')
      //     )
      //   );
      // }
    });
  }

  
}