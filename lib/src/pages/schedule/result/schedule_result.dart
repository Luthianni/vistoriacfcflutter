import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vistoria_cfc/src/models/schedule_model.dart';

part 'schedule_result.freezed.dart';

@freezed
class ScheduleResult with _$ScheduleResult {
  factory ScheduleResult.success(ScheduleModel sch) = Success;
  factory ScheduleResult.error(String message) = Error;
}