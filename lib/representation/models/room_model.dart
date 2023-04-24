
class RoomModel {
  int? id;
  int? hotelId;
  String? name;
  String? description;
  int? price;
  int? occupancy;
  int? numberOfBeds;
  int? countAvailabilityRoom;
  List<String>? services;
  String? imagePath;
  int? size;

  RoomModel({this.id, this.hotelId, this.name, this.description, this.price, this.occupancy, this.numberOfBeds, this.countAvailabilityRoom, this.services, this.imagePath, this.size});

}