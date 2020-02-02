import 'package:json_annotation/json_annotation.dart';
import 'package:grube/socket/event/data.dart';
import 'package:grube/socket/event/messages.dart';

part 'events.g.dart';

@JsonSerializable()
class PlayerAddedEvent extends EventData {
  CharacterData player;
  WorldData world;

  PlayerAddedEvent fromJson(Map<String, dynamic> json) =>
      _$PlayerAddedEventFromJson(json);
}
