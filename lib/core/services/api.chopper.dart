// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ApiService extends ApiService {
  _$ApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = ApiService;

  Future<Response> auth(String usuario, String pwd) {
    final $url = 'api/auth.php';
    final $body = {'usuario': usuario, 'pwd': pwd};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> registrarCliente(Map<String, dynamic> body) {
    final $url = 'api/registrar_cliente.php';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getClientes() {
    final $url = 'api/obtener_clientes.php';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getPaises() {
    final $url = 'api/obtener_paises.php';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getEstados(int id_pais) {
    final $url = 'api/obtener_estados.php?';
    final Map<String, dynamic> $params = {'id_pais': id_pais};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getEstadosUsuario(int id_usuario) {
    final $url = 'api/obtener_estados_pais.php?';
    final Map<String, dynamic> $params = {'id_usuario': id_usuario};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getPaquetesByEstado(int id_estado) {
    final $url = 'api/obtener_paquetes.php?';
    final Map<String, dynamic> $params = {'id_estado': id_estado};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getCategorias() {
    final $url = 'api/obtener_categorias.php?';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
