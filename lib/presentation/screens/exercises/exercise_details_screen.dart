import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:workout_log/presentation/styles/colors.dart';
import '../../../data/exercise.dart';
import '../../views/image_stack.dart';
import '../../widgets/default_text.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  const ExerciseDetailsScreen({Key? key, required this.exercise})
      : super(key: key);
  final Exercise exercise;

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  int targetValue = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkSkyBlue,
        title: Text(widget.exercise.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImagesStack(images: widget.exercise.images),
             ExpansionTile(
              title: const Text('Description'),
              children:descriptionWidgets(widget.exercise.description),
            )
          ],
        ),
      ),
    );
  }
}
List<Widget> descriptionWidgets(String description){
  List<Widget> widgets=[];
  List<String> lines = description.split('.');
  for(String line in lines){
    widgets.add(
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: 2.w),
        child: DefaultText(
          text: '- $line',
          fontSize: 14.sp,
          fontWeight: FontWeight.w300,
          color: darkSkyBlue,
        ),
      )
    );
  }
  return widgets;
}
