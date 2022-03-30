import 'package:json_annotation/json_annotation.dart';

part 'dog.g.dart';

@JsonSerializable()
class Dog {
  const Dog(this.id, this.name, this.age);

  @JsonKey(required: true)
  final int id;
  @JsonKey(required: true)
  final String name;
  @JsonKey(required: true)
  final int age;

  factory Dog.fromJson(Map<String, dynamic> json) => _$DogFromJson(json);

  Map<String, dynamic> toJson() => _$DogToJson(this);
}
