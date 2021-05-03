import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User extends Equatable {
  @JsonKey(required: true)
  final String id;
  final String? email;
  final String? name;
  final String? organization;
  final bool? provideEmergencyServices;
  final List<String>? serviceTypes;
  final String? serviceTimeStart;
  final String? serviceTimeEnd;
  final String? serviceDays;
  final double? avgRating;
  final int? oneStarRatings;
  final int? twoStarRatings;
  final int? threeStarRatings;
  final int? fourStarRatings;
  final int? fiveStarRatings;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.organization,
    this.provideEmergencyServices,
    this.serviceTypes,
    this.serviceTimeStart,
    this.serviceTimeEnd,
    this.serviceDays,
    this.avgRating,
    this.oneStarRatings,
    this.twoStarRatings,
    this.threeStarRatings,
    this.fourStarRatings,
    this.fiveStarRatings,
  });

  static const nouser = User(id: '', email: '', name: '');

  bool get isUser => this == User.nouser;

  bool get isNotUser => this != User.nouser;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        organization,
        serviceTypes,
        serviceTimeStart,
        serviceTimeEnd,
        serviceDays,
        avgRating,
        oneStarRatings,
        twoStarRatings,
        threeStarRatings,
        fourStarRatings,
        fiveStarRatings,
      ];
}
