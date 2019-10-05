import 'package:chopper/chopper.dart';
import 'package:uxpress_admin/core/models/usuario.dart';

part 'api.chopper.dart';

@ChopperApi(baseUrl: "api")
abstract class ApiService extends ChopperService{

  static ApiService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: 'http://uxpress.apps-oss.com/',
      services: [
        // The generated implementation
        _$ApiService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$ApiService(client);
  }

  @Post(path: "/auth.php")
  Future<Response> auth(@Field("usuario") String usuario, @Field("pwd") String pwd);

  @Post(path: "/registrar_cliente.php")
  Future<Response> registrarCliente(@Body() Map<String, dynamic> body);

  @Get(path: "/obtener_clientes.php")
  Future<Response> getClientes();

  @Get(path: "/obtener_paises.php")
  Future<Response> getPaises();

  @Get(path: "/obtener_estados.php?")
  Future<Response> getEstados(@Query("id_pais") int id_pais);

  @Get(path: "/obtener_estados_pais.php?")
  Future<Response> getEstadosUsuario(@Query("id_usuario") int id_usuario);

  @Get(path: "/obtener_paquetes.php?")
  Future<Response> getPaquetesByEstado(@Query("id_estado") int id_estado);


  @Get(path: "/obtener_categorias.php?")
  Future<Response> getCategorias();

}