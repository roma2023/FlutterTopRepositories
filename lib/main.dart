// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart'; // Import the Material library for the ScrollButton widget
import 'package:http/http.dart' as http; // Import the http package to make HTTP requests
import 'dart:convert'; // Import the dart:convert library to decode the JSON response from the server
import 'dart:developer'; 


void main(){

runApp(MyApp()); // Run the app
WidgetsFlutterBinding.ensureInitialized();
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MainPage(), // The main page of the app
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
} 


class _MainPageState extends State<MainPage> {
  int _selectedNumber = 5; // default value for the scroll button
  List<Repository>? _repositories ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              // Scroll button with numbers of selection
              ScrollButton(
                onChanged: (value) {
                  setState(() {
                    _selectedNumber = value!;
                  });
                },
                value: _selectedNumber,
              ),
              // Fetch button
              TextButton(
                onPressed: () {
                  fetchTopRepositories(_selectedNumber).then((res) {
                    setState(() {
                      _repositories = res;
                    });
                  
                  }).catchError((error) {
                    log(error);
                  });
                },
                child: Text('Fetch'),
              ),
            ],
          ),
          // Display the fetched _repositories
          if (_repositories != null)

          Expanded(
            child: RepositoryList(repositories: _repositories!),
          )
          else 
          Text('Nothing to display')
          
        ],
      ),
    );
  }
}

class ScrollButton extends StatelessWidget {
  final ValueChanged<int?>? onChanged;
  final int? value;

  const ScrollButton({
    Key? key,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: value,
      items: [5, 10, 15].map((number) {
        return DropdownMenuItem(
          value: number,
          child: Text('$number'),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

// A class to represent a repository
class Repository {
  final String name;
  final String url;
  final String description;
  final int stargazersCount;

  Repository(
    this.name,
    this.url,
    this.description,
    this.stargazersCount,
  );
}

// Fetch the top _repositories in GitHub
Future<List<Repository>> fetchTopRepositories(int number) async {
  final response = await http.get(Uri.parse(
    'https://api.github.com/search/repositories?q=stars:%3E1&sort=stars&order=desc&per_page=$number',
  ));
  log(response.statusCode.toString());
  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    final data = json.decode(response.body);
  
    var items = data['items'] as List;
    List<Repository> items2 = items.map((item) {
      log(item['name'].toString());
      return Repository(
        item['name'],
        item['html_url'],
        item['description'],
        item['stargazers_count'],
      );
    }).toList();

    return items2;
  } else {
    // If the server returns an error, throw an exception
    throw Exception('Failed to load _repositories');
  }
}

// A widget to display a single repository
class RepositoryWidget extends StatelessWidget {
  Repository repository;

  RepositoryWidget(this.repository);

  @override
  Widget build(BuildContext context)
   {
    log(repository.description);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              repository.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              repository.url,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              repository.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${repository.stargazersCount} stargazers',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RepositoryList extends StatefulWidget {
   List<Repository> repositories = [Repository("name", "url", "description", 12)];
  // ignore: prefer_const_constructors_in_immutables
  RepositoryList({
   required this.repositories ,
    Key? key,
  }):super(key: key);

  @override
  createState() => _RepositoryListState();

  
}

class _RepositoryListState extends State<RepositoryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.repositories.length,
      itemBuilder: (context, index) {
        return RepositoryWidget(widget.repositories[index]);
      },
    );
  }
}