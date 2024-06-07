import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/myButton.dart';


class ReportPostScreen extends StatelessWidget {
  final String uid;
  final String postId;
  ReportPostScreen({required this.uid,required this.postId});
  TextEditingController _reportController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true
        ,
        title: Text('Report Post',style: GoogleFonts.inter(color: Colors.black,fontSize: 18.sp),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Report the post',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Why are you reporting this post?',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TextFormField(
                controller: _reportController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Enter your reason for reporting...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
              MyButton3(onTap: ()async {
              await FirebaseFirestore.instance.collection('reports').add({
                'report':_reportController.text,
                'uid':uid,
                'postID':postId,
              });
              _reportController.clear();
            }, text: 'Submit Report', color: Colors.white, textcolor: Colors.red,)
          ],
        ),
      ),
    );
  }
}
