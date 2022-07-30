import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/splash_screen/splash_screen.dart';
import 'shared/bloc_observer/bloc_observer.dart';
import 'shared/cubit/app_cubit.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            titleSpacing: 20.0,
            color: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepOrange,
            elevation: 20.0,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
