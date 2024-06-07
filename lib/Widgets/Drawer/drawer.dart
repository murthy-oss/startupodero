import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:provider/provider.dart';
import 'package:startupoderero/LoadingScreen.dart';
import 'package:startupoderero/Screen/job_Screen/CreateJob.dart';
import 'package:startupoderero/Services/AuthFunctions.dart';
import 'package:startupoderero/Theme.dart';
import 'package:startupoderero/other/Settings%20Page/Settings.dart';
import '../../Auth/SignUp.dart';
import '../../FetchDataProvider/fetchData.dart';
import '../../Screen/event_Screen/CreateEvent.dart';
import '../../Screen/profile/profilePage.dart';
import '../../other/InvitePage.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      width: 250.w,
      child: Container(
        
        decoration: BoxDecoration(
          
          color: AppTheme.light?Colors.white:Colors.black,),
        child: Consumer<UserFetchController>(
          builder: (context, userFetchController, _) {
            print("hjzdxbkjncv${userFetchController.isDataFetched}ugyjuybhj");
            if (userFetchController.isDataFetched) {
              var myUser = userFetchController.myUser;
              print('aaaaaaaa${myUser.profilePicture}aaaaaaaaaaaaaa');
              return ListView(
                children: [
                  DrawerHeader(
                    padding: EdgeInsets.zero, // Remove default padding
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0), // Adjust padding as needed
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0), // Add padding to the CircleAvatar
                            child: CircleAvatar(
                              backgroundImage: myUser.profilePicture != ''
                                  ? CachedNetworkImageProvider(
                                      myUser.profilePicture!)
                                  : AssetImage('Assets/images/Avatar.png')
                                      as ImageProvider<Object>,
                              radius: 26.r,
                            ),
                          ),
                          Text(
                            myUser.name!,
                            style: GoogleFonts.inter(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: !AppTheme.light?Colors.white:Colors.black54,
                            ),
                          ),
                          SizedBox(
                              height:
                                  3), // Add some space between the name and email
                          Text(
                            myUser.email!,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                              color: !AppTheme.light?Colors.white:Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        FaIcon(FontAwesomeIcons.user,
                        color: !AppTheme.light?Colors.white:Colors.black,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          'Account',
                          style: GoogleFonts.inter(
                              fontSize: 18.sp, fontWeight: FontWeight.w600,
                              color:!AppTheme.light?Colors.white:Colors.black
                              ),
                            
                        ),
                      ],
                    ),
                    onTap: () {
                      print(myUser.phoneNumber);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                         // print(object)
                         print('bbbbbbbbbbb${myUser.userId}bbbbbbbbbbbb');
                          return ProfileScreen(uid: myUser.userId.toString()??'');
                        },
                      ));
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        FaIcon(Clarity.event_outline_alerted,
                        color: !AppTheme.light?Colors.white:Colors.black,
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Create Event',
                          style: GoogleFonts.inter(
                              fontSize: 18.sp, fontWeight: FontWeight.w600,
                              color:!AppTheme.light?Colors.white:Colors.black
                              ),
                              
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CreateEventPage();
                        },
                      ));
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                   ListTile(
                    title: Row(
                      children: [
                        FaIcon(Clarity.add_text_line,
                        color: !AppTheme.light?Colors.white:Colors.black,
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Create Job',
                          style: GoogleFonts.inter(
                              fontSize: 18.sp, fontWeight: FontWeight.w600,
                              color:!AppTheme.light?Colors.white:Colors.black
                              ),
                              
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return JobPostingPage();
                        },
                      ));
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        FaIcon(Bootstrap.people,
                        color:!AppTheme.light?Colors.white:Colors.black
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Invite Friends',
                          style: GoogleFonts.inter(
                              fontSize: 18.sp, fontWeight: FontWeight.w600,
                              
                              color:!AppTheme.light?Colors.white:Colors.black),
                              
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(
                              milliseconds: 500), // Adjust duration as needed
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const InvitePage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(
                              CurveTween(curve: curve),
                            );

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        FaIcon(FontAwesomeIcons.questionCircle,
                       color:!AppTheme.light?Colors.white:Colors.black 
                        ),
                        SizedBox(width: 15),
                        Text(
                          'About Us',
                          style: GoogleFonts.inter(
                              fontSize: 18.sp, fontWeight: FontWeight.w600,
                              color:!AppTheme.light?Colors.white:Colors.black
                              ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return FAQ_Page();
                      // },));
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                 
                  SizedBox(
                    height: 5.h,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        FaIcon(Clarity.settings_line,
                        color:!AppTheme.light?Colors.white:Colors.black
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Settings',
                          style: GoogleFonts.inter(
                              fontSize: 18.sp, fontWeight: FontWeight.w600,
                              color:!AppTheme.light?Colors.white:Colors.black

                              ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Settings1(image: myUser.profilePicture!, email: myUser.email!, name: myUser.name!);
                      },));
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                   ListTile(
                    title: Row(
                      children: [
                        FaIcon(Clarity.help_outline_badged,
                        color:!AppTheme.light?Colors.white:Colors.black
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Help/Support',
                          style: GoogleFonts.inter(
                              fontSize: 18.sp, fontWeight: FontWeight.w600,
                              color:!AppTheme.light?Colors.white:Colors.black
                              ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return TermsAndConditionsPage();
                      // },));
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        FaIcon(PixelArtIcons.logout,
                              color:!AppTheme.light?Colors.white:Colors.black
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Log out',
                          style: GoogleFonts.inter(
                              fontSize: 18.sp, fontWeight: FontWeight.w600,
                              color:!AppTheme.light?Colors.white:Colors.black
                              
                              ),
                        ),
                      ],
                    ),
                    onTap: () {
                     // AuthService.logout();
                      AuthService.signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return LoadingScreen('logouttoHome');
                        },
                      ));
                    },
                  ),
                  Divider(
                    
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                               AppTheme.light=!AppTheme.light;
                                print(AppTheme.light);
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>LoadingScreen('Refresh')));
                            });
                           
                          },
                          icon: FaIcon(
                            AppTheme.light?Bootstrap.sun:Bootstrap.moon,
                            color: Colors.red,
                            size: 30,
                          )),
                    ),
                  )
                ],
              );
            } else {
              // Show a loading indicator or placeholder while user data is being fetched
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
