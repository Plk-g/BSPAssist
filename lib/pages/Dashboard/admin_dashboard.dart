import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      home: AdminDashboardPage(),
    );
  }
}

class AdminDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TicketStatusPage()), // Navigate to Ticket Status page
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Set the background color to white
              elevation: 0, // Remove the shadow
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Ticket Status', style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AssignTicketsPage()), // Navigate to Assign Tickets page
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Set the background color to white
              elevation: 0, // Remove the shadow
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Assign Tickets', style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateDomainPage()), // Navigate to Update Domain page
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Set the background color to white
              elevation: 0, // Remove the shadow
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Update Domain', style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}

class TicketStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Status'),
      ),
      body: Center(
        child: Text('Ticket Status Page'),
      ),
    );
  }
}

class AssignTicketsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Tickets'),
      ),
      body: Center(
        child: Text('Assign Tickets Page'),
      ),
    );
  }
}

class UpdateDomainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Domain'),
      ),
      body: Center(
        child: Text('Update Domain Page'),
      ),
    );
  }
}
