import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:workout_log/presentation/styles/colors.dart';
import 'package:workout_log/presentation/widgets/default_svg.dart';
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
   bool inFront =false;
   bool inBack =false;
   bool inFrontSecondary =false;
   bool inBackSecondary =false;
  @override
  void initState() {
    for(Muscles muscle in  widget.exercise.muscles){
      if(muscle.isFront){
        inFront =true;
      }
      if(!muscle.isFront){
        inBack =true;
      }
    }
    for(MusclesSecondary muscle in  widget.exercise.musclesSecondary){
      if(muscle.isFront){
        inFrontSecondary =true;
      }
      if(!muscle.isFront){
        inBackSecondary =true;
      }
    }
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
              title: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 2.w),
                child: DefaultText(
                  text: 'Description',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: darkSkyBlue,
                ),
              ),
              children:descriptionWidgets(widget.exercise.description),
            ),
             Visibility(
               visible: widget.exercise.equipment.isNotEmpty || (widget.exercise.equipment.length ==1 && widget.exercise.equipment.elementAt(0).name =='none (bodyweight exercise)'),
               child: ExpansionTile(
                  title:Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 2.w),
                    child: DefaultText(
                      text: 'Equipments',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: darkSkyBlue,
                    ),
                  ),
                children: equipmentWidgets(widget.exercise.equipment),
            ),
             ),
            ExpansionTile(
              initiallyExpanded: true,
              title: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 2.w),
              child: DefaultText(
                text: 'Main Muscles',
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: darkSkyBlue,
              ),
            ),
              children: [Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: inFront,
                    child: Stack(
                      children: frontMusclesImages(widget.exercise.muscles),
                    ),
                  ),
                  Visibility(
                    visible: inBack,
                    child: Stack(
                      children: backMusclesImages(widget.exercise.muscles),
                    ),
                  )
                ],
              )],
            ),
            Visibility(
              visible: widget.exercise.musclesSecondary.isNotEmpty,
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2.w),
                  child: DefaultText(
                    text: 'Secondary Muscles',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    color: darkSkyBlue,
                  ),
                ),
                children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: inFrontSecondary,
                      child: Stack(
                        children: frontSecondaryMusclesImages(widget.exercise.musclesSecondary),
                      ),
                    ),
                    Visibility(
                      visible: inBackSecondary,
                      child: Stack(
                        children: backSecondaryMusclesImages(widget.exercise.musclesSecondary),
                      ),
                    )
                  ],
                )],
              ),
            ),
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
List<Widget> equipmentWidgets(List<Equipment> equipments){
  List<Widget> widgets=[];
  for(Equipment equipment in equipments){
    widgets.add(Padding(
      padding:  EdgeInsets.symmetric(horizontal: 2.w),
      child: DefaultText(
        text: equipment.name,
        fontSize: 14.sp,
        fontWeight: FontWeight.w300,
        color: darkSkyBlue,
      ),
    ));
  }
  return widgets;
}
List<Widget> frontMusclesImages(List<Muscles>  muscles){
  List<Widget> widgets =[];
  widgets.add(  DefaultSVG(
      imagePath:
      'assets/images/muscles/muscular_system_front.svg'
    ,height: 40.h,
  ));
  for(Muscles muscle in muscles){
    if(muscle.isFront){
      widgets.add(
          DefaultSVG(imagePath: muscle.imageUrlMain,height: 40.h,)
      );
    }
  }
  return widgets;
}
List<Widget> backMusclesImages(List<Muscles>  muscles){
  List<Widget> widgets =[];
  widgets.add(
      DefaultSVG(
      imagePath:
      'assets/images/muscles/muscular_system_back.svg'
    ,height: 40.h,
  ));
  for(Muscles muscle in muscles){
    if(!muscle.isFront){
      widgets.add(
          DefaultSVG(imagePath: muscle.imageUrlMain,height: 40.h,)
      );
    }
  }
  return widgets;
}
List<Widget> frontSecondaryMusclesImages(List<MusclesSecondary> muscles){
  List<Widget> widgets =[];
  widgets.add(  DefaultSVG(
    imagePath:
    'assets/images/muscles/muscular_system_front.svg'
    ,height: 40.h,
  ));
  for(MusclesSecondary muscle in muscles){
    if(muscle.isFront){
      widgets.add(
          DefaultSVG(imagePath: muscle.imageUrlMain,height: 40.h,)
      );
    }
  }
  return widgets;
}
List<Widget> backSecondaryMusclesImages(List<MusclesSecondary> muscles){
  List<Widget> widgets =[];
  widgets.add(  DefaultSVG(
    imagePath:
    'assets/images/muscles/muscular_system_back.svg'
    ,height: 40.h,
  ));
  for(MusclesSecondary muscle in muscles){
    if(!muscle.isFront){
      widgets.add(
          DefaultSVG(imagePath: muscle.imageUrlMain,height: 40.h,)
      );
    }
  }
  return widgets;
}