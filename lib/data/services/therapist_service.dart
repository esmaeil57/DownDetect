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

  Future<void> updateTherapist(String id) async {
    await ApiClient.dio.put('/therapists/$id');
  }

  Future<void> deleteTherapist(String id) async {
    await ApiClient.dio.delete('/therapists/$id');
  }
}
