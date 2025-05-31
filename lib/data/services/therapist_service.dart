import '../../core/network/api_client.dart';
import '../models/therapist_model.dart';

class TherapistService {
  Future<List<Therapist>> fetchAllTherapists() async {
    final response = await ApiClient.dio.get('/therapists');
    return (response.data as List)
        .map((json) => Therapist.fromJson(json))
        .toList();
  }

  Future<void> addTherapist(Therapist therapist) async {
    await ApiClient.dio.post('/therapists', data: therapist.toJson());
  }

  Future<void> updateTherapist(Therapist therapist) async {
    await ApiClient.dio.put(
      '/therapists/${therapist.id}',
      data: {
        'name': therapist.name,
        'location': therapist.location,
        'rate': therapist.rate,
        'gender': therapist.gender,
        'phonenumber': therapist.phonenumber,
        'availableSlots': therapist.availableSlots,
      },
    );
  }


  Future<void> deleteTherapist(String id) async {
    await ApiClient.dio.delete('/therapists/$id');
  }
}
