class PromptStyleModel {
  final String rawPromptText;
  final String fontFamily;
  final double consistencyScore;
  final String qualityRating;

  PromptStyleModel({
    required this.rawPromptText,
    required this.fontFamily,
    required this.consistencyScore,
    required this.qualityRating,
  });

  Map<String, dynamic> toJson() => {
        'raw_prompt_text': rawPromptText,
        'font_family': fontFamily,
        'consistency_score': consistencyScore,
        'quality_rating': qualityRating,
      };
}
