import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/cubits/settingcubit/setting_cubit.dart';

class PhoneChange extends StatelessWidget {
  const PhoneChange({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController controlleText = TextEditingController();
    final GlobalKey<FormState> mainkey = GlobalKey<FormState>();
    final myBloc = BlocProvider.of<Cubitsetting>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Phone'),
        actions: [
          IconButton(
            onPressed: () {
              if (mainkey.currentState!.validate()) {
                myBloc.updateshowdate(phone: controlleText.text);

                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.check_box),
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
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hoverColor: const Color.fromARGB(255, 166, 170, 173),
                  hintText: myBloc.usertemp!.phone ?? "No name"),
              validator: (String? s) {
                if (s == null || s == '') {
                  return 'must enter value';
                } else
                  return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}
