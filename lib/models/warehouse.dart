import 'dart:convert';

Warehouse warehouseFromJson(String str) => Warehouse.fromJson(json.decode(str));

String warehouseToJson(Warehouse data) => json.encode(data.toJson());

class Warehouse {
    String warehouseCode;
    String warehouseName;
    bool selected = false;

    Warehouse({
        required this.warehouseCode,
        required this.warehouseName,
        required this.selected
    });

    factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        warehouseCode: json["warehouseCode"],
        warehouseName: json["warehouseName"],
        selected: json["selected"]
    );

    Map<String, dynamic> toJson() => {
        "warehouseCode": warehouseCode,
        "warehouseName": warehouseName,
        "selected": selected
    };
}
