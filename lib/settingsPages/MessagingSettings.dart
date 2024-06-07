import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:startupoderero/Theme.dart';
import 'package:startupoderero/settingsPages/Attributemethod.dart';



class messageSettingPage extends StatefulWidget {
  const messageSettingPage({super.key});

  @override
  State<messageSettingPage> createState() => _messageSettingPageState();
}

class _messageSettingPageState extends State<messageSettingPage> {
  bool send = false;
  bool media = true;
  bool archived = false;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: AppTheme.light?Colors.white:Colors.black,
      appBar: AppBar(
        foregroundColor: !AppTheme.light?Colors.white:Colors.black,
         backgroundColor: AppTheme.light?Colors.white:Colors.black,
        title: Center(
          child: Text(
            "Messaging Settings",
            style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'InterRegular',
                 color: !AppTheme.light?Colors.white:Colors.black,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.h,
          ),
          SettingsMethod('Assets/images/messages.svg', "Who can message",AppTheme.light),
          DividerMethod(
            
            
          ),
          SwitchButtonMethod(
              'Enter is send', 'Enter key will send your message', 'send',AppTheme.light),
          SwitchButtonMethod('Media downloads',
              'Download newly received media automatically', 'media',AppTheme.light),
          generalMethod('Font size', 'Medium',AppTheme.light),
          DividerMethod(),
          SwitchButtonMethod(
              'Archived chats',
              'Archived chats will remain archived when you\n receive a new message',
              'archived',AppTheme.light),
          DividerMethod(),
          SetMethod('Assets/images/chatbackup.svg','Chat backup',AppTheme.light),
          SetMethod('Assets/images/history.svg','Chat history',AppTheme.light),
          DividerMethod(),
          // GestureDetector(
          //   onTap: (){
          //     setState(() {
          //       print("///clicked///");
          //       AppTheme.light=!AppTheme.light;
          //       print(AppTheme.light);
          //       Navigator.push(
          //         context,MaterialPageRoute(builder: 
          //         (context)=>LoadingScreen('SettingTheme'),)
          //       );

          //     },
          //     );
          //   },
          //   child: SettingsMethodWithSubtitlewithArrow('Assets/images/sun.svg', "Theme",(AppTheme.light)?"Light":"Dark",AppTheme.light)),
          GestureDetector(
            onTap: (){
             print('Wall paper');
              
              
              },
            child: SettingsMethod('Assets/images/gallery.svg', "Wallpaper",AppTheme.light)),
          

          

          
        ],
      ),
    );
  }
  


  Widget SwitchButtonMethod(String title, String subtitle, String toe, bool light) {
    return Padding(
      padding: EdgeInsets.only(left: 50.w, right: 18.w, top: 12.h,bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'InterRegular',
                  color: !light?Colors.white:Colors.black,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 8.sp,
                  fontFamily: 'InterRegular',
                   color: !light?Colors.white:Colors.black,
                ),
              ),
            ],
          ),
          FlutterSwitch(
            activeColor: Colors.red,
            inactiveColor: Colors.grey,
            width: 50.0,
            height: 20.0,
            toggleSize: 30.0,
            toggleColor: Colors.white,
            value: (toe == 'send')
                ? send
                : (toe == 'media')
                    ? media
                    : archived,
            //borderRadius: 30.0,
            //padding: 8.0,
            showOnOff: false,
            onToggle: (val) {
              setState(() {
                (toe == 'send')
                    ? (send = val)
                    : (toe == 'media')
                        ? media = val
                        : archived = val;
              });
            },
          ),
        ],
      ),
    );
  }
}
