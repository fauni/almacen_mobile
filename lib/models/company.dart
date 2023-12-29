import 'dart:convert';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
    final int id;
    final String razonSocial;
    final String nit;
    final String companyDb;
    final String userName;
    final String password;
    final int numMaximoUser;
    bool selected = false;

    Company({
        required this.id,
        required this.razonSocial,
        required this.nit,
        required this.companyDb,
        required this.userName,
        required this.password,
        required this.numMaximoUser,
        required this.selected
    });

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        razonSocial: json["razonSocial"],
        nit: json["nit"],
        companyDb: json["companyDB"],
        userName: json["userName"],
        password: json["password"],
        numMaximoUser: json["numMaximoUser"],
        selected: json["selected"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "razonSocial": razonSocial,
        "nit": nit,
        "companyDB": companyDb,
        "userName": userName,
        "password": password,
        "numMaximoUser": numMaximoUser,
        "selected": selected,
    };
}
