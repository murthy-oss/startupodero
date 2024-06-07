import 'dart:core';

class UserModel1 {
  String? userId;
  String? name;
  String? dateOfBirth;
  String? gender;
  String? email;
  String? phoneNumber;
  String? occupation;
  String? state;
  String? district;
  String? profilePicture;
  String? bio;
  String? achievements;
  String? profession;
   String? Linkedin;
   String? Instagram;
   String? Youtube;
    String? Twitter;
    String? Facebook;
     String? GitHub;
     String? Contact; 
    String? portfolio; 
      String? Address; 
     String? website;
     String? Resume;
    bool ShowLinkedin= false; 
    bool ShowInstagram= false;
    bool ShowYoutube= false;
     bool ShowTwitter= false;
      bool ShowFacebook= false;
     bool ShowGitHub= false;
      bool ShowContact= false;
     bool ShowAddress= false;
      bool Showwebsite= false;
     bool Showportfolio= false;
      bool ShowResume= false ;

  String? instagramLink;
  String? linkedinLink;
  bool isVerified = false;
  bool showEmail = false;
  bool showPhone = false;
  bool showLinkedin = false;
  bool showInstagram = false;

  UserModel1();

  UserModel1.fromJson(Map<String?, dynamic> json)
      : userId = json['userId']??'',
        name = json['name']??'',
        dateOfBirth = json['dateOfBirth']??'',
        gender = json['gender']??'',
        email = json['email']??'',
        phoneNumber = json['phoneNumber']??'',
        occupation = json['occupation']??'',
        state = json['state']??'',
        district = json['district']??'',
        profession=json['profession']??'',
        profilePicture = json['profilePicture']??'',
        bio = json['bio']??'',
        achievements = json['achievements']??'',
        Linkedin=json['Linkedin']??'',
   
    Instagram=json['Instagram']??'',
    Youtube=json['Youtube']??'',
    Twitter=json['Twitter']??'',
    Facebook=json['Facebook']??'',
    GitHub=json['GitHub']??'',
    Contact=json['Contact']??'',
    portfolio=json['portfolio']??'',
    Address=json['Address']??'',
    website=json['website']??'',
    Resume=json['Resume']??'',
    ShowLinkedin=json['ShowLinkedin']??false,
    ShowInstagram=json['ShowInstagram']??false,
    ShowYoutube=json['ShowYoutube']??false,
    ShowTwitter=json['ShowTwitter']??false,
    ShowFacebook=json['ShowFacebook']??false,
    ShowGitHub=json['ShowGitHub']??false,
    ShowContact=json['ShowContact']??false,
    ShowAddress=json['ShowAddress']??false,
    Showwebsite=json['Showwebsite']??false,
    Showportfolio=json['Showportfolio']??false,
    ShowResume=json['ShowResume']??false,
    

        instagramLink = json['instagramLink']??'',
        linkedinLink = json['linkedinLink']??'',
        isVerified = json['isVerified'] ?? false,
        showEmail = json['showEmail'] ?? false,
        showPhone = json['showPhone'] ?? false,
        showLinkedin = json['showLinkedin'] ?? false;
}
