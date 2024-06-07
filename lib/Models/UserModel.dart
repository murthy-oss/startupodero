import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String name;
  final String dateOfBirth;
  final String gender;
  final String email;
  final String phoneNumber;
  final String occupation;
  final String state;
  final String district;
  final String profilePicture;
  final String bio;
  final String achievements;
  final String instagramLink;
  final String linkedinLink;
  final bool IsVerified;
  final String profession;
  final String Linkedin;
  final String Youtube;
  final String Twitter;
  final String Instagram;
  final String Address;
  final String Facebook;
  final String GitHub;
  final String portfolio;
  final String Contact;
  final String website;

  final String Resume;
  final bool ShowLinkedin;
  final bool ShowInstagram;
  final bool ShowYoutube;
  final bool ShowTwitter;
  final bool ShowFacebook;
  final bool ShowGitHub;
  final bool ShowContact;
  final bool ShowAddress;

final bool Showwebsite;
final bool Showportfolio;
final bool ShowResume;


  UserModel({
    required this.IsVerified,
    required this.userId,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.occupation,
    required this.state,
    required this.district,
    required this.profilePicture,
    required this.bio,
    required this.achievements,
    required this.instagramLink,
    required this.linkedinLink,
    required this.profession,
    required this.Linkedin,
    required this.Youtube,
    required this.Twitter,
    required this.Instagram,
    required this.Address,
    required this.Facebook,
    required this.GitHub,
    required this.portfolio,
    required this.Contact,
    required this.website,
    required this.Resume,
    required this.ShowLinkedin,
    required this.ShowInstagram,
    required this.ShowYoutube,
    required this.ShowTwitter,
    required this.ShowFacebook,
    required this.ShowGitHub,
    required this.ShowContact,
    required this.ShowAddress,
    required this.Showwebsite,
    required this.Showportfolio,
    required this.ShowResume,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    print("sjnckjnjisdncn${data}cuhdsyuuchsh");
    return UserModel(
      userId: snapshot.id,
      name: data['name'] ?? '',
      dateOfBirth: data['dateOfBirth'] ?? '',
      gender: data['gender'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      occupation: data['occupation'] ?? '',
      state: data['state'] ?? '',
      district: data['district'] ?? '',
      profilePicture: data['profilePicture'] ?? '',
      bio: data['bio'] ?? '',
      achievements: data['achievements'] ?? '',
      instagramLink: data['instagramLink'] ?? '',
      linkedinLink: data['linkedinLink'] ?? '',
      IsVerified: false, 
      profession: data['profession']??'', 
      Linkedin: data['Linkedin']??'',
       Youtube:data['Youtube']??'',
    Twitter:data['Twitter']??'',
    Instagram:data['Instagram']??'',
    Address:data['Address']??'',
    Facebook:data['Facebook']??'',
    GitHub:data['GitHub']??'',
    portfolio:data['portfolio']??'',
    Contact:data['Contact']??'',
    website:data['website']??'',
    Resume:data['Resume']??'',
    ShowLinkedin:data['ShowLinkedin']??false,
    ShowInstagram:data['ShowInstagram']??false,
    ShowYoutube:data['ShowYoutube']??false,
    ShowTwitter:data['ShowTwitter']??false,
    ShowFacebook:data['ShowFacebook']??false,
    ShowGitHub:data['ShowGitHub']??false,
    ShowContact:data['ShowContact']??false,
    ShowAddress:data['ShowAddress']??false,
    Showwebsite:data['Showwebsite']??false,
    Showportfolio:data['Showportfolio']??false,
    ShowResume:data['ShowResume']??false,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'email': email,
      'phoneNumber': phoneNumber,
      'occupation': occupation,
      'state': state,
      'district': district,
      'profilePicture': profilePicture,
      'bio': bio,
      'achievements': achievements,
      'instagramLink': instagramLink,
      'linkedinLink': linkedinLink,
     'profession':profession,
  'Linkedin':Linkedin,
  'Youtube':Youtube,
  'Twitter':Twitter,
  'Instagram':Instagram,
  'Address':Address,
  'Facebook':Facebook,
  'GitHub':GitHub,
  'portfolio':portfolio,
  'Contact':Contact,
  'website':website,
  'Resume':Resume,
  'ShowLinkedin':ShowLinkedin,
  'ShowInstagram':ShowInstagram,
  'ShowYoutube':ShowYoutube,
  'ShowTwitter':ShowTwitter,
  'ShowFacebook':ShowFacebook,
  'ShowGitHub':ShowGitHub,
  'ShowContact':ShowContact,
  'ShowAddress':ShowAddress,
  'Showwebsite':Showwebsite,
  'Showportfolio':Showportfolio,
  'ShowResume':ShowResume,
    };
  }

  @override
  String toString() {
    return 'UserModel{userId: $userId, name: $name, email: $email, '
        'profilePicture: $profilePicture, dateOfBirth: $dateOfBirth, '
        'phoneNumber: $phoneNumber}';
  }
}
