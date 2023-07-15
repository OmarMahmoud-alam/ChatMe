part of 'chatmessage_cubit.dart';

@immutable
abstract class ChatmessageState {}

class ChatmessageInitial extends ChatmessageState {}

class SocialSendMessageIntialState extends ChatmessageState {}

class SocialSendMessageSuccessState extends ChatmessageState {}

class SocialSendMessageFailState extends ChatmessageState {}

class SocialGetMessagesintialState extends ChatmessageState {}

class SocialGetMessagesSuccessState extends ChatmessageState {}

class SocialGetMessagesfailsState extends ChatmessageState {}

class SocialMeintialState extends ChatmessageState {}

class SocialMesuccessState extends ChatmessageState {}

class SocialMeFailState extends ChatmessageState {}
