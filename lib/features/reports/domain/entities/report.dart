enum ReportType { lost, found }

class Report {
  const Report({
    required this.id,
    required this.userId,
    required this.type,
    required this.name,
    required this.phone,
    required this.itemName,
    required this.description,
    required this.location,
    required this.createdAt,
  });

  final String id;
  final String userId;
  final ReportType type;
  final String name;
  final String phone;
  final String itemName;
  final String description;
  final String location;
  final DateTime createdAt;
}
