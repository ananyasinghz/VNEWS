import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String _searchText = '';

  // Dummy data for live and upcoming events
  final List<Map<String, dynamic>> liveEvents = [
    {
      'logo': 'assets/my_logo.png',
      'name': 'Tech Talk',
      'location': 'Auditorium A',
    },
    // Add more live events here
  ];
  final List<Map<String, dynamic>> upcomingEvents = [
    {
      'logo': 'assets/club2_logo.png',
      'name': 'Art Workshop',
      'club': 'Art Club',
      'venue': 'Room 101',
      'date': 'April 15, 2024',
      'time': '10:00 AM',
    },
    // Add more upcoming events here
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Live Events',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              ...liveEvents.map((event) => event['name'].contains(_searchText)
                  ? ListTile(
                      leading: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: AssetImage(event['logo']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(event['name']),
                      subtitle: Text(event['location']),
                      isThreeLine: true,
                    )
                  : Container()),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Upcoming Events',
                    style: Theme.of(context).textTheme.headline5),
              ),
              ...upcomingEvents
                  .map((event) => event['name'].contains(_searchText)
                      ? ExpansionTile(
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: AssetImage(event['logo']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text('${event['name']} - ${event['club']}'),
                          children: <Widget>[
                            ListTile(
                              title: Text('Venue: ${event['venue']}'),
                              subtitle: Text(
                                  'Date: ${event['date']} at ${event['time']}'),
                            ),
                          ],
                        )
                      : Container()),
            ],
          ),
        ),
      ],
    );
  }
}
