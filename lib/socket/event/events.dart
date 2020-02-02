import 'package:json_annotation/json_annotation.dart';
import 'package:grube/socket/event/data.dart';
import 'package:grube/socket/event/messages.dart';

part 'events.g.dart';

@JsonSerializable(createToJson: false)
class PlayerAddedEvent extends EventData {
  CharacterData player;
  WorldData world;

  PlayerAddedEvent fromJson(Map<String, dynamic> json) =>
      _$PlayerAddedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class EnemyAddedEvent extends EventData {
  @JsonKey(name: "player")
  CharacterData enemy;

  EnemyAddedEvent fromJson(Map<String, dynamic> json) =>
      _$EnemyAddedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class EnemyRemovedEvent extends EventData {
  @JsonKey(name: "player-id")
  String enemyId;

  EnemyRemovedEvent fromJson(Map<String, dynamic> json) =>
      _$EnemyRemovedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class EnemyPausedEvent extends EventData {
  @JsonKey(name: "enemy-id")
  String enemyId;

  EnemyPausedEvent fromJson(Map<String, dynamic> json) =>
      _$EnemyPausedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class EnemyResumedEvent extends EventData {
  @JsonKey(name: "enemy-id")
  String enemyId;

  EnemyResumedEvent fromJson(Map<String, dynamic> json) =>
      _$EnemyResumedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlayerMovedEvent extends EventData {
  CharacterData player;

  PlayerMovedEvent fromJson(Map<String, dynamic> json) =>
      _$PlayerMovedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlayerShotEvent extends EventData {
  List<BulletData> bullets;

  PlayerShotEvent fromJson(Map<String, dynamic> json) =>
      _$PlayerShotEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class EnemyShotEvent extends EventData {
  @JsonKey(name: "enemy-id")
  String enemyId;
  List<BulletData> bullets;

  EnemyShotEvent fromJson(Map<String, dynamic> json) =>
      _$EnemyShotEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class BulletsMovedEvent extends EventData {
  @JsonKey(name: "bullets-by-player")
  Map<String, List<BulletData>> bulletsByPlayer;

  BulletsMovedEvent fromJson(Map<String, dynamic> json) =>
      _$BulletsMovedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlayersHittedEvent extends EventData {
  @JsonKey(name: "player-ids")
  List<String> playerIds;

  PlayersHittedEvent fromJson(Map<String, dynamic> json) =>
      _$PlayersHittedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlayerScoredEvent extends EventData {
  @JsonKey(name: "crowned-player")
  String crownedPlayerId;
  int score;

  PlayerScoredEvent fromJson(Map<String, dynamic> json) =>
      _$PlayerScoredEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class EnemiesScoredEvent extends EventData {
  @JsonKey(name: "crowned-player")
  String crownedPlayerId;
  List<CharacterData> enemies;

  EnemiesScoredEvent fromJson(Map<String, dynamic> json) =>
      _$EnemiesScoredEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlayerRespawnedEvent extends EventData {
  CharacterData player;

  PlayerRespawnedEvent fromJson(Map<String, dynamic> json) =>
      _$PlayerRespawnedEventFromJson(json);
}
