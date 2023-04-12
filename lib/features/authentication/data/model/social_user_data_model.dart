import 'package:social_app/features/authentication/domain/entites/auth.dart';

class SocialUserDataModel extends SocialDataUser {
   SocialUserDataModel({
     super.uId,
     super.firstName,
     super.surName,
     super.email,
     super.birthDate,
     super.gender,
     super.image,
     super.cover,
     super.bio,
     super.deviceToken,
  });

  factory SocialUserDataModel.fromJson(Map<String, dynamic> json) =>
      SocialUserDataModel(
        uId: json['uId'],
        firstName:  json['firstName'],
        surName:  json['surName'],
        email:  json['email'],
        birthDate:  json['birthdate'],
        gender:  json['gender'],
        image:  json['image'],
        cover:  json['cover'],
        bio:  json['bio'],
        deviceToken: json['deviceToken'],

      );


  Map<String , dynamic> toMap()
  {
    return
      {
        'uId':uId,
        'firstName':firstName,
        'surName':surName,
        'email':email,
        'birthdate':birthDate,
        'gender':gender,
        'image':image,
        'cover':cover,
        'bio':bio,
        'deviceToken':deviceToken,

      };
  }
}
