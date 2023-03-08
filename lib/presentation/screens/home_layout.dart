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
          appBar:cubit.currentIndex ==0 || cubit.currentIndex==1 ? AppBar(
            title: DefaultText(
              text: cubit.screenTitles[cubit.currentIndex],
            ),
            actions: [IconButton(onPressed: ()=>cubit.changeIndex(2), icon: Icon(Icons.search))],
            centerTitle: true,
          ) : buildSearchAppBar(),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex == 2 ? 0 : cubit.currentIndex,
            backgroundColor: Colors.transparent,
            selectedItemColor: darkSkyBlue,
            unselectedItemColor: Colors.black38,
            elevation: 20,
            type: BottomNavigationBarType.shifting,
            items:  const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books_rounded),
                  label: 'Exercises',

              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center),
                  label: 'Log',
                  ),
            ],
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
          floatingActionButton:  Visibility(
            visible: cubit.currentIndex ==1,
            child: FloatingActionButton(
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

  AppBar buildSearchAppBar() {
    return AppBar(
          centerTitle: true,
          title: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.text,
            style: TextStyle(color: darkSkyBlue),
            decoration: InputDecoration(
              label: DefaultText(text:'Search',color: darkSkyBlue,),
            ),
            onChanged: (value)  {
                Future.delayed(Duration(milliseconds: 250),() {
                  cubit.searchTerm=value;
                  cubit.searchExercises();
                },);
          },
          ),
          actions: [IconButton(onPressed: ()=>cubit.changeIndex(0), icon: Icon(Icons.close))],
        );
  }
}
