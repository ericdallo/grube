import 'package:json_annotation/json_annotation.dart';
import 'package:grube/socket/event/data.dart';
import 'package:grube/socket/event/messages.dart';

part 'events.g.dart';

@JsonSerializable(createToJson: false)
class PlayerAddedEvent extends EventData {
  CharacterData player;
  WorldData world;

  PlayerAddedEvent from(json) => _$PlayerAddedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class EnemyAddedEvent extends EventData {
  @JsonKey(name: "player")
  CharacterData enemy;

  from(json) => _$EnemyAddedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class EnemyRemovedEvent extends EventData {
  @JsonKey(name: "player-id")
  String enemyId;

  from(json) => _$EnemyRemovedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class EnemyPausedEvent extends EventData {
  @JsonKey(name: "enemy-id")
  String enemyId;

  from(json) => _$EnemyPausedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class EnemyResumedEvent extends EventData {
  @JsonKey(name: "enemy-id")
  String enemyId;

  from(json) => _$EnemyResumedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlayerMovedEvent extends EventData {
  CharacterData player;

  from(json) => _$PlayerMovedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlayerShotEvent extends EventData {
  List<BulletData> bullets;

  from(json) => _$PlayerShotEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class EnemyShotEvent extends EventData {
  @JsonKey(name: "enemy-id")
  String enemyId;
  List<BulletData> bullets;

  from(json) => _$EnemyShotEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class BulletsMovedEvent extends EventData {
  @JsonKey(name: "bullets-by-player")
  Map<String, List<BulletData>> bulletsByPlayer;

  from(json) => _$BulletsMovedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlayersHittedEvent extends EventData {
  @JsonKey(name: "player-ids")
  List<String> playerIds;

  from(json) => _$PlayersHittedEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlayerScoredEvent extends EventData {
  @JsonKey(name: "crowned-player")
  String crownedPlayerId;
  int score;

  from(json) => _$PlayerScoredEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class EnemiesScoredEvent extends EventData {
  @JsonKey(name: "crowned-player")
  String crownedPlayerId;
  List<CharacterData> enemies;

  from(json) => _$EnemiesScoredEventFromJson(json);
}

@JsonSerializable(createToJson: false)
class PlayerRespawnedEvent extends EventData {
  CharacterData player;

  from(json) => _$PlayerRespawnedEventFromJson(json);
}
