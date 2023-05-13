import 'dart:convert';

import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/representation/models/hotel_model.dart';

import '../../../helpers/http/base_client.dart';
import '../../../helpers/loginManager/login_manager.dart';

class HotelDetailController {
  Future<HotelModel> getHotelDetail(int id) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "").get('/searches/hotels/$id')
        .catchError((onError) {
      return onError;
    });
    if (response == null) {
      return HotelModel();
    }
    Map dataResponse = await json.decode(response);
    final listImage = dataResponse['data']['images'] as List;
    List<String> listImageString = [];
    if (listImage.isEmpty == true) {
      listImageString.add(ConstUtils.imgHotelDefault);
    }
    for (var element in listImage) {
      listImageString.add(element['path']);
    }
    List<String> listService = [];
    final amenities = dataResponse['data']['amenities'];
    amenities.forEach((element) {
      listService.add(element['name']);
    });
    final startInfo = dataResponse['data']['rating_average'].runtimeType == int ? dataResponse['data']['rating_average'] as int : dataResponse['data']['rating_average'] as double;
    return HotelModel(
      id: dataResponse['data']['id'],
      listImageDetailPath: listImageString,
      name: dataResponse['data']['name'],
      locationInfo: "${dataResponse['data']['address']['specific_address']}, ${dataResponse['data']['address']['sub_district']}, ${dataResponse['data']['address']['district']}, ${dataResponse['data']['address']['province']}",
      starInfo: startInfo.toDouble(),
      countReviews: dataResponse['data']['count_review'] as int,
      priceInfo: "${dataResponse['data']['min_price']} - ${dataResponse['data']['max_price']}",
      description: dataResponse['data']['description'],
      address: "${dataResponse['data']['address']['specific_address']}, ${dataResponse['data']['address']['sub_district']}, ${dataResponse['data']['address']['district']}, ${dataResponse['data']['address']['province']}",
      services: listService,
      isLike: dataResponse['data']['is_like'],
    );
  }

  Future<dynamic> likeHotel(int hotelId) async {
    final token = await LoginManager().userModel.token;
    var response = await BaseClient(token ?? "").post("/likes/hotel/$hotelId", {})
        .catchError((err) {
      return false;
    });

    if (response == null) {
      return false;
    }
    Map dataResponse = json.decode(response);
    if (dataResponse['success'] == true) {
      return dataResponse['data']['is_like'];
    }
  }

}
