import 'package:json_annotation/json_annotation.dart';
part 'cliente.g.dart';

@JsonSerializable()
class Cliente {
  int idCliente;
  String nombre;
  String correo;
  String celular;
  int pais;
  String codigo;
  int estado;

  Cliente({
    this.idCliente,
    this.nombre,
    this.correo,
    this.celular,
    this.pais,
    this.codigo,
    this.estado,
  });

  factory Cliente.fromJson(json) => _$ClienteFromJson(json);
  
}