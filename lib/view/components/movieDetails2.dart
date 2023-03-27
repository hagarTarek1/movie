import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/viewModel/cubit/movie_cubit/movesState.dart';
import 'package:untitled19/viewModel/cubit/movie_cubit/moviesCubit.dart';

class MovieDetails2 extends StatelessWidget {
   MovieDetails2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<MoveCubit,MoveState>(builder: (context,state){
      var cubit=MoveCubit.get(context);
      return Row(
        children: [

          Container( width: 300,
            child:
            TextFormField( onChanged: (searchedMovies){
              cubit.addSearchToList(searchedMovies);
            },
              controller: cubit.searchController,
            style: TextStyle(color: Colors.white),
            decoration:
            InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white12,
            enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(20)),
            label: Text("Search",
            style: TextStyle(color: Colors.white))),),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            backgroundColor: Colors.white12,
            child: Icon(
              Icons.filter_alt_outlined,
              color: Colors.white,
            ),
          ),
        ],
      );
    }, listener: (context,state){});
  }
}
