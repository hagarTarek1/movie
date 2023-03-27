import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/model/moveModel.dart';
import 'package:untitled19/model/recommendatioModel.dart';
import 'package:untitled19/viewModel/network/dioHelper.dart';
import 'package:untitled19/viewModel/network/endPoints.dart';
import '../../network/endPoints.dart';
import '../../network/endPoints.dart';
import 'movesState.dart';

class MoveCubit extends Cubit<MoveState> {
  late List<Movie> searchMovie=[];
  final searchController=TextEditingController();
  bool isSearching=false;
  MovieModel? movieModel;
  RecommenditionModel? recommendedMovie;

  MoveCubit() : super(InitState());

  static MoveCubit get(context) => BlocProvider.of<MoveCubit>(context);

  popularMovies() {
    DioHelper.get(path: "$movie/$popular").then((value) {
      movieModel = MovieModel.fromJson(value.data);
      emit(PopularMoviesSuccess());
    });
  }
  Movie? movieMode;
  getMovieByID (int id){
    emit(MovieModelLoading());
    DioHelper.get(path: "$movie/$id").then((value) {
      movieMode = Movie.fromJson(value.data);
      emit(MovieModelSuccess());
    });
  }
   addSearchToList (String searchedMovies){
    searchMovie = movieModel!.movies!.where((element) =>  element.title!.toLowerCase().startsWith(searchedMovies)).toList();
    emit(SearchSuccess());
  }
  clearSearch (){
    searchController.clear();
  }
  getRecommendedMovie(int id){
    DioHelper.get(path: "$movie/$id/$recommendations").then((value) {
      recommendedMovie = RecommenditionModel.fromJson(value.data);
  print(value.data.toString());
  emit(RecommendationSuccess());
    });}



}
