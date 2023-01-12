// ignore_for_file: depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart' as p;
import 'package:workout_log/presentation/widgets/default_error_widget.dart';
import '../../data/exercise.dart';
import '../styles/colors.dart';
import '../widgets/default_text.dart';

class ImagesStack extends StatefulWidget {
  const ImagesStack({Key? key, required this.images}) : super(key: key);
  final List<Images> images;

  @override
  State<ImagesStack> createState() => _ImagesStackState();
}

class _ImagesStackState extends State<ImagesStack> {
  int targetValue = 1;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.images.isNotEmpty,
      replacement: SizedBox(
          width: 100.w,
          height: 40.h,
          child: const Center(child: Text('No Images For this exercise'))),
      child: Stack(
        children: [
          IndexedStack(
            index: widget.images.length == 1 ? 0 : targetValue,
            children: slideShowWidgets(
              images: widget.images,
              onTap: () {
                setState(() {
                  targetValue = targetValue == 1 ? 0 : 1;
                });
              },
            ),
          ),
          Positioned(
            bottom: 1.sp,
            right: 1.sp,
            child: Visibility(
              visible: (widget.images.isNotEmpty &&
                      p.extension(widget.images.elementAt(0).image) !=
                          '.gif') &&
                  widget.images.length != 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12,
                ),
                padding: EdgeInsets.all(5.sp),
                width: 50.w,
                height: 4.h,
                child: DefaultText(
                  textAlign: TextAlign.center,
                  text: 'Tap for more images',
                  color: darkSkyBlue,
                  fontSize: 10.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> slideShowWidgets(
    {required List<Images> images, required VoidCallback onTap}) {
  List<Widget> imagesWidgets = [];

  for (Images image in images) {
    imagesWidgets.add(GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: image.image,
        width: 100.w,
        height: 40.h,
        progressIndicatorBuilder: (context, url, progress) =>  SizedBox(
          width: 100.w,
          height: 40.h,
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) =>const DefaultErrorWidget(),
      ),
    ));
  }
  return imagesWidgets;
}
/**
Image.network(

image.image,
)
    **/
