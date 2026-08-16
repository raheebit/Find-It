import '../entities/report.dart';
import '../repositories/report_repository.dart';

class CreateReport {
  const CreateReport(this.repository);

  final ReportRepository repository;

  Future<Report> call(Report report) {
    return repository.createReport(report);
  }
}
