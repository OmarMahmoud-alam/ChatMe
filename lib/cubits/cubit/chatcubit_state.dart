part of 'chatcubit_cubit.dart';

@immutable
abstract class ChatcubitState {}

class ChatcubitInitial extends ChatcubitState {}

class SocialGetUserLoadingState extends ChatcubitState {}

class SocialGetUserSuccessState extends ChatcubitState {}

class SocialGetUserFailState extends ChatcubitState {}

class SocialGetallUserLoadingState extends ChatcubitState {}

class SocialGetMessagesSuccessState extends ChatcubitState {}

class SocialSendMessageSuccessState extends ChatcubitState {}

class SocialSendMessageFailState extends ChatcubitState {}

class SocialGetUserFriendsLoadingState extends ChatcubitState {}

class SocialGetUserFriendsSucceddState extends ChatcubitState {}

class SocialGetUserFriendsFaileddState extends ChatcubitState {}
