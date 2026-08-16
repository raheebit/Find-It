import '../entities/report.dart';

abstract interface class ReportRepository {
  Stream<List<Report>> watchReports();

  Future<Report> createReport(Report report);

  Future<void> updateReport(Report report);

  Future<void> deleteReport(String reportId);
}
