import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:workout_log/presentation/router/app_router.dart';
import 'business_logic/app_cubit.dart';
import 'business_logic/workout/workout_cubit.dart';
import 'constants/bloc_observer.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AppRouter appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => WorkoutCubit(),
        ),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Workouts Log',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          onGenerateRoute: appRouter.onGenerateRoute,
        );
      }),
    );
  }
}
