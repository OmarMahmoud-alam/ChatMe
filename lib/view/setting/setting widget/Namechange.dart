import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/cubits/settingcubit/setting_cubit.dart';

class NameChange extends StatelessWidget {
  const NameChange({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController controlleText = TextEditingController();
    final GlobalKey<FormState> mainkey = GlobalKey<FormState>();
    final myBloc2 = BlocProvider.of<Cubitsetting>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(myBloc2.usertemp!.name),
        actions: [
          BlocBuilder<Cubitsetting, SettingState>(
            builder: (context, state) {
              final myBloc = BlocProvider.of<Cubitsetting>(context);

              return IconButton(
                onPressed: () {
                  if (mainkey.currentState!.validate()) {
                    myBloc.usertemp!.name = controlleText.text;
                    myBloc.updateshowdate(name: controlleText.text);

                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.check_box),
              );
            },
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
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hoverColor: Colors.blue, hintText: myBloc2.usertemp!.name),
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
