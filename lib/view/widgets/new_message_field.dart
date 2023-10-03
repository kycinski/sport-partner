import 'package:flutter/material.dart';

class NewMessageField extends StatelessWidget {
  const NewMessageField({super.key, required this.controller, required this.onSend});

  final TextEditingController controller;
  final void Function()? onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                // setState(() {
                //   _enteredMesseage = value;
                // });
              },
            ),
          ),
          IconButton(
            onPressed: controller.text.trim().isEmpty ? null : onSend,
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
