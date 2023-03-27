import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled19/view/components/recommendation.dart';
import 'package:untitled19/viewModel/network/endPoints.dart';
import 'package:untitled19/viewModel/cubit/movie_cubit/movesState.dart';
import 'package:untitled19/viewModel/cubit/movie_cubit/moviesCubit.dart';

import '../../model/recommendatioModel.dart';

class MovieDetails extends StatelessWidget {
  int id;
   MovieDetails({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: MoveCubit.get(context)..getMovieByID(id)..getRecommendedMovie(id),
      child: BlocConsumer<MoveCubit, MoveState>(
          builder: (context, state) {
            var cubit=MoveCubit.get(context);
            double rate=cubit.movieMode!.voteAverage!-5;
            if (state is MovieModelSuccess || state is RecommendationSuccess){
            return
              Scaffold(
              backgroundColor: Colors.black,
              extendBody: true,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: state is MovieModelLoading ? Center(child: CircularProgressIndicator(),) :
              SingleChildScrollView( scrollDirection: Axis.vertical,
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Hero(tag: cubit.movieMode?.id ??0,
                          child: Image.network( "$imagePath${cubit.movieMode?.posterPath?? ""}")),
                         ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(cubit.movieMode?.title?? "",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:  Row(
                          children: [
                            RatingBar.builder(
                              initialRating: rate,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20,
                              unratedColor: Colors.grey,
                              // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("${cubit.movieMode?.voteAverage}",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("description",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(cubit.movieMode?.overview??"",style: TextStyle(color: Colors.white),),
                    ),
                    SizedBox(height: 10,),
                  Text("Recommendation",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  Container( margin: EdgeInsets.all(15),
                    color: Colors.black38,height: 400,
                    child:
                    //SingleChildScrollView( scrollDirection: Axis.horizontal,
                      //child: Row(children: [
                       ListView.builder(
                            physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                        itemCount: cubit.recommendedMovie?.results?.length ?? 1,
                          itemBuilder: (context,index){
                        return Recommendation(results: cubit.recommendedMovie!.results![index],);
                      }),
                        
                      )
                            // ],),)
            ],
              ),),
            );}
            if(state is MovieModelLoading || state is RecommendationLoading){
              return Scaffold(body: Center(child: CircularProgressIndicator(),),);
            } return Scaffold();
          },
          listener: (context, state) {}),
    );
  }
}
