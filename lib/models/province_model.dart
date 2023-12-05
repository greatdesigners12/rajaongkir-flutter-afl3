part of 'models.dart';

class ProvinceModel extends Equatable {
  final String? provinceId;
  final String? province;

  const ProvinceModel({this.provinceId, this.province});

  factory ProvinceModel.fromMap(Map<String, dynamic> data) => ProvinceModel(
        provinceId: data['province_id'] as String?,
        province: data['province'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'province_id': provinceId,
        'province': province,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProvinceModel].
  factory ProvinceModel.fromJson(String data) {
    print(json.decode(data));
    return ProvinceModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProvinceModel] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [provinceId, province];
}
