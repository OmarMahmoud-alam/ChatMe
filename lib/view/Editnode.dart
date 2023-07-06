import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/addnotecubit/addnote_cubit.dart';
import 'package:project3/widget/widgets.dart';
import 'package:project3/module/notemodule.dart';

class EditNode extends StatelessWidget {
  final NoteModule note;
  final int index;
  const EditNode({required this.note, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final blocprovid = BlocProvider.of<AddnoteCubit>(context);

    final TextEditingController titlecontroller = TextEditingController();
    final TextEditingController notedatacontroller = TextEditingController();
    titlecontroller.text = note.title;
    notedatacontroller.text = note.content;
    return BlocBuilder<AddnoteCubit, AddnoteState>(builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            Customappbar(
              title: 'Editapp',
              icon: Icon(Icons.join_right_sharp),
              pressfunction: () {
                if (titlecontroller.text.length > 0 ||
                    notedatacontroller.text.length > 0) {
                  NoteModule newnote = NoteModule(
                      title: titlecontroller.text,
                      content: notedatacontroller.text,
                      date: DateTime.now(),
                      color: 01);
                  blocprovid.editnode(newnote, index);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error in enter Note\'s data '),
                        content: Text('title or content or Both is empty '),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.cancel))
                        ],
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            inputdata(
              controller: titlecontroller,
              label: 'title',
            ),
            SizedBox(
              height: 50,
            ),
            inputdata(
              controller: notedatacontroller,
              label: 'Note',
              minline: 10,
            ),
          ],
        ),
      );
    });
  }
}

class Customappbar extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function()? pressfunction;
  const Customappbar({
    super.key,
    required this.title,
    required this.icon,
    this.pressfunction,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        // decoration: BoxDecoration(shape: ),
        padding: EdgeInsets.only(top: 20.0, right: 10, left: 10, bottom: 5),
        //height: 70,
        color: Color.fromARGB(255, 71, 69, 64),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Spacer(),
            IconButton(
              icon: icon,
              onPressed: pressfunction,
            ),
          ],
        ),
      ),
    );
  }
}
