import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/addnotecubit/addnote_cubit.dart';
import 'package:project3/controller/notecontroller.dart';
import 'package:project3/module/notemodule.dart';
import 'package:project3/widget/notewidget.dart';
import 'package:project3/widget/widgets.dart';
import 'package:provider/provider.dart';

class Notehome extends StatelessWidget {
  const Notehome({super.key});
  @override
  Widget build(BuildContext context) {
    var blocprovid = BlocProvider.of<AddnoteCubit>(context);
    blocprovid.getnote();
    final provider = Provider.of<Noteprovider>(context);
    final formkey = provider.formKey;
    return BlocBuilder<AddnoteCubit, AddnoteState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor:Colors.blue,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                  ),
                  builder: (BuildContext context) {
                    return formInput(
                      provider: provider,
                      formKey: formkey,
                    );
                  },
                );
              },
              child: const Icon(Icons.note_add)),
          body: LayoutBuilder(builder: (context, constraints) {
            double height = 170; //(constraints.maxHeight / 4) - 8;
            double width = (constraints.maxWidth - 100);
            print(height);
            print(width);
            return blocprovid.notes.length == 0
                ? CircularProgressIndicator()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: blocprovid.notes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NoteWidget(
                        height,
                        width,
                        note: blocprovid.notes[index],
                        index:index,
                      );
                    });
          }),
        );
      },
    );
  }
}

class formInput extends StatelessWidget {
  const formInput({
    super.key,
    required this.formKey,
    required this.provider,
  });

  final GlobalKey<FormState> formKey;
  final Noteprovider provider;

  @override
  Widget build(BuildContext context) {
    var blocprovid = BlocProvider.of<AddnoteCubit>(context);

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            inputdata(
              controller: provider.titlecontroller,
              label: 'tital',
              validation: (s) {
                return (s?.isEmpty ?? true) ? 'is shouldn\'t be empty' : null;
              },
            ),
            const SizedBox(height: 5),
            inputdata(
              minline: 7,
              controller: provider.notedatacontroller,
              label: ' data',
              validation: (s) {
                return (s?.isEmpty ?? true) ? 'is shouldn\'t be empty' : null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize:
                    const MaterialStatePropertyAll(Size(double.infinity, 40)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                        width: 1, color: Color.fromARGB(255, 119, 96, 96)),
                  ),
                ),
              ),
              child: const Text('Add'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  NoteModule user = NoteModule(
                      title: provider.titlecontroller.text,
                      content: provider.notedatacontroller.text,
                      date: DateTime.now(),
                      color: 4);
                  blocprovid.addNote(user);
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
