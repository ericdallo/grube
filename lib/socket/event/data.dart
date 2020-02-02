import 'package:grube/direction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable(createToJson: false)
class CharacterData {
  String id;
  PositionData position;
  Direction direction;
  int color;

  int life;
  int stamina;
  int score;
  double step;

  List<BulletData> bullets;

  CharacterData();

  factory CharacterData.fromJson(Map<String, dynamic> json) =>
      _$CharacterDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class WorldData {
  SizeData size;
  List<CharacterData> players;

  WorldData();

  factory WorldData.fromJson(Map<String, dynamic> json) =>
      _$WorldDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class SizeData {
  double width;
  double height;

  SizeData();

  factory SizeData.fromJson(Map<String, dynamic> json) =>
      _$SizeDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class BulletData {
  PositionData position;
  Direction direction;

  BulletData();

  factory BulletData.fromJson(Map<String, dynamic> json) =>
      _$BulletDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class PositionData {
  double x;
  double y;

  PositionData();

  factory PositionData.fromJson(Map<String, dynamic> json) =>
      _$PositionDataFromJson(json);
}
