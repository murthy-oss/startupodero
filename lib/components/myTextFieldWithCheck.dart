import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startupoderero/Theme.dart';


class MyTextFieldWithCheck extends StatefulWidget {
  final String hint;
  final bool obscure;
  final bool selection;
  final FocusNode? focusNode;
  final TextEditingController controller;
   final bool check;
  final void Function()? onCheckChanged;
  final IconData? suffixIcon; // Make suffixIcon optional
  final autofillhints;
  final FormFieldValidator<String>? validator; // Add validator
  final TextInputType keyboardtype;
  final Color? fillcolor;
  const MyTextFieldWithCheck({
    Key? key,
    required this.controller,
    required this.hint,
    required this.obscure,
    required this.selection,
    required this.check,
    this.focusNode,
     
    this.suffixIcon,
    this.autofillhints,
    this.validator,
    required this.keyboardtype,
    required this.onCheckChanged,
    this.fillcolor, // Add validator parameter
// Update suffixIcon to be optional
  }) : super(key: key);

  @override
  _MyTextFieldWithCheckState createState() => _MyTextFieldWithCheckState();
}

class _MyTextFieldWithCheckState extends State<MyTextFieldWithCheck> {
  bool _obscureText = false;
  

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    //  padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
       // color: AppTheme.light?Colors.white:Colors.black,
      ),
      width: double.infinity,
    // height: 55.h,
      child: Row(
        children: [
          Padding(
            padding:  EdgeInsets.only(bottom: 20.h),
            child: AutofillGroup(
              child: TextFormField(
                  validator: widget.validator, // Set the validator
          
                  autofillHints: widget.autofillhints,
                  obscureText: _obscureText,
                  keyboardType: widget.keyboardtype,
                  decoration: InputDecoration(
                    //focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.all(10.w),
                    hintText: widget.hint,
                    
                 hintStyle:   
                 TextStyle(
                       fontFamily: 'InterRegular',
                     color: !AppTheme.light?Colors.white:Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400
                      
                      ),
                    //prefixIcon: Icon(widget.preIcon),
                    suffixIcon: widget.suffixIcon != null
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          )
                        : null,
                   
                   
                                  border: OutlineInputBorder(
                                     borderSide: BorderSide(
                                    color: AppTheme.light?Colors.white:Colors.black, // Specify the border color here
                                    // width: 2.0, // Specify the border width here
                                  ),
                                  borderRadius: BorderRadius.circular(8.0.r),),
                  ),
                  controller: widget.controller,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                  color:  !AppTheme.light?Colors.white:Colors.black,
          
                  )),
            ),
          ),
           Checkbox(
                        value: !widget.check,
                        onChanged:(value)=> widget.onCheckChanged,
             
                      ),
        ],
      ),
    );
  }
}
