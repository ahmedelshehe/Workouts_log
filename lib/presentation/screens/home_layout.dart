import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/app_cubit.dart';
import '../../constants/screens.dart';
import '../styles/colors.dart';
import '../widgets/default_text.dart';


class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late AppCubit cubit;

  @override
  void initState() {
    cubit = AppCubit.get(context);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: false,
          appBar: AppBar(
            backgroundColor: darkSkyBlue,
            title: DefaultText(
              text: cubit.screenTitles[cubit.currentIndex],
              color: Colors.white,
            ),
            centerTitle: true,
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black38,
            elevation: 20,
            type: BottomNavigationBarType.shifting,
            items:  const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books_rounded),
                  label: 'Exercises',
                  backgroundColor: darkSkyBlue,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center),
                  label: 'Log',
                  backgroundColor: darkSkyBlue),
            ],
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
          floatingActionButton:  Visibility(
            visible: cubit.currentIndex ==1,
            child: FloatingActionButton(
              backgroundColor: darkSkyBlue,
              onPressed: (){
                Navigator.of(context)
                    .pushNamed(addWorkoutScreen);
              },
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
