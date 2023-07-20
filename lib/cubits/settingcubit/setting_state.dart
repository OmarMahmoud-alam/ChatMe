part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class SocialProfileImagePickedSuccessState extends SettingState {}

class SocialProfileImagePickedErrorState1 extends SettingState {}

class SocialProfileImagePickedErrorState2 extends SettingState {}

class SocialUserUpdateErrorState extends SettingState {}

class SocialGetUserLoadingState extends SettingState {}

class SocialUserUpdateSuccessState extends SettingState {}

class SocialUserUpdateIntiaState extends SettingState {}

class UpdateShowuser extends SettingState {}
