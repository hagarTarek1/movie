import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled19/model/moveModel.dart';
import 'package:untitled19/viewModel/cubit/movie_cubit/movesState.dart';
import 'package:untitled19/viewModel/cubit/movie_cubit/moviesCubit.dart';
import 'package:untitled19/viewModel/network/endPoints.dart';
import 'package:untitled19/view/screens/movieDetails.dart';

class HomeDetails extends StatelessWidget {
  Movie? movies;
   HomeDetails({required this.movies,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     double rating=movies!.voteAverage!-5;
    return BlocConsumer<MoveCubit, MoveState>(
        builder: (context, state) {
          return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MovieDetails(id: movies?.id ?? 0,)));
              },
              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Hero(tag: movies?.id ??0,
                      child: Image.network( "$imagePath${movies?.posterPath?? ""}"
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: rating,
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
                      Text(
                        "${movies?.voteAverage}",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                   movies?.title?? "",
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  )
                ],
              ));
        },
        listener: (context, state) {});
  }
}
