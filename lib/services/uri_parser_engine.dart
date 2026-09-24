import '../models/uri_context_model.dart';

class UriParserEngine {
  static UriContextModel parseUri(String uriString, String fallbackUser) {
    final Uri uri = Uri.parse(uriString);
    final String taskId = uri.queryParameters['task_id'] ?? 'UNKNOWN_TASK';
    final String traceId = uri.queryParameters['trace_id'] ?? 'UNKNOWN_TRACE';

    return UriContextModel(
      taskId: taskId,
      traceId: traceId,
      rawUri: uriString,
      status: UriRoutingStatus.complete,
      completionRate: 99.0,
      timestamp: DateTime.now(),
      userId: fallbackUser,
    );
  }
}
