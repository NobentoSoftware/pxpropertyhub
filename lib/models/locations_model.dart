class LocationsModel {
  List<Data>? data;

  LocationsModel({this.data});

  LocationsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? suburb;
  String? cityTown;
  String? provinceState;
  String? country;

  Data({this.id, this.suburb, this.cityTown, this.provinceState, this.country});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suburb = json['suburb'];
    cityTown = json['city_town'];
    provinceState = json['province_state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['suburb'] = this.suburb;
    data['city_town'] = this.cityTown;
    data['province_state'] = this.provinceState;
    data['country'] = this.country;
    return data;
  }
}