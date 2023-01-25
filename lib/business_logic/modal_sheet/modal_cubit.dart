import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:workout_log/business_logic/app_cubit.dart';
import 'package:workout_log/data/exercise.dart';

part 'modal_state.dart';

class ModalCubit extends Cubit<ModalState> {
  ModalCubit() : super(ModalInitial());
  bool muscleSelected =false;
  List<Exercise> muscleExercises =[];
  static ModalCubit get(context) => BlocProvider.of<ModalCubit>(context);
  void selectMuscle(Muscles muscle,List<Exercise> exercises){
    muscleExercises =[];
    muscleExercises.addAll(exercises);
    muscleSelected =true;
    emit(MuscleSelectedState());
  }
}
