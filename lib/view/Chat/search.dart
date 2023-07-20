import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/cubits/searchcubit/search_cubit.dart';
import 'package:project3/module/user.dart';

import 'package:project3/styles/styles.dart';
import 'package:project3/view/chatWithPerson/personchat.dart';
import 'package:project3/widget/sharedwidget.dart';

class SearchWidgets extends StatelessWidget {
  SearchWidgets({
    super.key,
  });
  final TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..getalluser(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubitprovider = BlocProvider.of<SearchCubit>(context);

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: true,
                // toolbarHeight: 53,
                flexibleSpace: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 5,
                  ),
                  width: double.infinity,
                  // height: 90,
                  child: defaultFormField(
                    border: const OutlineInputBorder(
                      gapPadding: 2.0,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    hint: 'search',
                    fillcolor: Style.bordercolor,
                    prefix: Icon(Icons.search),
                    controller: searchcontroller,
                    type: TextInputType.text,
                    validate: (String? value) {
                      return null;
                    },
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Personchatpar(user:cubitprovider.allusers[index],);
                }, childCount: cubitprovider.allusers.length),
              )
            ],
          );
        },
      ),
    );
  }
}

class Personchatpar extends StatelessWidget {
  final SocialUserModel user;
  const Personchatpar({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            navigateto(
                context: context,
                widget: ChatDetails(
                  user: user,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SizedBox(
              height: 56,
              width: double.infinity,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      user.cover!,
                    ),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        user.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Style.nametext,
                      ),
                      const Spacer(),
                      Text(
                        'this my last message massage',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Style.masege,
                      ),
                      const SizedBox(
                        height: 3,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        '3m ago',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Style.nametext,
                      ),
                      const Spacer()
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 0.2,
          color: Style.bordercolor,
          margin: const EdgeInsets.only(left: 70),
        )
      ],
    );
  }
}
