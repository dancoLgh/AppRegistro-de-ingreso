// To parse this JSON data, do
//
//     final registro = registroFromJson(jsonString);

import 'dart:convert';

Registro registroFromJson(String str) => Registro.fromJson(json.decode(str));

String registroToJson(Registro data) => json.encode(data.toJson());

class Registro {
    Registro({
        this.id,
        this.fecha
    });

    String id;
    String fecha;

    factory Registro.fromJson(Map<String, dynamic> json) => Registro(
        id: json["id"],
        fecha: json["fecha"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha,
    };
}
