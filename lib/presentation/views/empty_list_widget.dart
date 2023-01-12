import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';
import '../widgets/default_text.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 60.w,
        height: 60.h,
        child: Center(
          child: DefaultText(
            text: 'No Workout Added Yet',
            fontSize: 16.sp,
            color: darkSkyBlue,
            fontWeight: FontWeight.w300,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}