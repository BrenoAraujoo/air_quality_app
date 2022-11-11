import 'package:air_quality_app/core/packages/contracts/http_connect.dart';

class WaqiData {
  final IHttpConnect _httpConnect;

  WaqiData(this._httpConnect);

  final String _token = 'f266c18f024743221c05c8bd88edaf7e8511af31';

  String _endPointWaqi(String endpoint) {
    return 'https://api.waqi.info/feed/$endpoint';
  }

  Future<HttpResponse> get({
    required String longitude,
    required String latitude,
  }) async {
    try {
      final response = await _httpConnect.get(
        _endPointWaqi('geo:-$latitude;-$longitude?token=$_token'),
      );

      return response;
    } catch (error) {
      throw 'Falha no data: $error';
    }
  }
}
