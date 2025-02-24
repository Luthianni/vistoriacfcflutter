import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vistoria_cfc/src/models/cfc_model.dart';

part 'cfc_result.freezed.dart';

@freezed
class CfcResult with _$CfcResult {
  factory CfcResult.success(CfcModel cfc) = Success;
  factory CfcResult.error(String message) = Error;
}
