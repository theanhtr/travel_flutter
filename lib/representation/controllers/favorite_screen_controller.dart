import 'dart:convert';

import '../../helpers/http/base_client.dart';
import '../../helpers/loginManager/login_manager.dart';

class FavoriteScreenController {
  Future<dynamic> getAllHotelsLike() async {
    print('HHHHH');
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .get('/likes/hotels').catchError((onError) {
      return onError;
    });
    if (response.runtimeType == int) {
      return response;
    }
    if (response.runtimeType == String) {
      Map dataResponse = await json.decode(response);
      return dataResponse['data'];
    }
    return false;
  }
}
