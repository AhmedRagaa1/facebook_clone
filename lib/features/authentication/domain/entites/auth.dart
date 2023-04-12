import 'package:equatable/equatable.dart';

class SocialDataUser extends Equatable {
  final String? uId;
  final String? firstName;
  final String? surName;
  final String? email;
  final String? birthDate;
  final String? gender;
  final String? image;
  final String? cover;
  final String? bio;
  final String? deviceToken;


  const SocialDataUser({
     this.uId,
     this.firstName,
     this.surName,
     this.email,
     this.birthDate,
     this.gender,
     this.image,
     this.cover,
     this.bio,
    this.deviceToken,
  });

  @override
  List<Object?> get props =>
      [
        uId,
        firstName,
        surName,
        email,
        birthDate,
        gender,
        image,
        cover,
        bio,
        deviceToken,
      ];
}
