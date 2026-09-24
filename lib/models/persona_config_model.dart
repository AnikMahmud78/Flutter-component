class PersonaConfigModel {
  final String notebookId;
  final String personaName;
  final String toneGuideline;
  final double reuseRate;
  final String status;

  PersonaConfigModel({
    required this.notebookId,
    required this.personaName,
    required this.toneGuideline,
    required this.reuseRate,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'notebook_id': notebookId,
        'persona_name': personaName,
        'tone_guideline': toneGuideline,
        'reuse_rate': reuseRate,
        'status': status,
      };
}
