// To parse this JSON data, do
//
//     final purchaseDeliveryNotes = purchaseDeliveryNotesFromJson(jsonString);

import 'dart:convert';

PurchaseDeliveryNotes purchaseDeliveryNotesFromJson(String str) => PurchaseDeliveryNotes.fromJson(json.decode(str));

String purchaseDeliveryNotesToJson(PurchaseDeliveryNotes data) => json.encode(data.toJson());

class PurchaseDeliveryNotes {
    String? docEntry;
    String? cardCode;
    String? cardName;
    DateTime? docDate;
    List<DocumentLineDeliveryNotes> documentLines;

    PurchaseDeliveryNotes({
        this.docEntry,
        this.cardCode,
        this.cardName,
        this.docDate,
        required this.documentLines,
    });

    factory PurchaseDeliveryNotes.fromJson(Map<String, dynamic> json) => PurchaseDeliveryNotes(
        docEntry: json["DocEntry"],
        cardCode: json["CardCode"],
        cardName: json["CardName"],
        docDate: json["DocDate"] == null ? null : DateTime.parse(json["DocDate"]),
        documentLines: json["DocumentLines"] == null ? [] : List<DocumentLineDeliveryNotes>.from(json["DocumentLines"]!.map((x) => DocumentLineDeliveryNotes.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "DocEntry": docEntry,
        "CardCode": cardCode,
        "CardName": cardName,
        "DocDate": docDate?.toIso8601String(),
        "DocumentLines": documentLines == null ? [] : List<dynamic>.from(documentLines.map((x) => x.toJson())),
    };
}

class DocumentLineDeliveryNotes {
    int? lineNum;
    String? itemCode;
    String? itemDescription;
    double? quantity;
    String? currency;
    String? taxCode;
    double? unitPrice;
    String? warehouseCode;
    int? baseType;
    int? baseEntry;
    int? baseLine;
    List<BatchNumber>? batchNumbers;

    DocumentLineDeliveryNotes({
        this.lineNum,
        this.itemCode,
        this.itemDescription,
        this.quantity,
        this.currency,
        this.taxCode,
        this.unitPrice,
        this.warehouseCode,
        this.baseType,
        this.baseEntry,
        this.baseLine,
        this.batchNumbers,
    });

    factory DocumentLineDeliveryNotes.fromJson(Map<String, dynamic> json) => DocumentLineDeliveryNotes(
        lineNum: json["LineNum"],
        itemCode: json["ItemCode"],
        itemDescription: json["ItemDescription"],
        quantity: json["Quantity"],
        currency: json["Currency"],
        taxCode: json["TaxCode"],
        unitPrice: json["UnitPrice"],
        warehouseCode: json["WarehouseCode"],
        baseType: json["BaseType"],
        baseEntry: json["BaseEntry"],
        baseLine: json["BaseLine"],
        batchNumbers: json["BatchNumbers"] == null ? [] : List<BatchNumber>.from(json["BatchNumbers"]!.map((x) => BatchNumber.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "LineNum": lineNum,
        "ItemCode": itemCode,
        "ItemDescription": itemDescription,
        "Quantity": quantity,
        "Currency": currency,
        "TaxCode": taxCode,
        "UnitPrice": unitPrice,
        "WarehouseCode": warehouseCode,
        "BaseType": baseType,
        "BaseEntry": baseEntry,
        "BaseLine": baseLine,
        "BatchNumbers": batchNumbers == null ? [] : List<dynamic>.from(batchNumbers!.map((x) => x.toJson())),
    };
}

class BatchNumber {
    int? baseLineNumber;
    String? batchNumber;
    double? quantity;
    String? itemCode;

    BatchNumber({
        this.baseLineNumber,
        this.batchNumber,
        this.quantity,
        this.itemCode,
    });

    factory BatchNumber.fromJson(Map<String, dynamic> json) => BatchNumber(
        baseLineNumber: json["BaseLineNumber"],
        batchNumber: json["BatchNumber"],
        quantity: json["Quantity"],
        itemCode: json["ItemCode"],
    );

    Map<String, dynamic> toJson() => {
        "BaseLineNumber": baseLineNumber,
        "BatchNumber": batchNumber,
        "Quantity": quantity,
        "ItemCode": itemCode,
    };
}
