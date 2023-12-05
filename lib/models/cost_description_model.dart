import 'dart:convert';

import 'package:equatable/equatable.dart';

class CostDescriptionModel extends Equatable {
  final int? value;
  final String? etd;
  final String? note;

  const CostDescriptionModel({this.value, this.etd, this.note});

  factory CostDescriptionModel.fromMap(Map<String, dynamic> data) {
    return CostDescriptionModel(
      value: data['value'] as int?,
      etd: data['etd'] as String?,
      note: data['note'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'value': value,
        'etd': etd,
        'note': note,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CostDescriptionModel].
  factory CostDescriptionModel.fromJson(String data) {
    return CostDescriptionModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CostDescriptionModel] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [value, etd, note];
}
