import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetalleRecepcionScreen extends StatefulWidget {
  const DetalleRecepcionScreen({super.key});

  @override
  State<DetalleRecepcionScreen> createState() => _DetalleRecepcionScreenState();
}

class _DetalleRecepcionScreenState extends State<DetalleRecepcionScreen> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text="";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Detalle de Recepción'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(242, 242, 242, 1),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Row(
                    children: [
                      Text('Cod. Documento: ', style: TextStyle(fontWeight: FontWeight.w300),),
                      Text('4870', style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  const Row(
                    children: [
                      Text('Proveedor: ', style: TextStyle(fontWeight: FontWeight.w300),),
                      Text('ABC s.r.l.', style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  
                  const SizedBox(height: 15,),

                  TextField(
                    controller: dateInput,
                    decoration: const InputDecoration(
                      // icon: Icon(Icons.calendar_today),
                      labelText: ("Fecha"),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today)
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100)
                      );

                      if(pickedDate != null){
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(formattedDate);

                        setState(() {
                          dateInput.text = formattedDate;
                        });
                      } else {}
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      // icon: Icon(Icons.calendar_today),
                      labelText: ("Buscar Productos"),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.barcode_reader)
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(15),
                children: [
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Text('1'),
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Codigo Item:', style: TextStyle(fontWeight: FontWeight.w300),),
                                SizedBox(width: 10,),
                                Text('MP00013', style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Nombre:',style: TextStyle(fontWeight: FontWeight.w300),),
                                SizedBox(width: 10,),
                                Text('Producto 123',style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Cantidad Pendiente:',style: TextStyle(fontWeight: FontWeight.w300),),
                                SizedBox(width: 10,),
                                Text('10 unidades',style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider()
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // color: Colors.blue,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {}, 
              icon: Icon(Icons.upload_file),
              label: Text('Adjunto'),
            ),
            ElevatedButton.icon(
              onPressed: () {}, 
              icon: Icon(Icons.save),
              label: Text('Crear'),
            ),
          ],
        ),
      ),
    );
  }
}