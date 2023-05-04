import 'dart:convert';

import '../../helpers/http/base_client.dart';
import '../../helpers/loginManager/login_manager.dart';

class HotelDetailScreenController {
  Future<dynamic> likeHotel(int hotelId) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .post('/likes/hotel/$hotelId', {}).catchError((onError) {
      return onError;
    });
    if (response.runtimeType == int) {
      return response;
    }
    if (response.runtimeType == String) {
      Map dataResponse = await json.decode(response);
      return dataResponse['data']['is_like'];
    }
    return false;
  }
}
