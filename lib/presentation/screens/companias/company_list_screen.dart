import 'package:app_almacen/controllers/company_controller.dart';
import 'package:app_almacen/models/company.dart';
import 'package:app_almacen/presentation/widgets/empty_company_widget.dart';
import 'package:app_almacen/services/company_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({super.key});

  @override
  CompanyListScreenState createState(){ 
    return CompanyListScreenState();
  }
}

class CompanyListScreenState extends StateMVC<CompanyListScreen> {
  late CompanyController _con;

  CompanyListScreenState() : super(CompanyController(companyRepository: CompanyService())){
    _con = controller as CompanyController;
  }

  List<Company> companias = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Compañias',
        ),
      ),
      
      floatingActionButton: _con.companies.isEmpty ? const SizedBox() : FloatingActionButton.extended(
        label: const Text('Seleccionar y volver'),
        icon: const Icon(Icons.check),
        onPressed: (){
          if(_con.selectedCompany.id > 0){
            GoRouter.of(context).pop(_con.selectedCompany); 
          } 
          else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Selecciona una compañia!'))
            );
          }
        }
      ),
      body: _con.companies.isEmpty
      ? const EmptyCompanyWidget()
      : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.factory,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Listado de Compañias',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: const Text('Selecciona tu Compañia'),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Buscar',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2)
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))
                    )
                  ),
                )
              )
            ),
            const SizedBox(height: 15,),
            
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                Company company = _con.companies.elementAt(index);

                return InkWell(
                  onTap: () {
                    _con.selectedCompany = company;
                    _con.companies.forEach((_l) {
                      if(_l.nit == company.nit){
                        _l.selected = true;
                      } else {
                        _l.selected = false;
                      }
                      setState(() {});
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2)
                        )
                      ]
                    ),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(40)),
                                image:  DecorationImage(image: AssetImage('assets/images/${company.nit}.png'), fit: BoxFit.cover), // revisar
                              ),
                            ),
                            Container(
                              height: company.selected ? 40 : 0,
                              width: company.selected ? 40 : 0,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(40)),
                                color: Theme.of(context).dividerColor.withOpacity(company.selected ? 0.85 : 0),
                              ),
                              child: Icon(
                                Icons.check,
                                size: company.selected ? 24: 0,
                                color: Theme.of(context).colorScheme.primary.withOpacity(company.selected ? 0.85 : 0),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                company.razonSocial,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                company.nit,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }, 
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10,);
              }, 
              itemCount: _con.companies.length
            )
          ],
        ),
      ),
    );
  }
}