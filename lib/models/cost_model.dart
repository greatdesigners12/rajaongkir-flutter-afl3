part of 'models.dart';

class CostModel extends Equatable {
  final String? code;
  final String? name;
  final List<Cost>? costs;

  const CostModel({this.code, this.name, this.costs});

  factory CostModel.fromMap(Map<String, dynamic> data) => CostModel(
        code: data['code'] as String?,
        name: data['name'] as String?,
        costs: (data['costs'] as List<dynamic>?)
            ?.map((e) => Cost.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'code': code,
        'name': name,
        'costs': costs?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CostModel].
  factory CostModel.fromJson(String data) {
    return CostModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CostModel] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [code, name, costs];
}
