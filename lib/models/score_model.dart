class Score {
  final int total;
  final int success;
  final int failed;

  Score({
    required this.total,
    required this.success,
    required this.failed,
  });

  Score copyWith({int? total, int? success, int? failed}) {
    return Score(
      total: total ?? this.total,
      success: success ?? this.success,
      failed: failed ?? this.failed,
    );
  }
}
