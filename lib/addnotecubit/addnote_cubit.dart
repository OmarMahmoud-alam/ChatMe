import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:project3/module/notemodule.dart';
import 'package:project3/styles/styles.dart';

part 'addnote_state.dart';

class AddnoteCubit extends Cubit<AddnoteState> {
  AddnoteCubit() : super(AddnoteInitial());
  List<NoteModule> notes = [];

  addNote(NoteModule note) async {
    emit(Addnoteloading());
    try {
      var noteBox = Hive.box<NoteModule>(Comman.knodebox);

      await noteBox.add(note);

      getnote();
      print(noteBox.values.length.toString());

      print(note.toString());

      emit(Addnotesuccess());
    } catch (e) {
      print(e.toString());
      emit(Addnotefailed(e.toString()));
    } finally {}
  }

  void getnote() async {
    try {
      emit(getnoteloading());
      var noteBox = Hive.box<NoteModule>(Comman.knodebox);
      notes = [...noteBox.values.toList()];
      print(notes.length.toString());
      emit(getnotesuccess());
    } catch (e) {
      emit(getnotefailed(e.toString()));
    }
    print(notes.length.toString());
  }

  void deletenote(NoteModule note) async {
    try {
      emit(deletenoteloading());
      print('try delete');

      var noteBox = Hive.box<NoteModule>(Comman.knodebox);
      var deletedelement = noteBox.values.where((_) => _ == note).first;
      deletedelement.delete();
      print(' delete done');

      emit(deletenotesuccess());
      print(' referes');
      getnote();
    } catch (e) {
      print(notes.length.toString());
      print(' error ${e.toString()}');

      emit(deletenotefailed(e.toString()));
    }
    print(notes.length.toString());
  }

void editnode(NoteModule note,index) async {
    try {
      emit(Editnoteloading());
      print('try delete');

      var noteBox = Hive.box<NoteModule>(Comman.knodebox);
        final key = noteBox.keyAt(index);

        await noteBox.put(key, note);

      print(' Edit done');

      emit(Editnotesuccess());
      print(' referes');
      getnote();
    } catch (e) {
      print(notes.length.toString());
      print(' error ${e.toString()}');

      emit(Editnotefailed(e.toString()));
    }
    print(notes.length.toString());
  }



}
