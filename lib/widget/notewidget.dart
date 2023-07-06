import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/module/notemodule.dart';
import 'package:project3/view/Editnode.dart';
import 'package:project3/widget/sharedwidget.dart';

import '../addnotecubit/addnote_cubit.dart';

class NoteWidget extends StatelessWidget {
  final double height;
  final double width;
  final NoteModule note;
  final int index;
  const NoteWidget(this.height, this.width, {super.key, required this.note,required this.index});

  @override
  Widget build(BuildContext context) {
    var blocprovid = BlocProvider.of<AddnoteCubit>(context);

    return GestureDetector(
      onTap: () {
        navigateto(context: context, widget: EditNode( note: note,index:index));
      },
      child: Container(
        padding: const EdgeInsets.all(14.0),
        height: height * 1.1,
        width: double.infinity,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: const Color.fromARGB(200, 219, 95, 12),
            borderRadius: BorderRadius.circular(20.0)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                      icon: const Icon(Icons.wallet),
                      onPressed: () => blocprovid.deletenote(note)),
                ],
              ),
              SizedBox(
                height: height / 4,
                width: width / 3,
                child: Text(
                  note.content,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 15.0),
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  Text('created at ${note.date.toString()}'),
                ],
              ),
            ]),
      ),
    );
  }
}
