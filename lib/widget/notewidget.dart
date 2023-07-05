import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  double height;
  double width;
  NoteWidget(this.height, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.0),
      height: height,
      width: double.infinity,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(200, 219, 95, 12),
          borderRadius: BorderRadius.circular(20.0)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'title',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Row(
              children: [
                Spacer(),
                Icon(Icons.wallet),
              ],
            ),
            Container(
              height: height / 4,
              width: width / 3,
              child: Text(
                'i am here how are you ' * 3,
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
                Spacer(),
                Text('created at 10/12/2023'),
              ],
            ),
          ]),
    );
  }
}
