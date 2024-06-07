import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:startupoderero/Theme.dart';


import '../../Screen/job_Screen/CreateJob.dart';
import '../../Screen/job_Screen/appliedJob.dart';
import '../../Screen/job_Screen/postedjob.dart';
import '../../UI-Models/JobPostModel.dart';


class JobTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.light?Colors.white:Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        elevation: 4,
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return SlideTransition(
                  
                  position: Tween<Offset>(
                    begin: Offset(1.0, 0.0), // Slide from right to left
                    end: Offset.zero,
                  ).animate(animation),
                  child: JobPostingPage(),
                );
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
           color: AppTheme.light?Colors.white:Colors.black
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 250),
                        pageBuilder: (BuildContext context, Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(1.0, 0.0), // Slide from right to left
                              end: Offset.zero,
                            ).animate(animation),
                            child: AppliedJobsPage(),
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 40.h,
                    child: Center(
                        child: Text(
                          'Applied Jobs',
                          style: GoogleFonts.poppins(color: Colors.white,
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                GestureDetector(onTap: () =>     Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 200),
                    pageBuilder: (BuildContext context, Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(1.0, 0.0), // Slide from right to left
                          end: Offset.zero,
                        ).animate(animation),
                        child: PostedJobsPage(),
                      );
                    },
                  ),
                ) ,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 40.h,
                    child: Center(
                        child: Text(
                          'Posted Jobs',
                          style: GoogleFonts.poppins(color: Colors.white,
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                FirebaseFirestore.instance.collection('jobs').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child:  LoadingAnimationWidget.staggeredDotsWave(
                      color: Color.fromARGB(255, 244, 66, 66),
                      size:50,
                    ));
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final jobDocs = snapshot.data!.docs;
                if(jobDocs.length>0) { return ListView.builder(
                    itemCount: jobDocs.length,
                    itemBuilder: (context, index) {
                      final jobData =
                      jobDocs[index].data() as Map<String, dynamic>;

                      if (jobData['jobStatus'] == 'Accepted') {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: JobUICard(
                            jobTitle: jobData['jobTitle'],
                            description: jobData['description'],
                            location: jobData['location'],
                            salary: jobData['salary'],
                            experience: jobData['experience'],
                            companyName: jobData['companyName'],
                            jobPosted: jobData['jobPosted'],
                            skillRequired: jobData['skillsRequired'],
                            aboutJob: jobData['aboutJob'],
                            aboutCompany: jobData['aboutCompany'],
                            whoCanApply: jobData['eligibility'],
                            numberOfOpenings: jobData['openings'],
                            JobID: jobData['JobId'],
                            JobStatus: jobData['jobStatus'],
                          ),
                        );
                      } 
                      else {
                        return Center(
                          child: Text("Your Job in Progress",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp
                          ),
                          ),
                        );
                      }
                     
                    }
                  );
                  }
                  else{
                  return Center(
                    child: Text("No Job Added"),
                  );
                }
                },
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
