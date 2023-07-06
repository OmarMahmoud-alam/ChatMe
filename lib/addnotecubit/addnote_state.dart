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

class getnoteloading extends AddnoteState {}

class getnotesuccess extends AddnoteState {}

class getnotefailed extends AddnoteState {
  String error;
  getnotefailed(this.error);

  //Toast('error is ${this.error}');
}

class deletenoteloading extends AddnoteState {}

class deletenotesuccess extends AddnoteState {}

class deletenotefailed extends AddnoteState {
  final String error;
  deletenotefailed(this.error);

  //Toast('error is ${this.error}');
}
class Editnoteloading extends AddnoteState {}

class Editnotesuccess extends AddnoteState {}

class Editnotefailed extends AddnoteState {
  final String error;
  Editnotefailed(this.error);

  //Toast('error is ${this.error}');
}
