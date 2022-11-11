import 'package:air_quality_app/core/packages/contracts/http_connect.dart';
import 'package:air_quality_app/core/packages/contracts/log.dart';
import 'package:get/get_connect.dart';

class HttpConnect implements IHttpConnect {
  final _getConnect = GetConnect();
  final ILog _log;

  HttpConnect(this._log) {
    _getConnect.httpClient.timeout = const Duration(seconds: 30);
  }

  @override
  Future<HttpResponse> delete(String url,
      {required Map<String, dynamic> body,
      Map<String, String>? headers}) async {
    final response = await _getConnect.delete(
      url,
      headers: headers,
    );

    _logs(
      method: 'DELETE',
      url: url,
      body: body,
      response: response,
      headers: headers,
      statusCode: response.statusCode.toString(),
    );
    return HttpResponse(data: response.body, statusCode: response.statusCode);
  }

  @override
  Future<HttpResponse> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? query,
  }) async {
    final Response response = await _getConnect.get(
      url,
      headers: headers,
      query: query,
    );
    _logs(
      method: 'GET',
      url: url,
      headers: headers,
      response: response,
      query: query,
      statusCode: response.statusCode.toString(),
    );
    return HttpResponse(
      data: response.body,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<HttpResponse> patch(
    String url, {
    required body,
    Map<String, String>? headers,
  }) async {
    final response = await _getConnect.patch(
      url,
      body,
      headers: headers,
    );
    _logs(
      method: 'PATCH',
      url: url,
      body: body,
      headers: headers,
      response: response,
      statusCode: response.statusCode.toString(),
    );
    return HttpResponse(data: response.body, statusCode: response.statusCode);
  }

  @override
  Future<HttpResponse> post(String url,
      {required dynamic body, dynamic headers}) async {
    final response = await _getConnect.post(
      url,
      body,
      headers: headers,
    );
    _logs(
      headers: headers,
      body: body,
      url: url,
      method: 'POST',
      response: response,
      statusCode: response.statusCode.toString(),
    );
    return HttpResponse(data: response.body, statusCode: response.statusCode);
  }

  @override
  Future<HttpResponse> put(String url,
      {required dynamic body, Map<String, String>? headers}) async {
    final response = await _getConnect.put(
      url,
      body,
      headers: headers,
    );
    _logs(
      method: 'PUT',
      url: url,
      body: body,
      headers: headers,
      response: response,
      statusCode: response.statusCode.toString(),
    );
    return HttpResponse(data: response.body, statusCode: response.statusCode);
  }

  void _logs({
    required String url,
    dynamic body,
    required Map<String, String>? headers,
    Map<String, dynamic>? query,
    required Response<dynamic> response,
    required String method,
    required String statusCode,
  }) {
    _log.append('############### $method ###############');
    _log.append('URL: $url');
    _log.append('StatusCode: $statusCode');
    _log.append('BODY: $body');
    _log.append('HEADERS: $headers');
    _log.append('QUERY: $query');
    _log.append('RESPONSE: ${response.body}');
    _log.append('######################################');
    _log.closeAppend();
  }
}
