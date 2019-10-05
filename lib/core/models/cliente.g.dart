// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cliente _$ClienteFromJson(Map<String, dynamic> json) {
  return Cliente(
      idCliente: json['idCliente'] as int,
      nombre: json['nombre'] as String,
      correo: json['correo'] as String,
      celular: json['celular'] as String,
      pais: json['pais'] as int,
      codigo: json['codigo'] as String,
      estado: json['estado'] as int);
}

Map<String, dynamic> _$ClienteToJson(Cliente instance) => <String, dynamic>{
      'idCliente': instance.idCliente,
      'nombre': instance.nombre,
      'correo': instance.correo,
      'celular': instance.celular,
      'pais': instance.pais,
      'codigo': instance.codigo,
      'estado': instance.estado
    };
