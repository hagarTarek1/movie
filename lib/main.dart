import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import 'view/screens/homeScreen.dart';
import 'viewModel/cubit/movie_cubit/moviesCubit.dart';
import 'viewModel/network/dioHelper.dart';


void main() {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MoveCubit()..popularMovies()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
