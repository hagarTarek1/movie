import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/view/components/movieDetails2.dart';
import 'package:untitled19/view/components/movie_widget.dart';
import 'package:untitled19/viewModel/cubit/movie_cubit/movesState.dart';
import 'package:untitled19/viewModel/cubit/movie_cubit/moviesCubit.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoveCubit, MoveState>(
      builder: (context, state) {
        var cubit=MoveCubit.get(context);
        if (state is PopularMoviesLoading){
          return Scaffold(body: Center(child: CircularProgressIndicator(),),);
        }
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              "moves Cubit",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
               MovieDetails2(),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(15)),
                    child: GridView.count(
                      childAspectRatio: 9 / 16,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: List.generate(
                        cubit.searchController.text.isEmpty?
                          cubit.movieModel!.movies!.length
                              :
                          cubit.searchMovie.length,
                              (index) { return HomeDetails(movies:
                      cubit.searchController.text.isEmpty?
                      cubit.movieModel!.movies![index]
                                      :
                      cubit.searchMovie[index],
                              );}
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );}
      ,
      listener: (context, state) {},
    );
  }
}
