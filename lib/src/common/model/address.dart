import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  @JsonKey(name: 'church_name')
  final String churchName;
  final String address1;
  @JsonKey(name: 'house_number')
  final String houseNumber;
  final String zip;
  final String city;
  final String country;
  final String room;

  Address(this.churchName, this.address1, this.houseNumber, this.zip, this.city,
      this.country,
      [this.room]);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  String getZipAndCity() {
    return zip + ' ' + city;
  }
}
