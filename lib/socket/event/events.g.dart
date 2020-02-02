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

EnemyAddedEvent _$EnemyAddedEventFromJson(Map<String, dynamic> json) {
  return EnemyAddedEvent()
    ..enemy = json['player'] == null
        ? null
        : CharacterData.fromJson(json['player'] as Map<String, dynamic>);
}

EnemyRemovedEvent _$EnemyRemovedEventFromJson(Map<String, dynamic> json) {
  return EnemyRemovedEvent()..enemyId = json['player-id'] as String;
}

EnemyPausedEvent _$EnemyPausedEventFromJson(Map<String, dynamic> json) {
  return EnemyPausedEvent()..enemyId = json['enemy-id'] as String;
}

EnemyResumedEvent _$EnemyResumedEventFromJson(Map<String, dynamic> json) {
  return EnemyResumedEvent()..enemyId = json['enemy-id'] as String;
}

PlayerMovedEvent _$PlayerMovedEventFromJson(Map<String, dynamic> json) {
  return PlayerMovedEvent()
    ..player = json['player'] == null
        ? null
        : CharacterData.fromJson(json['player'] as Map<String, dynamic>);
}

PlayerShotEvent _$PlayerShotEventFromJson(Map<String, dynamic> json) {
  return PlayerShotEvent()
    ..bullets = (json['bullets'] as List)
        ?.map((e) =>
            e == null ? null : BulletData.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

EnemyShotEvent _$EnemyShotEventFromJson(Map<String, dynamic> json) {
  return EnemyShotEvent()
    ..enemyId = json['enemy-id'] as String
    ..bullets = (json['bullets'] as List)
        ?.map((e) =>
            e == null ? null : BulletData.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

BulletsMovedEvent _$BulletsMovedEventFromJson(Map<String, dynamic> json) {
  return BulletsMovedEvent()
    ..bulletsByPlayer =
        (json['bullets-by-player'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          (e as List)
              ?.map((e) => e == null
                  ? null
                  : BulletData.fromJson(e as Map<String, dynamic>))
              ?.toList()),
    );
}

PlayersHittedEvent _$PlayersHittedEventFromJson(Map<String, dynamic> json) {
  return PlayersHittedEvent()
    ..playerIds =
        (json['player-ids'] as List)?.map((e) => e as String)?.toList();
}

PlayerScoredEvent _$PlayerScoredEventFromJson(Map<String, dynamic> json) {
  return PlayerScoredEvent()
    ..crownedPlayerId = json['crowned-player'] as String
    ..score = json['score'] as int;
}

EnemiesScoredEvent _$EnemiesScoredEventFromJson(Map<String, dynamic> json) {
  return EnemiesScoredEvent()
    ..crownedPlayerId = json['crowned-player'] as String
    ..enemies = (json['enemies'] as List)
        ?.map((e) => e == null
            ? null
            : CharacterData.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

PlayerRespawnedEvent _$PlayerRespawnedEventFromJson(Map<String, dynamic> json) {
  return PlayerRespawnedEvent()
    ..player = json['player'] == null
        ? null
        : CharacterData.fromJson(json['player'] as Map<String, dynamic>);
}
