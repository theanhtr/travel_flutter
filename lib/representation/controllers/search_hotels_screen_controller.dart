import 'package:travel_app_ytb/helpers/location/location_helper.dart';

class SearchHotelsScreenController {
    Future<double> getDistanceInformation(String address) async {
        return LocationHelper().getDistanceInformation(address);
    }
}
