class CitationModel {
  final String id;
  final String sourceTitle;
  final String url;
  final int index;

  CitationModel({
    required this.id,
    required this.sourceTitle,
    required this.url,
    required this.index,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'source_title': sourceTitle,
        'url': url,
        'index': index,
      };
}
