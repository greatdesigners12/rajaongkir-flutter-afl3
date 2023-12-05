part of "services.dart";

class MasterDataService {
  static Future<List<ProvinceModel>> getProvince() async {
    var response = await http.get(Uri.https(Const.baseUrl, "/starter/province"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'key': Const.apiKey,
        });

    var job = json.decode(response.body);
    List<ProvinceModel> result = [];

    if (response.statusCode == 200) {
      result = (job['rajaongkir']['results'] as List).map((e) {
        return ProvinceModel.fromMap(e);
      }).toList();
    }

    return result;
  }

  static Future<List<CityModel>> getCitiesByProvinceId(String id) async {
    final queryParameters = {
      'province': id,
    };
    var response = await http.get(
        Uri.https(Const.baseUrl, '/starter/city', queryParameters),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'key': Const.apiKey,
        });
    
    var job = json.decode(response.body);

    List<CityModel> result = [];

    if (response.statusCode == 200) {
      result = (job['rajaongkir']['results'] as List)
          .map((e) => CityModel.fromMap(e))
          .toList();
    }
    return result;
  }

  static Future<CostModel> getAllOfTheCosts(
      String origin, String destination, int weight, String courier) async {
    final parameters = {
      'origin': origin,
      'destination': destination,
      'weight': weight.toString(),
      'courier': courier
    };
    
    var response = await http.post(
        Uri.https(Const.baseUrl, '/starter/cost'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'key': Const.apiKey,
        }, body: parameters);
    
    print(response.body);
    var job = json.decode(response.body);
    List<CostModel> result = [];

    if (response.statusCode == 200) {
      result = (job['rajaongkir']["results"] as List)
          .map((e) => CostModel.fromMap(e))
          .toList();
    }
    return result[0];
  }
}
