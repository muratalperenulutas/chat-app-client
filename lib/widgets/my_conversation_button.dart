import 'package:flutter/material.dart';

MaterialButton myConversationButton(double screenHeight){

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
                        const Column(
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "text",
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