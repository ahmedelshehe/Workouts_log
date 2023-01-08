import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'default_text.dart';

class DefaultErrorWidget extends StatelessWidget {
  const DefaultErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100.w,
        height: 85.h,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 50.sp,
              ),
               DefaultText(text: 'Something Went Wrong',fontSize: 16.sp,color: Colors.black,)
            ],
          ),
        ));
  }
}
