// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerAddedEvent _$PlayerAddedEventFromJson(Map<String, dynamic> json) {
  return PlayerAddedEvent()
    ..player = json['player'] == null
        ? null
        : CharacterData.fromJson(json['player'] as Map<String, dynamic>)
    ..world = json['world'] == null
        ? null
        : WorldData.fromJson(json['world'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PlayerAddedEventToJson(PlayerAddedEvent instance) =>
    <String, dynamic>{
      'player': instance.player,
      'world': instance.world,
    };
