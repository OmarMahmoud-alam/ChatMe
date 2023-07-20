import 'package:flutter/material.dart';
import 'package:project3/cubits/Chatmessage/chatmessage_cubit.dart';

import 'package:image_picker/image_picker.dart';

class mymassage extends StatelessWidget {
  final String text;
  final String type;
  const mymassage({
    required this.text,
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return (type == 'textmessage')
        ? Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
                padding: const EdgeInsets.only(top: 25, right: 20.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0))),
                  child: Text(text),
                )),
          )
        : Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              margin: const EdgeInsets.all(12.0),
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightBlueAccent,
                  width: 4.0,
                ),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                    topLeft: Radius.circular(12.0)),
              ),
              child: Image.network(
                text,
                fit: BoxFit.fill,
              ),
            ),
          );
  }
}

class imagepackerform extends StatelessWidget {
  const imagepackerform(
      {super.key, required this.userid, required this.blocprovid});
  final String userid;
  final ChatmessageCubit blocprovid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('camera'),
            onTap: () => blocprovid.SendImagemassage(ImageSource.camera, userid),
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('gallery'),
            onTap: () =>
                blocprovid.SendImagemassage(ImageSource.gallery, userid),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class othermassage extends StatelessWidget {
  final String text;
  final String type;
  const othermassage({
    required this.text,
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return (type == 'textmessage')
        ? Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 20.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0))),
                  child: Text(text),
                )),
          )
        : Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightBlueAccent,
                  width: 4.0,
                ),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                    topLeft: Radius.circular(12.0)),
              ),
              height: 300,
              child: Image.network(text),
            ),
          );
  }
}
