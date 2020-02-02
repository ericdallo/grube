// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterData _$CharacterDataFromJson(Map<String, dynamic> json) {
  return CharacterData()
    ..id = json['id'] as String
    ..position = json['position'] == null
        ? null
        : PositionData.fromJson(json['position'] as Map<String, dynamic>)
    ..direction = _$enumDecodeNullable(_$DirectionEnumMap, json['direction'])
    ..color = json['color'] as int
    ..life = json['life'] as int
    ..stamina = json['stamina'] as int
    ..score = json['score'] as int
    ..step = (json['step'] as num)?.toDouble()
    ..bullets = (json['bullets'] as List)
        ?.map((e) =>
            e == null ? null : BulletData.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CharacterDataToJson(CharacterData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'direction': _$DirectionEnumMap[instance.direction],
      'color': instance.color,
      'life': instance.life,
      'stamina': instance.stamina,
      'score': instance.score,
      'step': instance.step,
      'bullets': instance.bullets,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$DirectionEnumMap = {
  Direction.left: 'left',
  Direction.up: 'up',
  Direction.right: 'right',
  Direction.down: 'down',
};

WorldData _$WorldDataFromJson(Map<String, dynamic> json) {
  return WorldData()
    ..size = json['size'] == null
        ? null
        : SizeData.fromJson(json['size'] as Map<String, dynamic>)
    ..players = (json['players'] as List)
        ?.map((e) => e == null
            ? null
            : CharacterData.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$WorldDataToJson(WorldData instance) => <String, dynamic>{
      'size': instance.size,
      'players': instance.players,
    };

SizeData _$SizeDataFromJson(Map<String, dynamic> json) {
  return SizeData()
    ..width = (json['width'] as num)?.toDouble()
    ..height = (json['height'] as num)?.toDouble();
}

Map<String, dynamic> _$SizeDataToJson(SizeData instance) => <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };

BulletData _$BulletDataFromJson(Map<String, dynamic> json) {
  return BulletData()
    ..position = json['position'] == null
        ? null
        : PositionData.fromJson(json['position'] as Map<String, dynamic>)
    ..direction = _$enumDecodeNullable(_$DirectionEnumMap, json['direction']);
}

Map<String, dynamic> _$BulletDataToJson(BulletData instance) =>
    <String, dynamic>{
      'position': instance.position,
      'direction': _$DirectionEnumMap[instance.direction],
    };

PositionData _$PositionDataFromJson(Map<String, dynamic> json) {
  return PositionData()
    ..x = (json['x'] as num)?.toDouble()
    ..y = (json['y'] as num)?.toDouble();
}

Map<String, dynamic> _$PositionDataToJson(PositionData instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };
