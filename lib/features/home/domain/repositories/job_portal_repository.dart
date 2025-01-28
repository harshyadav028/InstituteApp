import 'package:uhl_link/features/home/domain/entities/job_entity.dart';

abstract class JobPortalRepository {
  Future<List<JobEntity>> getJobs();
}
