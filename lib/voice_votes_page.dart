import 'package:flutter/material.dart';
import 'dart:math';

class VoicesVotesContent extends StatefulWidget {
  @override
  _VoicesVotesContentState createState() => _VoicesVotesContentState();
}

class _VoicesVotesContentState extends State<VoicesVotesContent> {
  List<Poll> polls = [
    Poll(question: 'Do you like Flutter?', options: ['Yes', 'No', 'Maybe']),
    Poll(
        question: 'Your favorite programming language?',
        options: ['Dart', 'Python', 'JavaScript']),
  ];

  void _addPoll() {
    // Function to show dialog and add a poll
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Variables to hold form data
        String question = '';
        List<String> options = ['', ''];

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Create a New Poll'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      decoration:
                          InputDecoration(hintText: 'Enter poll question'),
                      onChanged: (value) {
                        question = value;
                      },
                    ),
                    ...options.map((option) {
                      return TextField(
                        decoration:
                            InputDecoration(hintText: 'Enter an option'),
                        onChanged: (value) {
                          options[options.indexOf(option)] = value;
                        },
                      );
                    }).toList(),
                    if (options.length < 4)
                      ElevatedButton(
                        child: Text('Add Option'),
                        onPressed: () {
                          setState(() {
                            options.add('');
                          });
                        },
                      ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (question.isNotEmpty &&
                        options.every((option) => option.isNotEmpty)) {
                      setState(() {
                        polls.add(Poll(question: question, options: options));
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Poll request sent to admin'),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: polls.length,
        itemBuilder: (context, index) {
          return PollCard(poll: polls[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPoll,
        tooltip: 'Create New Poll',
        child: Icon(Icons.add),
      ),
    );
  }
}

class PollCard extends StatefulWidget {
  final Poll poll;

  PollCard({required this.poll});

  @override
  _PollCardState createState() => _PollCardState();
}

class _PollCardState extends State<PollCard> {
  String? selectedOption;
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(widget.poll.question),
            subtitle: widget.poll.isOpen ? Text('Vote Now') : Text('Closed'),
          ),
          ...widget.poll.options.map((option) => RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: selectedOption,
                onChanged: widget.poll.isOpen && !isSubmitted
                    ? (String? value) {
                        setState(() {
                          selectedOption = value;
                          // Here you would also handle saving the vote
                        });
                      }
                    : null,
              )),
          if (widget.poll.isOpen && !isSubmitted)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isSubmitted = true;
                });
                // Handle logic to close the poll and submit the votes
              },
              child: Text('Submit Vote'),
            ),
          if (isSubmitted) Text('Submitted'),
        ],
      ),
    );
  }
}

class Poll {
  String question;
  List<String> options;
  Map<String, int> votes;
  bool isOpen;

  Poll({required this.question, required this.options})
      : votes = Map.fromIterable(options, key: (e) => e, value: (e) => 0),
        isOpen = true;
}
