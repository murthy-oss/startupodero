import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:startupoderero/Theme.dart';


import '../Screen/profile/profilePage.dart';
import '../Services/FireStoreMethod.dart';
import '../utils/utils.dart';

class CommentCard extends StatelessWidget {
  final snap;
  final uid;
  final postId;
  const CommentCard({Key? key, required this.snap, required this.postId, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: snap.data()['profilePic']!=""?
            CachedNetworkImageProvider(
              snap.data()['profilePic'],
            ):AssetImage('Assets/images/Avatar.png')
                      as ImageProvider<Object>?,
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      GestureDetector(
                        onTap:() =>  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(uid: uid),)),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width/1.55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snap.data()['name'],
                                style: GoogleFonts.roboto(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                               color: !AppTheme.light?Colors.white:Colors.black
                          
                                ),
                              ),
                              Text(
                                snap.data()['text'],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                                 color: !AppTheme.light?Colors.white:Colors.black
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  DateFormat.yMMMd().format(
                                    snap.data()['datePublished'].toDate(),
                                  ),
                                  style:  TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                              color: !AppTheme.light?Colors.white:Colors.black
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if(snap.data()['uid'].toString()==FirebaseAuth.instance.currentUser!.uid)
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title:  Text('Delete Comment?',
                                style: TextStyle(
                                   color: !AppTheme.light?Colors.white:Colors.black
                                ),
                                ),
                                content:  Text('Are you sure you want to delete this comment?',
                                style: TextStyle(
                                   color: !AppTheme.light?Colors.white:Colors.black
                                ),),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      String result = await FireStoreMethods().deleteComment(
                                        postId, // Provide postId
                                        snap.data()['commentId'], // Assuming commentId is stored in Firestore
                                      );
                                      if (result == 'success') {
                                        Navigator.pop(context); // Close the dialog
                                      } else {
                                        showSnackBar(context, result); // Show error message
                                      }
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete),
                        ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
