import 'package:flutter/material.dart';

class PrimePage extends StatelessWidget {
  final List<String> newsHeadlines = [
    'Breaking News: Flutter Tops Charts in Developer Satisfaction!',
    'VIT Chennai Wins National Hackathon',
    'New Study Reveals Benefits of Bananas for Programmers',
    
  ];

  final List<String> recentNews = [
    'Yesterday: VIT Chennai Celebrates Annual Sports Day',
    '2 Days Ago: Flutter Workshop Conducted by V-NEWS Team',
    
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Latest News Headlines',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        ...newsHeadlines.map((headline) => NewsCard(headline)).toList(),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Recent News',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        ...recentNews.map((news) => NewsCard(news)).toList(),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  final String news;

  NewsCard(this.news);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(news),
      ),
    );
  }
}
