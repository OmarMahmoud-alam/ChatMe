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

class PickimageMassegeIntailState extends ChatmessageState {}

class PickimageMassegeSuccessState extends ChatmessageState {}

class PickimageMassegeNoimageState extends ChatmessageState {}

class Uploadimageinitalstate extends ChatmessageState {}

class Uploadimagedonestate extends ChatmessageState {}

class Uploadimageerrorstate extends ChatmessageState {}

class SocialLastseenIntialState extends ChatmessageState {}

class SocialLastseenFailState extends ChatmessageState {}

class SocialLastseenSuccessState extends ChatmessageState {}
