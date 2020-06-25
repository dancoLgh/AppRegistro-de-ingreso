// To parse this JSON data, do
//
//     final clientModel = clientModelFromJson(jsonString);

import 'dart:convert';

ClientModel clientModelFromJson(String str) => ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
    ClientModel({
        this.id,
        this.nombreApellido,
        this.numDocumento,
        this.pais = "Paraguay",
        this.ciudad = "Hohenau",
        this.telefono,
    });

    String id;
    String nombreApellido;
    String numDocumento;
    String pais;
    String ciudad;
    String telefono;

    factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id             : json["id"],
        nombreApellido : json["nombre_apellido"],
        numDocumento   : json["num_documento"],
        pais           : json["pais"],
        ciudad         : json["ciudad"],
        telefono       : json["telefono"],
    );

    Map<String, dynamic> toJson() => {
        //"id"             : id,
        "nombre_apellido": nombreApellido,
        "num_documento"  : numDocumento,
        "pais"           : pais,
        "ciudad"         : ciudad,
        "telefono"       : telefono,
    };
}
