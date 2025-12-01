import 'package:auto_route/auto_route.dart';
import 'package:chat_app/core/router/app_router.dart';
import 'package:chat_app/data/contact/contact.dart';
import 'package:chat_app/features/person/models/person_base.dart';
import 'package:flutter/material.dart';

MaterialButton myContactsButton(
    BuildContext context, double screenHeight, Contact contact) {
  return MaterialButton(
    height: screenHeight / 12,
    color: Color.fromARGB(255, 254, 255, 255),
    onPressed: () {
      AutoRouter.of(context).push(PersonDetailRoute(personBase: PersonBase.fromContact(contact)));
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
                contact.name,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                contact.username,
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
