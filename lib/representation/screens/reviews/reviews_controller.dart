import 'dart:convert';

import 'package:jiffy/jiffy.dart';
import 'package:travel_app_ytb/representation/models/reviews_model.dart';

import '../../../helpers/http/base_client.dart';
import '../../../helpers/loginManager/login_manager.dart';
import '../../models/comment_model.dart';

class ReviewsController {
  Future<ReviewsModel> getReviews(int id) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .get('/reviews/all-hotel-review/$id')
        .catchError((onError) {
      return onError;
    });
    if (response == null) {
      return ReviewsModel();
    }
    Map dataResponse = await json.decode(response);
    final listComment = dataResponse['data']['reviews'] as List;
    List<CommentModel> listCommentModel = [];
    for (var element in listComment) {
      List<String> listImageDetailPath = [];
      for (var elementI in element['images']) {
        listImageDetailPath.add(elementI['path']);
      }
      listCommentModel.add(CommentModel(
        id: element['id'],
        comment: element['comment'],
        starRating: element['star_rating'],
        countLike: element['count_like'],
        countDislike: element['count_dislike'],
        userId: element['user_id'],
        hotelId: element['hotel_id'],
        typeRoomId: element['type_room_id'],
        typeRoomName: element['type_room_name'],
        userName: element['user_name'],
        userAvatar: element['user_avatar'],
        listImageDetailPath: listImageDetailPath,
        updatedAt: Jiffy.parse(element['updated_at']).fromNow(),
        isLike: element['is_like'],
        isReport: element['is_report'],
      ));
    }
    final startInfo = dataResponse['data']['rating_average'].runtimeType == int
        ? dataResponse['data']['rating_average'] as int
        : dataResponse['data']['rating_average'] as double;
    return ReviewsModel(
      ratingAverage: startInfo.toDouble(),
      countRating: dataResponse['data']['count_rating'],
      oneStarRating: dataResponse['data']['one_star_rating'],
      twoStarRating: dataResponse['data']['two_star_rating'],
      threeStarRating: dataResponse['data']['three_star_rating'],
      fourStarRating: dataResponse['data']['four_star_rating'],
      fiveStarRating: dataResponse['data']['five_star_rating'],
      reviews: listCommentModel,
    );
  }
  Future<bool> likeReview(String reviewId, String status) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .post('/reviews/like', {
          "review_id": reviewId,
          "status": status,
        })
        .catchError((onError) {
      return false;
    });
    if (response == null) {
      return false;
    }
    return true;
  }
  Future<bool> reportReview(String reviewId) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .post('/reviews/report', {
          "review_id": reviewId,
        })
        .catchError((onError) {
      return false;
    });
    if (response == null) {
      return false;
    }
    
    return true;
  }
}