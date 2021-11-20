enum ReportReason {
  spam,
  nudity,
  hateSpeech,
  fake,
}

enum ReportType { product, shop }

class Report {
  final String id;
  final ReportReason reason;
  final String userId;
  final DateTime date;
  final String toId;
  final ReportType type;

  Report({
    required this.id,
    required this.reason,
    required this.userId,
    required this.date,
    required this.toId,
    required this.type,
  });
}
