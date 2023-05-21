import 'package:google_maps_flutter/google_maps_flutter.dart';

class CommentModel {
  int? id;
  String? comment;
  int? starRating;
  int? countLike;
  int? countDislike;
  int? userId;
  int? hotelId;
  int? typeRoomId;
  String? typeRoomName;
  String? userName;
  String? userAvatar;
  String? updatedAt;
  List<String>? listImageDetailPath;
  int? isLike;
  int? isReport;

  CommentModel({
    this.id,
    this.comment,
    this.starRating,
    this.countLike,
    this.countDislike,
    this.userId,
    this.hotelId,
    this.typeRoomId,
    this.typeRoomName,
    this.userName,
    this.userAvatar,
    this.listImageDetailPath,
    this.updatedAt,
    this.isLike,
    this.isReport,
  });
}
