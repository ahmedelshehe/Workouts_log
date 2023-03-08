import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../widgets/default_text.dart';
class SetInputColumn extends StatelessWidget {
  const SetInputColumn({
    Key? key,
    required this.controller, required this.labelText,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultText(text:labelText,fontWeight: FontWeight.w500,color: Colors.black45,),
        SizedBox(height: 3.sp,),
        Container(
          width: 15.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.sp),
            color: Colors.black12,
          ),
          child: TextFormField(
            autofocus: false,
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration:const  InputDecoration(
                hintText: '0',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                errorStyle: TextStyle(height: 0),
            ),

            validator: (value){
              if(value!.isEmpty){
                Fluttertoast.showToast(
                    msg: "$labelText is  Empty",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Colors.blue,
                    fontSize: 16.sp
                );
                return '';
              }else if(value == '0'){
                Fluttertoast.showToast(
                    msg: "$labelText is zero",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.white,
                    textColor: Colors.blue,
                    fontSize: 16.sp

                );
                return '';
              }
              else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }
}