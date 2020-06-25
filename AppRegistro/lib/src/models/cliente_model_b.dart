// To parse this JSON data, do
//
//     final ClientModelB = clientModelFromJson(jsonString);

import 'dart:convert';

ClientModelB clientModeBlFromJson(String str) => ClientModelB.fromJson(json.decode(str));

String clientModelBToJson(ClientModelB data) => json.encode(data.toJson());

class ClientModelB {
    ClientModelB({
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

    factory ClientModelB.fromJson(Map<String, dynamic> json) => ClientModelB(
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
