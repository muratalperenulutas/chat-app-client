import 'package:auto_route/auto_route.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:flutter/material.dart';

import '../../../data/person/person.dart';

MaterialButton myContactsButton(
    BuildContext context, double screenHeight, Person person) {
  return MaterialButton(
    height: screenHeight / 12,
    color: Color.fromARGB(255, 254, 255, 255),
    onPressed: () {
      AutoRouter.of(context).push(PersonDetailRoute(person: person));
    },
    child: Padding(
      padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 65,
            height: 65,
            child: const CircleAvatar(
              radius: 32.5,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                      'assets/images/murat.png') //NetworkImage()                            ),
                  ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                person.localName ?? "",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                person.description ?? "",
                style: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 85, 92, 94)),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
