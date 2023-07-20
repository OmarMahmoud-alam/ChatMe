import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/cubits/settingcubit/setting_cubit.dart';

class BioChange extends StatelessWidget {
  const BioChange({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController controlleText = TextEditingController();
    final GlobalKey<FormState> mainkey = GlobalKey<FormState>();
    final myBloc = BlocProvider.of<Cubitsetting>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bio'),
        actions: [
          IconButton(
            onPressed: () {
              if (mainkey.currentState!.validate()) {
                myBloc.updateshowdate(bio:controlleText.text);
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.check_box),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: Form(
            key: mainkey,
            child: TextFormField(
              controller: controlleText,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hoverColor: Colors.blue,
                  hintText: myBloc.usertemp!.bio ?? "No name"),
              validator: (String? s) {
                if (s == null || s == '') {
                  return 'must enter value';
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
