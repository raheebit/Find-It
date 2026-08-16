import '../../domain/entities/report.dart';

class ReportModel extends Report {
  const ReportModel({
    required super.id,
    required super.userId,
    required super.type,
    required super.name,
    required super.phone,
    required super.itemName,
    required super.description,
    required super.location,
    required super.createdAt,
  });

  factory ReportModel.fromMap(String id, Map<String, dynamic> map) {
    return ReportModel(
      id: id,
      userId: (map['userId'] as String?) ?? '',
      type: map['type'] == 'found' ? ReportType.found : ReportType.lost,
      name: (map['name'] as String?) ?? '',
      phone: (map['phone'] as String?) ?? '',
      itemName: (map['itemName'] as String?) ?? '',
      description: (map['description'] as String?) ?? '',
      location: (map['location'] as String?) ?? '',
      createdAt: DateTime.tryParse((map['createdAt'] as String?) ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type.name,
      'name': name,
      'phone': phone,
      'itemName': itemName,
      'description': description,
      'location': location,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
