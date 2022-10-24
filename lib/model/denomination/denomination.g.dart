// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'denomination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Denomination _$DenominationFromJson(Map<String, dynamic> json) => Denomination(
      value: json['value'] as int,
      text: json['text'] as String? ?? '',
    );

Map<String, dynamic> _$DenominationToJson(Denomination instance) => <String, dynamic>{
      'value': instance.value,
      'text': instance.text,
    };
