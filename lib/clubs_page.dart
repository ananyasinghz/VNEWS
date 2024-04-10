import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ClubsPage extends StatelessWidget {
  final DocumentReference club = FirebaseFirestore.instance.collection('Clubs').doc('Produnnio');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: club.get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return ListView(
            children: [
              ClubCard(
                clubName: data['description'],
                logoUrl: 'assets/coding_club_logo.png', // Add your club logo image
                applyLink: data['application'],
                onPressedResults: () {
                  // Handle "Results" button press
                  // You can navigate to the results page or perform any other action
                },
              ),
              // Add more club cards as needed
            ],
          );
        }

        return Text("Loading");
      },
    );
  }
}

class ClubCard extends StatelessWidget {
  final String clubName;
  final String logoUrl;
  final String applyLink;
  final VoidCallback onPressedResults;

  ClubCard({
    required this.clubName,
    required this.logoUrl,
    required this.applyLink,
    required this.onPressedResults,
  });

  // Function to launch the apply link
  _launchApplyLink() async {
    if (await canLaunch(applyLink)) {
      await launch(applyLink);
    } else {
      // Handle error (e.g., show an error message)
      print('Error launching link: $applyLink');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            title: Text(clubName),
            leading: Image.asset(logoUrl), // Display club logo
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _launchApplyLink,
                child: Text('Apply Now'),
              ),
              ElevatedButton(
                onPressed: onPressedResults,
                child: Text('Results'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
