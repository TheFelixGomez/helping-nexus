class Location {
  String address;
  String? address2;
  String city;
  String state;
  String zip;
  String country;

  Location({
    required this.address,
    this.address2,
    required this.city,
    required this.state,
    required this.zip,
    this.country = 'US'
  });

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      address: json['address'] as String,
      address2: json['address_2'] as String?,
      city: json['city'] as String,
      state: json['state'] as String,
      zip: json['zip'] as String,
      country: json['country'] as String
    );
  }

  toJson() {
    return {
      'address': address,
      'address_2': address2,
      'city': city,
      'state': state,
      'zip': zip,
      'country': country
    };
  }
}