part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SocialGetUserLoadingState extends SearchState {}

class SocialGetUserSuccessState extends SearchState {}

class SocialGetUserFailState extends SearchState {}

class SocialGetallUserLoadingState extends SearchState {}

class SocialGetallUsersuccessState extends SearchState {}

class SocialGetallUserfailState extends SearchState {}

class SocialGetSearchUserLoadingState extends SearchState {}

class SocialGetSearchUsersuccessState extends SearchState {}

class SocialGetSearchUserfailState extends SearchState {}
