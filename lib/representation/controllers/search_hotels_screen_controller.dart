import 'dart:convert';

import 'package:travel_app_ytb/helpers/location/location_helper.dart';

import '../../helpers/http/base_client.dart';
import '../../helpers/loginManager/login_manager.dart';

class SearchHotelsScreenController {
    Future<String> getDistanceInformation(String address) async {
        return LocationHelper().getDistanceInformation(address);
    }

    Future<dynamic> getHotelDetail(int hotelId) async {
        var response = await BaseClient(LoginManager().userModel.token ?? "")
            .get('/searches/hotels/$hotelId').catchError((onError) {
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
