// To parse this JSON data, do
//
//     final purchaseDeliveryNotes = purchaseDeliveryNotesFromJson(jsonString);

import 'dart:convert';

PurchaseDeliveryNotes purchaseDeliveryNotesFromJson(String str) => PurchaseDeliveryNotes.fromJson(json.decode(str));

String purchaseDeliveryNotesToJson(PurchaseDeliveryNotes data) => json.encode(data.toJson());

class PurchaseDeliveryNotes {
    int? docEntry;
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
        docEntry: json["docEntry"],
        cardCode: json["cardCode"],
        cardName: json["cardName"],
        docDate: json["docDate"] == null ? null : DateTime.parse(json["docDate"]),
        documentLines: json["documentLines"] == null ? [] : List<DocumentLineDeliveryNotes>.from(json["documentLines"]!.map((x) => DocumentLineDeliveryNotes.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "docEntry": docEntry,
        "cardCode": cardCode,
        "cardName": cardName,
        "docDate": docDate?.toIso8601String(),
        "documentLines": documentLines == null ? [] : List<dynamic>.from(documentLines.map((x) => x.toJson())),
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
    int? warehouseCode;
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
        lineNum: json["lineNum"],
        itemCode: json["itemCode"],
        itemDescription: json["itemDescription"],
        quantity: json["quantity"].toDouble(),
        currency: json["currency"],
        taxCode: json["taxCode"],
        unitPrice: json["unitPrice"].toDouble(),
        warehouseCode: json["warehouseCode"],
        baseType: json["baseType"],
        baseEntry: json["baseEntry"],
        baseLine: json["baseLine"],
        batchNumbers: json["batchNumbers"] == null ? [] : List<BatchNumber>.from(json["batchNumbers"]!.map((x) => BatchNumber.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "lineNum": lineNum,
        "itemCode": itemCode,
        "itemDescription": itemDescription,
        "quantity": quantity,
        "currency": currency,
        "taxCode": taxCode,
        "unitPrice": unitPrice,
        "warehouseCode": warehouseCode,
        "baseType": baseType,
        "baseEntry": baseEntry,
        "baseLine": baseLine,
        "batchNumbers": batchNumbers == null ? [] : List<dynamic>.from(batchNumbers!.map((x) => x.toJson())),
    };
}

class BatchNumber {
    int? baseLineNumber;
    String? batchNumber;
    double? quantity;
    String? itemCode;
    DateTime? expiryDate;

    BatchNumber({
        this.baseLineNumber,
        this.batchNumber,
        this.quantity,
        this.itemCode,
        this.expiryDate
    });

    factory BatchNumber.fromJson(Map<String, dynamic> json) => BatchNumber(
        baseLineNumber: json["baseLineNumber"],
        batchNumber: json["batchNumber"],
        quantity: json["quantity"].toDouble(),
        itemCode: json["itemCode"],
        expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    );

    Map<String, dynamic> toJson() => {
        "baseLineNumber": baseLineNumber,
        "batchNumber": batchNumber,
        "quantity": quantity,
        "itemCode": itemCode,
        "expiryDate": expiryDate?.toIso8601String(),
    };
}
