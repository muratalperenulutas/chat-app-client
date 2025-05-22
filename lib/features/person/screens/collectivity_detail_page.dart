import 'package:chat_app/data/participant/participant.dart';
import 'package:chat_app/data/participant/participant_repository.dart';
import 'package:chat_app/features/chat/models/chat_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectivityDetailPage extends StatefulWidget {
  final ChatBase chatBase;
  const CollectivityDetailPage({required this.chatBase,super.key});

  @override
  State<CollectivityDetailPage> createState() => _CollectivityDetailPageState();
}

class _CollectivityDetailPageState extends State<CollectivityDetailPage> {

  ParticipantRepository participantRepository = Get.find<
      ParticipantRepository>();
  List<Participant> participnats = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }


  Future<void> _loadData() async {
    final data = await participantRepository.getAllParticipants(
        widget.chatBase.collectivityId ?? "");

    setState(() {
      participnats = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Collectivity Detail'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: participnats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(participnats[index].userId.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
