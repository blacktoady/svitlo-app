class LocationModel {
  String? key;
  String? locationName;
  int? locationGroup;
  String? locationIcon;
  int? error;

  LocationModel({required this.key, required this.locationName, required this.locationGroup, required this.locationIcon});

  LocationModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    locationName = json['location_name'];
    locationGroup = json['location_group'];
    locationIcon = json['location_icon'];
  }

  LocationModel.withError(int e) {
    error = e;
    // 404 -- data not found
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['location_name'] = this.locationName;
    data['location_group'] = this.locationGroup;
    data['location_icon'] = this.locationIcon;
    return data;
  }
}
