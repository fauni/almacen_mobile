import 'dart:convert';

List<PurchaseOrders> purchaseOrdersFromJson(String str) => List<PurchaseOrders>.from(json.decode(str).map((x) => PurchaseOrders.fromJson(x)));

String purchaseOrdersToJson(List<PurchaseOrders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PurchaseOrders {
    final int? docEntry;
    final int? docNum;
    final String? cardCode;
    final String? cardName;
    final DateTime? docDate;
    final DateTime? docDueDate;
    final String? documentStatus;
    final List<DocumentLine>? documentLines;

    PurchaseOrders({
        this.docEntry,
        this.docNum,
        this.cardCode,
        this.cardName,
        this.docDate,
        this.docDueDate,
        this.documentStatus,
        this.documentLines,
    });

    factory PurchaseOrders.fromJson(Map<String, dynamic> json) => PurchaseOrders(
        docEntry: json["docEntry"],
        docNum: json["docNum"],
        cardCode: json["cardCode"],
        cardName: json["cardName"],
        docDate: json["docDate"] == null ? null : DateTime.parse(json["docDate"]),
        docDueDate: json["docDueDate"] == null ? null : DateTime.parse(json["docDueDate"]),
        documentStatus: json["documentStatus"],
        documentLines: json["documentLines"] == null ? [] : List<DocumentLine>.from(json["documentLines"]!.map((x) => DocumentLine.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "docEntry": docEntry,
        "docNum": docNum,
        "cardCode": cardCode,
        "cardName": cardName,
        "docDate": docDate?.toIso8601String(),
        "docDueDate": docDueDate?.toIso8601String(),
        "documentStatus": documentStatus,
        "documentLines": documentLines == null ? [] : List<dynamic>.from(documentLines!.map((x) => x.toJson())),
    };
}

class DocumentLine {
    final int? lineNum;
    final String? itemCode;
    final String? itemDescription;
    final int? quantity;
    final int? price;
    final double? priceAfterVat;
    final String? currency;
    final int? rate;
    final int? discountPercent;
    final String? warehouseCode;
    final int? salesPersonCode;
    final int? commisionPercent;
    final String? treeType;
    final String? accountCode;
    final String? useBaseUnits;
    final String? supplierCatNum;
    final String? vatGroup;
    final String? taxCode;
    final String? measureUnit;
    final int? unitsOfMeasurment;
    final int? unitPrice;
    final String? lineStatus;
    final int? docEntry;
    final int? inventoryQuantity;
    final int? incoterms;
    final int? transportMode;
    final String? itemType;

    DocumentLine({
        this.lineNum,
        this.itemCode,
        this.itemDescription,
        this.quantity,
        this.price,
        this.priceAfterVat,
        this.currency,
        this.rate,
        this.discountPercent,
        this.warehouseCode,
        this.salesPersonCode,
        this.commisionPercent,
        this.treeType,
        this.accountCode,
        this.useBaseUnits,
        this.supplierCatNum,
        this.vatGroup,
        this.taxCode,
        this.measureUnit,
        this.unitsOfMeasurment,
        this.unitPrice,
        this.lineStatus,
        this.docEntry,
        this.inventoryQuantity,
        this.incoterms,
        this.transportMode,
        this.itemType,
    });

    factory DocumentLine.fromJson(Map<String, dynamic> json) => DocumentLine(
        lineNum: json["lineNum"],
        itemCode: json["itemCode"],
        itemDescription: json["itemDescription"],
        quantity: json["quantity"],
        price: json["price"],
        priceAfterVat: json["priceAfterVat"]?.toDouble(),
        currency: json["currency"],
        rate: json["rate"],
        discountPercent: json["discountPercent"],
        warehouseCode: json["warehouseCode"],
        salesPersonCode: json["salesPersonCode"],
        commisionPercent: json["commisionPercent"],
        treeType: json["treeType"],
        accountCode: json["accountCode"],
        useBaseUnits: json["useBaseUnits"],
        supplierCatNum: json["supplierCatNum"],
        vatGroup: json["vatGroup"],
        taxCode: json["taxCode"],
        measureUnit: json["measureUnit"],
        unitsOfMeasurment: json["unitsOfMeasurment"],
        unitPrice: json["unitPrice"],
        lineStatus: json["lineStatus"],
        docEntry: json["docEntry"],
        inventoryQuantity: json["inventoryQuantity"],
        incoterms: json["incoterms"],
        transportMode: json["transportMode"],
        itemType: json["itemType"],
    );

    Map<String, dynamic> toJson() => {
        "lineNum": lineNum,
        "itemCode": itemCode,
        "itemDescription": itemDescription,
        "quantity": quantity,
        "price": price,
        "priceAfterVat": priceAfterVat,
        "currency": currency,
        "rate": rate,
        "discountPercent": discountPercent,
        "warehouseCode": warehouseCode,
        "salesPersonCode": salesPersonCode,
        "commisionPercent": commisionPercent,
        "treeType": treeType,
        "accountCode": accountCode,
        "useBaseUnits": useBaseUnits,
        "supplierCatNum": supplierCatNum,
        "vatGroup": vatGroup,
        "taxCode": taxCode,
        "measureUnit": measureUnit,
        "unitsOfMeasurment": unitsOfMeasurment,
        "unitPrice": unitPrice,
        "lineStatus": lineStatus,
        "docEntry": docEntry,
        "inventoryQuantity": inventoryQuantity,
        "incoterms": incoterms,
        "transportMode": transportMode,
        "itemType": itemType,
    };
}
