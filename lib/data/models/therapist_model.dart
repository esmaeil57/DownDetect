class Therapist {
  final String id;
  final String phonenumber;
  final String name;
  final String rate;
  final String location;
  final String availableSlots;
  final String gender;
  final String profileImage;

  Therapist({
    required this.id,
    required this.phonenumber,
    required this.name,
    required this.rate,
    required this.location,
    required this.availableSlots,
    required this.gender,
    required this.profileImage
  });

  factory Therapist.fromJson(Map<String, dynamic> json) => Therapist(
    id: json['_id'],
    phonenumber: json['phonenumber'],
    name: json['name'],
    rate: json['rate'],
    location: json['location'],
    availableSlots: json['availableSlots'],
    gender: json['gender'],
    profileImage:json['profileImage']
  );

  Map<String, dynamic> toJson() => {
    "phonenumber": phonenumber,
    "name": name,
    "rate": rate,
    "location": location,
    "availableSlots": availableSlots,
    "gender": gender,
    "profileImage":profileImage ,
  };
}
