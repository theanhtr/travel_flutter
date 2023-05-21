import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app_ytb/representation/models/comment_model.dart';

class ReviewsModel {
  double? ratingAverage;
  int? countRating;
  int? oneStarRating;
  int? twoStarRating;
  int? threeStarRating;
  int? fourStarRating;
  int? fiveStarRating;
  List<CommentModel>? reviews;

  ReviewsModel({
    this.ratingAverage,
    this.countRating,
    this.oneStarRating,
    this.twoStarRating,
    this.threeStarRating,
    this.fourStarRating,
    this.fiveStarRating,
    this.reviews,
  });
}
