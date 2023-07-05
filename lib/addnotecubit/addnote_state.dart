part of 'addnote_cubit.dart';

@immutable
abstract class AddnoteState {}

class AddnoteInitial extends AddnoteState {}

class Addnoteloading extends AddnoteState {}

class Addnotesuccess extends AddnoteState {}

class Addnotefailed extends AddnoteState {
  String error;
  Addnotefailed(this.error);

  //Toast('error is ${this.error}');
}
