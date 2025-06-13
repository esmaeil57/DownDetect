class PredictionResult {
  final String result;
  final int predictedClassIndex;
  final double confidence;

  PredictionResult({
    required this.result,
    required this.predictedClassIndex,
    required this.confidence,
  });

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    final rawConfidence = json['confidence'].toString().replaceAll('%', '');
    return PredictionResult(
      result: json['result'],
      predictedClassIndex: int.tryParse(json['predicted_class_index'].toString()) ?? 0,
      confidence: double.tryParse(rawConfidence) ?? 0.0,
    );
  }
}