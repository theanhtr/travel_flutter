import 'dart:convert';

import '../../../helpers/http/base_client.dart';
import '../../../helpers/loginManager/login_manager.dart';

class SearchInHomeController {
    Future<dynamic> searchHotelByText(String text) async {
      var response = await BaseClient(LoginManager().userModel.token ?? "").post('/searches/hotels-fulltext', {
          'search_name': text,
      })
          .catchError((onError) {
        return onError;
      });
      if (response.runtimeType == int) {
        return response;
      }
      Map dataResponse = await json.decode(response);
      return dataResponse['data'];
    }
}