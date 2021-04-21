import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  @JsonKey(required: true)
  final String id;
  final String? email;
  final String? name;
  final String? photo;
  final DateTime? dob;
  final String? organization;
  final bool? provideEmergencyServices;
  final String? serviceTimeStart;
  final String? serviceTimeEnd;
  final String? serviceDays;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.photo,
    this.dob,
    this.organization,
    this.provideEmergencyServices,
    this.serviceTimeStart,
    this.serviceTimeEnd,
    this.serviceDays,
  });

  static const nouser = User(id: '', email: '', name: '');

  bool get isUser => this == User.nouser;

  bool get isNotUser => this != User.nouser;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [id, email, name, photo, dob, organization];
}
