class Therapist {
  final String id;
  final String phonenumber;
  final String name;
  final String rate;
  final String location;
  final String availableSlots;
  final String gender;
  Therapist({
    required this.id,
    required this.phonenumber,
    required this.name,
    required this.rate,
    required this.location,
    required this.availableSlots,
    required this.gender,
  });

  factory Therapist.fromJson(Map<String, dynamic> json) => Therapist(
    id: json['_id'],
    phonenumber: json['phonenumber'],
    name: json['name'],
    rate: json['rate'],
    location: json['location'],
    availableSlots: json['availableSlots'],
    gender: json['gender'],
  );

  Map<String, dynamic> toJson() => {
    "phonenumber": phonenumber,
    "name": name,
    "rate": rate,
    "location": location,
    "availableSlots": availableSlots,
    "gender": gender,
  };
  Therapist copyWith({
    String? name,
    String? location,
    String? rate,
    String? gender,
    String? phoneNumber,
    String? availableSlots,
    String? id,
  }) {
    return Therapist(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      rate: rate ?? this.rate,
      gender: gender ?? this.gender,
      phonenumber: phoneNumber ?? this.phonenumber,
      availableSlots:availableSlots ?? this.availableSlots,
    );
  }
}