import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vistoria_cfc/src/models/profile_model.dart';

part 'profile_result.freezed.dart';

@freezed
class ProfileResult with _$ProfileResult {
   factory ProfileResult.success(ProfileModel profile) = Success;
   factory ProfileResult.error(String message) = Error;
}