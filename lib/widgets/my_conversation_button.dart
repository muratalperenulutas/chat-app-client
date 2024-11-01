import 'package:chat_app/models/group.dart';
import 'package:flutter/material.dart';

MaterialButton myConversationButton(double screenHeight,GroupModel group){

  return MaterialButton(
                  height: screenHeight / 12,
                  color: Color.fromARGB(255, 254, 255, 255),
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          child: const CircleAvatar(
                            radius: 32.5,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                    "") //NetworkImage()                            ),
                                ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              group.name,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              group.isDirectChat.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 85, 92, 94)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
}