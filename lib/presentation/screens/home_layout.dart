import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/app_cubit.dart';
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
          backgroundColor: blue.withOpacity(0.6),
          appBar: AppBar(
            backgroundColor: darkSkyBlue,
            title: DefaultText(
              text: cubit.screenTitles[cubit.currentIndex],
              color: Colors.black87,
            ),
            centerTitle: true,
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black38,
            elevation: 20,
            type: BottomNavigationBarType.shifting,
            items:  const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books_rounded),
                  label: 'Exercises',
                  backgroundColor: darkSkyBlue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center),
                  label: 'Log',
                  backgroundColor: darkSkyBlue),
            ],
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
