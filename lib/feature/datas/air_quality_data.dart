import 'package:air_quality_app/core/packages/contracts/http_connect.dart';

class AirQualityData {
  final IHttpConnect _httpConnect;

  AirQualityData(this._httpConnect);

  String _endpointAirQuality(String endpoint) {
    return 'https://api-aps-dsd-airquality.herokuapp.com/$endpoint';
  }

  Future<HttpResponse> get() async {
    try {
      final response = await _httpConnect.get(
        _endpointAirQuality('races'),
      );

      return response;
    } catch (error) {
      throw 'Falha no data: $error';
    }
  }

  Future<HttpResponse> send(Map<String, dynamic> body) async {
    try {
      final response = await _httpConnect.post(
        _endpointAirQuality('races'),
        body: body,
      );

      return response;
    } catch (error) {
      throw 'Falha no data: $error';
    }
  }
}
