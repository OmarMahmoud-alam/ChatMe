import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:project3/module/notemodule.dart';

part 'addnote_state.dart';

class AddnoteCubit extends Cubit<AddnoteState> {
  AddnoteCubit() : super(AddnoteInitial());

  addNote(NodeModule note) {
    emit(Addnoteloading());
    try {
      var noteBox = Hive.box<NodeModule>('testBox');
      noteBox.add(note);

      emit(Addnotesuccess());
    } catch (e) {
      emit(Addnotefailed(e.toString()));

    }
  }
}
