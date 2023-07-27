import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project3/controller/signcontroller.dart';
import 'package:project3/cubits/settingcubit/setting_cubit.dart';
import 'package:project3/view/setting/setting%20widget/Bio.dart';
import 'package:project3/view/setting/setting%20widget/Namechange.dart';
import 'package:project3/view/setting/setting%20widget/number.dart';
import 'package:project3/view/signin/emailsign.dart';
import 'package:project3/widget/sharedwidget.dart';
import 'package:provider/provider.dart';

class Settingapp extends StatelessWidget {
  const Settingapp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Cubitsetting(),
        child: BlocConsumer<Cubitsetting, SettingState>(
            listener: (context, state) {
          // TODO: implement listener
        }, builder: (context, state) {
          final myBloc = BlocProvider.of<Cubitsetting>(context);

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 420,
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: double.infinity,
                            height: 400,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: myBloc.profileImage == null
                                        ? NetworkImage(myBloc.usertemp!.cover)
                                        : FileImage(myBloc.profileImage!)
                                            as ImageProvider,
                                    fit: BoxFit.cover)),
                          )),
                      /* const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 30.0, left: 17.0),
                          child: Icon(Icons.arrow_back_ios, size: 30.0),
                        ),
                      ),*/
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: InkWell(
                            onTap: () {},
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      // <-- SEE HERE
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10.0),
                                      ),
                                    ),
                                    builder: (BuildContext bc) {
                                      return Imagepackerform(
                                        myBloc: myBloc,
                                      );
                                    });
                              },
                              child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.camera_enhance,
                                    size: 25,
                                  )),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Card(
                  elevation: 8.0,
                  child: Container(
                    color: Colors.grey[100],
                    width: double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Account information',
                                style: TextStyle(color: Colors.blue)),
                            const SizedBox(
                              height: 15.0,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BlocProvider.value(
                                        value: Cubitsetting(),
                                        child: const NameChange(),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(myBloc.usertemp!.name),
                                  const Text('tap to change name',
                                      style: TextStyle(color: Colors.grey))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BlocProvider.value(
                                          value: Cubitsetting(),
                                          child: const PhoneChange(),
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(myBloc.usertemp!.phone),
                                    const Text('tap to change phone',
                                        style: TextStyle(color: Colors.grey))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BlocProvider.value(
                                        value: Cubitsetting(),
                                        child: const BioChange(),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Bio'),
                                  // '${bio ?? (Cubitsetting.get(context).userModel!.bio ?? "Bio:")} '),
                                  Text('add a few words about yourself',
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
                Card(
                  elevation: 8.0,
                  child: Container(
                    color: Colors.grey[100],
                    width: double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Account information',
                                style: TextStyle(color: Colors.blue)),
                            const SizedBox(
                              height: 15.0,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.notification_add),
                                  Text('notification setting'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.lock),
                                  Text('privacy and security'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            InkWell(
                              onTap: () {
                                print('test');
                              },
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.chat_bubble),
                                  Text('chat setting'),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 15.0,
                    left: 15.0,
                    top: 5.0,
                    bottom: 5.0,
                  ),
                  child: DefaultButton(
                      radius: 10,
                      function: () {
                        myBloc.update();
                      },
                      text: 'update data'),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      right: 15.0,
                      left: 15.0,
                      top: 5.0,
                      bottom: 5.0,
                    ),
                    child: DefaultButton(
                        radius: 10,
                        background: Colors.red,
                        function: () async {
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .logout();
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);

                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const email()),
                          );
                          //  Cubitsetting.get(context).logout();
                        },
                        text: 'logout')),
              ],
            ),
          );
        }));
  }
}

class Imagepackerform extends StatelessWidget {
  const Imagepackerform({super.key, required this.myBloc});
  final Cubitsetting myBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: <Widget>[
          ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('camera'),
              onTap: () {
                myBloc.uploadprofileImagemassage(ImageSource.camera);
                Navigator.pop(context);
              }),
          ListTile(
              leading: const Icon(Icons.image),
              title: const Text('gallery'),
              onTap: () {
                myBloc.uploadprofileImagemassage(ImageSource.gallery);
                Navigator.pop(context);
              }),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
