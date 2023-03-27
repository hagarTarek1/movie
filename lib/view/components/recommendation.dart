import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/view/screens/movieDetails.dart';
import 'package:untitled19/viewModel/cubit/movie_cubit/movesState.dart';
import 'package:untitled19/viewModel/cubit/movie_cubit/moviesCubit.dart';

import '../../model/recommendatioModel.dart';
import '../../viewModel/network/endPoints.dart';
class Recommendation extends StatelessWidget {
  Results? results;
  Recommendation({required this.results,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoveCubit, MoveState>(builder: (context, state) {
      var cubit = MoveCubit.get(context);
      return
      Padding(
        padding: const EdgeInsets.only(
          right: 5,left: 5
        ),
        child: InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> MovieDetails(id: cubit.recommendedMovie?.results?[0].id ?? 0)));},
          child: Column(children: [
            Image.network(
                "$imagePath${results?.posterPath?? ""}",fit:BoxFit.cover,height: 150,),
            SizedBox(height: 15,),
            Text(results?.title?? "",style: TextStyle(color: Colors.white),)
          ],),
        ),
      );
    }
        , listener: (context, state) {});
  }
}
