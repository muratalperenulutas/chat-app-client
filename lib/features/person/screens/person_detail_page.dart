import 'package:auto_route/auto_route.dart';
import 'package:chat_app/features/person/models/person_base.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PersonDetailPage extends StatelessWidget {
  final PersonBase personBase;

  const PersonDetailPage({super.key, required this.personBase});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: screenHeight * 0.15,
                height: screenHeight * 0.15,
                child: CircleAvatar(
                  radius: screenHeight * 0.075,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      radius: screenHeight * 0.070,
                      backgroundImage:
                          const AssetImage('assets/images/murat.png')),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.1),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.15,
                      child: Icon(Icons.person),
                    ),
                    SizedBox(
                      width: screenWidth * 0.65,
                      child: Text(personBase.name),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.15,
                        child: const Icon(Icons.alternate_email)),
                    SizedBox(
                        width: screenWidth * 0.65,
                        child: Text(
                          personBase.username,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
