import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:project3/controller/notecontroller.dart';
import 'package:project3/controller/signcontroller.dart';
import 'package:project3/widget/googlelog.dart';
import 'package:project3/widget/notewidget.dart';
import 'package:project3/widget/widgets.dart';
import 'package:provider/provider.dart';

class Notehome extends StatelessWidget {
  const Notehome({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Noteprovider>(context);
    final formkey = provider.formKey;
    return Scaffold(
      floatingActionButton: IconButton(
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
          icon: Icon(Icons.note_add)),
      body: LayoutBuilder(builder: (context, constraints) {
        double height = 170; //(constraints.maxHeight / 4) - 8;
        double width = (constraints.maxWidth - 100);
        print(height);
        print(width);
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return NoteWidget(height, width);
            });
      }),
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
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            inputdata(
              Controller: provider.titlecontroller,
              label: 'tital',
              validation: (s) {
                return (s?.isEmpty ?? true) ? 'is shouldn\'t be empty' : null;
              },
            ),
            const SizedBox(height: 5),
            inputdata(
              maxline: 7,
              minline: 7,
              Controller: provider.notedatacontroller,
              label: ' data',
              validation: (s) {
                return (s?.isEmpty ?? true) ? 'is shouldn\'t be empty' : null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize:
                    MaterialStatePropertyAll(Size(double.infinity, 40)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                        width: 1, color: Color.fromARGB(255, 119, 96, 96)),
                  ),
                ),
              ),
              child: Text('Add'),
              onPressed: () {},
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
