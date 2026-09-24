import 'package:flutter/material.dart';
import '../models/citation_model.dart';

class CitationChip extends StatelessWidget {
  final CitationModel citation;
  final ValueChanged<CitationModel> OnSelected;

  const CitationChip({
    Key? key,
    required this.citation,
    required this.OnSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 48.0, minWidth: 48.0),
      alignment: Alignment.centerLeft,
      child: InputChip(
        avatar: CircleAvatar(
          child: Text('${citation.index}', style: const TextStyle(fontSize: 10)),
        ),
        label: Text(citation.sourceTitle),
        onPressed: () => OnSelected(citation),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
