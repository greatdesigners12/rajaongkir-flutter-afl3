part of 'models.dart';

class CityModel extends Equatable {
  final String? cityId;
  final String? provinceId;
  final String? province;
  final String? type;
  final String? cityName;
  final String? postalCode;

  const CityModel({
    this.cityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });

  factory CityModel.fromMap(Map<String, dynamic> data) => CityModel(
        cityId: data['city_id'] as String?,
        provinceId: data['province_id'] as String?,
        province: data['province'] as String?,
        type: data['type'] as String?,
        cityName: data['city_name'] as String?,
        postalCode: data['postal_code'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'city_id': cityId,
        'province_id': provinceId,
        'province': province,
        'type': type,
        'city_name': cityName,
        'postal_code': postalCode,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CityModel].
  factory CityModel.fromJson(String data) {
    return CityModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CityModel] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      cityId,
      provinceId,
      province,
      type,
      cityName,
      postalCode,
    ];
  }
}
