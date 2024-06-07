import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'package:share/share.dart';
import 'package:startupoderero/FetchDataProvider/fetchData.dart';
import 'package:startupoderero/Models/UserFetchDataModel.dart';
import 'package:startupoderero/Theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Services/FireStoreMethod.dart';
import '../../UI-Models/feed_postUi.dart';
import '../../Widgets/TextLinkWidget.dart';
import '../../components/FolowButton.dart';
import '../../components/myButton.dart';
import '../../other/Settings Page/Settings.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';
import '../chats/chat_screen.dart';
import 'FollowerFollowingPage.dart';
import 'editProfile.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
late UserModel1 _myUser;
  @override
  void initState() {
    super.initState();
    final userFetchController =
        Provider.of<UserFetchController>(context, listen: false);
    _myUser = userFetchController.myUser;
    getStreamData();
  }

void launchURL(String url) async {
  try {
    if (!await launchUrl(Uri.parse(url))) {
      
    
      throw 'Could not launch $url';
    }
  } catch (e) {
    // Handle the error here
    // You can show a dialog to inform the user that the URL could not be opened
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Link is not working'),
          content: Text('Please check it once'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

  // void launchURL(String url) async {
  //  // ignore: deprecated_member_use
  //  if (!await launchUrl(Uri.parse(url))) {
    
  // }
  // }
  //  if (await canLaunch(url)) {
  //   try {
  //     // ignore: deprecated_member_use
  //     await launch(url);
  //   } on PlatformException catch (e) {
  //     // Show a dialog to the user explaining the failure
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text('Cannot Open URL'),
      //       content: Text('The URL could not be opened.'),
      //       actions: <Widget>[
      //         TextButton(
      //           child: Text('OK'),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
  //   }
  // } else {
  //   // Show a dialog to the user explaining the failure
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Invalid URL'),
  //         content: Text('The URL is invalid or not supported.'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  // }
  // void launchURL(String url) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url));
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  getStreamData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .snapshots()
        .listen((userDataSnapshot) {
      if (userDataSnapshot.exists) {
        userData = userDataSnapshot.data()!;
        setState(() {
          followers = userData['followers'].length;
          following = userData['following'].length;
          isFollowing = (userData['followers'] as List<dynamic>).any(
              (follower) =>
                  follower is Map<String, dynamic> &&
                  follower['uid'] == FirebaseAuth.instance.currentUser!.uid);
        });
      }
    });

    FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: widget.uid)
        .snapshots()
        .listen((postSnapshot) {
      setState(() {
        postLen = postSnapshot.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //final currentUser = FirebaseAuth.instance.currentUser;
    print('ccccccccccc${userData['userId']}ccccccccccccc');
    return Scaffold(
      appBar: AppBar(
        foregroundColor: !AppTheme.light ? Colors.white : Colors.black,
        backgroundColor: AppTheme.light ? Colors.white : Colors.black,
        actions: [
          if (FirebaseAuth.instance.currentUser!.uid == userData['userId'])
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings1(
                      image: userData['profilePicture'],
                      email: userData['email'],
                      name: userData['name'],
                    ),
                  ),
                );
              },
              icon: FaIcon(FontAwesomeIcons.cog),
            ),
        ],
        title: Text(
          "StartUp Podero",
          style: GoogleFonts.inter(),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppTheme.light ? Colors.white : Colors.black,
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
              color: Color.fromARGB(255, 244, 66, 66),
              size: 50,
            ))
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              children: [
                // Profile Picture and Name Section
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 35.r,
                              backgroundImage:
                                 userData['profilePicture']!= ''
                                ? CachedNetworkImageProvider(
                                    userData['profilePicture'] ?? '')
                                : AssetImage('Assets/images/Avatar.png')
                                    as ImageProvider<Object>,
                            ),
                            Text(
                              "${userData['name'] ?? ''}",
                              style: GoogleFonts.inter(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                  color: !AppTheme.light
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildStatColumn(postLen, "Posts"),
                            SizedBox(
                              width: 20.w,
                            ),
                            GestureDetector(
                                onTap: () =>
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return FollowFollowing1(
                                            uid: userData['userId']);
                                      },
                                    )),
                                child: buildStatColumn(followers, "Followers")),
                            SizedBox(
                              width: 20.w,
                            ),
                            GestureDetector(
                                onTap: () =>
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return FollowFollowing(
                                            uid: userData['userId']);
                                      },
                                    )),
                                child: buildStatColumn(following, "Following")),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // Bio and Additional Information Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.w),
                          child: Text(
                            userData['profession']??'',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        Row(
                          children: [],
                        ),
                        userData['bio'] != ''
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0.w),
                                child: Text(
                                  userData['bio'] ?? '',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  maxLines: 15,
                                ),
                              )
                            : SizedBox(),
                        userData['Contact'] != ''
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0.w),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 20.r,
                                    ),
                                    Text(
                                      userData['Contact']??'',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        userData['Address'] != ''
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.home,
                                    size: 20.r,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 0.w),
                                    child: Text(
                                      userData['Address']??'',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (userData['Linkedin'] != '' &&
                                userData['ShowLinkedin'] == true)
                              ImgAttributeMethod(
                                  'Linkedin',
                                  'Assets/images/linkedin.png',
                                  userData['Linkedin']),
                            if (userData['Instagram'] != '' &&
                                userData['ShowInstagram'] == true)
                              ImgAttributeMethod(
                                  'Instagram',
                                  'Assets/images/instagram.png',
                                  userData['Instagram']),
                            if (userData['Youtube'] != '' &&
                                userData['ShowYoutube'] == true)
                              ImgAttributeMethod(
                                  'Youtube',
                                  'Assets/images/youtube.png',
                                  userData['Youtube']),
                            if (userData['Twitter'] != '' &&
                                userData['ShowTwitter'] == true)
                              ImgAttributeMethod(
                                  'Twitter',
                                  'Assets/images/twitter.png',
                                  userData['Twitter']),
                            if (userData['Facebook'] != '' &&
                                userData['ShowFacebook'] == true)
                              ImgAttributeMethod(
                                  'Facebook',
                                  'Assets/images/facebook.png',
                                  userData['Facebook']),
                            if (userData['GitHub'] != '' &&
                                userData['ShowGitHub'] == true)
                              ImgAttributeMethod(
                                  'GitHub',
                                  'Assets/images/github.png',
                                  userData['GitHub']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (userData['website'] != '' &&
                                userData['Showwebsite'] == true)
                              ImgAttributeMethod('website',
                                  'Assets/images/web.png', userData['website']),
                            if (userData['portfolio'] != '' &&
                                userData['Showportfolio'] == true)
                              ImgAttributeMethod(
                                  'portfolio',
                                  'Assets/images/portfolio.png',
                                  userData['portfolio']),
                            if (userData['Resume'] != '' &&
                                userData['ShowResume'] == true)
                              ImgAttributeMethod(
                                  'Resume',
                                  'Assets/images/resume.png',
                                  userData['Resume']),
                          ],
                        ),
                        // if (userData['showEmail'] == true)
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text(
                        //       "Email: ${userData['email'] ?? ''}",
                        //       style: TextStyle(fontSize: 16, color: Colors.grey),
                        //     ),
                        //   ),

                        // if (userData['showLinkedin'] == false)
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: LinkText1(
                        //       description:
                        //           "${userData['linkedinLink'] ?? 'LinkedIn :'}",
                        //       IsShowingDes: true,
                        //     ),
                        //   ),
                        if (userData['showPhone'] == false)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LinkText1(
                              description:
                                  "${userData['phoneNumber'] ?? 'phoneNumber :'}",
                              IsShowingDes: true,
                            ),
                          ),
                        if (userData['showInstagram'] == false)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LinkText1(
                              description:
                                  "${userData['instagramLink'] ?? 'instagramLink :'}",
                              IsShowingDes: true,
                            ),
                          ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FirebaseAuth.instance.currentUser!.uid ==
                                      widget.uid
                                  ? MyButton1(
                                      text: 'Edit Profile',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfilePage(),
                                          ),
                                        );
                                      },
                                      color: Colors.red,
                                    )
                                  : isFollowing
                                      ? MyButton1(
                                          text: 'Unfollow',
                                          onTap: () =>
                                              FireStoreMethods().unfollowUser(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            userData['userId'],
                                          ),
                                          color: Colors.red,
                                        )
                                      : MyButton1(
                                          text: 'Follow',
                                          onTap: () =>
                                              FireStoreMethods().followUser(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            userData['userId'],
                                          ),
                                          color: Colors.red,
                                        ),
                              MyButton1(
                                  onTap: () {
                                    Share.share('${userData['name']}');
                                  },
                                  text: 'Share Profile',
                                  color: Colors.red)
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                Divider(),

                // User Posts Grid
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: userData['userId'])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Color.fromARGB(255, 244, 66, 66),
                        size: 50,
                      ));
                    }

                    return GridView.builder(
                      padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap = snapshot.data!.docs[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Scaffold(
                                    appBar: AppBar(
                                      title: Text(
                                        'Posts',
                                        style:
                                            GoogleFonts.inter(fontSize: 17.sp),
                                      ),
                                    ),
                                    body: PostCard(
                                      username: snap['username'],
                                      likes: snap['likes'],
                                      time: snap['datePublished'],
                                      profilePicture: snap['profImage'],
                                      image: snap['postUrl'],
                                      description: snap['description'],
                                      postId: snap['postId'],
                                      uid: snap['uid'],
                                      comments: '',
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          child: FadeInImage(
                            fadeInDuration: Duration(milliseconds: 100),
                            filterQuality: FilterQuality.high,
                            placeholder:
                                AssetImage('Assets/images/onboarding1.png'),
                            image: CachedNetworkImageProvider(
                                snap['postUrl'] ?? ''),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                ),

                SizedBox(height: 24.h),

                // Message Button
                buildMessageButton(),
              ],
            ),
    );
  }

  Widget ImgAttributeMethod(String title, String img,String link) {
    return Padding(
      padding: EdgeInsets.only(right: 25.w),
      child: GestureDetector(
        onTap: () {
          launchURL(link);
        },
        child: Image.asset(
          img,
          height: 30,
        ),
      ),
    );
  }

  Widget buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          num.toString(),
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: !AppTheme.light ? Colors.white : Colors.black),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: !AppTheme.light ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget buildMessageButton() {
    return FirebaseAuth.instance.currentUser!.uid != widget.uid
        ? MyButton1(
            onTap: () {
              createChatRoom();
            },
            text: "Message",
            color: Colors.red,
          )
        : SizedBox();
  }

  void createChatRoom() {
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    String targetUserUid = userData['userId'];
    String targetUserName = userData['name'] ?? '';
    String targetUserProfile = userData['profilePicture'] ?? '';

    // Create a unique chat room ID based on user UIDs
    String chatRoomId = currentUserUid.hashCode <= targetUserUid.hashCode
        ? '$currentUserUid-$targetUserUid'
        : '$targetUserUid-$currentUserUid';

    // Check if the chat room already exists
    FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatRoomId)
        .get()
        .then((chatRoomSnapshot) {
      if (chatRoomSnapshot.exists) {
        // Chat room already exists, navigate to chat screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              chatRoomId: chatRoomId,
              UserName: targetUserName,
              ProfilePicture: targetUserProfile,
              UId: targetUserUid,
            ),
          ),
        );
      } else {
        // Chat room doesn't exist, create and navigate to chat screen
        FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId).set({
          'users': [currentUserUid, targetUserUid],
          'createdAt': FieldValue.serverTimestamp(),
          'recentMessage': "tap to chat"
        }).then((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                chatRoomId: chatRoomId,
                UserName: targetUserName,
                ProfilePicture: targetUserProfile,
                UId: targetUserUid,
              ),
            ),
          );
        });
      }
    });
  }
}
