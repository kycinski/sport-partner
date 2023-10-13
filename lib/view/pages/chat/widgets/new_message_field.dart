import 'package:flutter/material.dart';

class NewMessageField extends StatefulWidget {
  const NewMessageField({super.key, required this.onSend});

  final Function(String) onSend;

  @override
  State<NewMessageField> createState() => _NewMessageFieldState();
}

class _NewMessageFieldState extends State<NewMessageField> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  String _enteredMessage = '';

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              focusNode: _focusNode,
              decoration: const InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty
                ? null
                : () {
                    widget.onSend(_enteredMessage);
                    _focusNode.unfocus();
                    setState(() {
                      _textController.clear();
                      _enteredMessage = '';
                    });
                  },
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
