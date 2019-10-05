
import 'package:json_annotation/json_annotation.dart';
part 'usuario.g.dart';

@JsonSerializable()
class Usuario {

  Usuario(this.usuario, this.pwd);

  String usuario;
  String pwd;
  
}