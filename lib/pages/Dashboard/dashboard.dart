import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/components/drawer.dart';
import 'package:new_app/pages/login_page.dart';
import 'package:new_app/pages/profile/profile_screen.dart';

void main() => runApp(DashboardApp());

class DashboardApp extends StatelessWidget {
  final List<TicketData> ticketHistory = [
    //TicketData
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardPage(ticketHistory: ticketHistory),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  final List<TicketData> ticketHistory;
  const DashboardPage({required this.ticketHistory});

  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<bool> _isExpandedList = [false, false, false];
  List<TicketData> _ticketStatusList = [];

  void signOut() async {
    try {
      //sign out the user from firebase authentication
      await FirebaseAuth.instance.signOut();

      //after successful sign-out, navigate back to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print("Error signing out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out. Please try again.')),
      );
    }
    //Implementation of sign-out logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You are now signed out!')),
    );
  }

  //navigate to profile page
  void goToProfilePage() async {
    //pop the menu drawer
    Navigator.pop(context);

    //go to the user profile
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserProfile()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: signOut,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _isExpandedList[index] = !isExpanded;
                  });
                },
                children: [
                  _buildExpansionPanel(0, 'Tickets', [
                    'New Ticket',
                    'Ticket Status',
                    'Closed Tickets',
                    'Assign Tickets',
                    'Updated Domain',
                  ]),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Ticket Status:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildTicketStatusList(),
            ],
          ),
        ),
      ),
    );
  }

  ExpansionPanel _buildExpansionPanel(
      int index, String title, List<String> options) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      body: Column(
        children: options.map((option) {
          return ListTile(
            title: Text(option),
            onTap: () {
              _handleOptionTap(title, option);
            },
          );
        }).toList(),
      ),
      isExpanded: _isExpandedList[index],
    );
  }

  void _handleOptionTap(String category, String option) {
    // Implement the navigation or action logic based on the selected option
    switch (category) {
      case 'Tickets':
        if (option == 'New Ticket') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTicketForm(
                onTicketSaved: _onTicketSaved,
                ticketStatusList: _ticketStatusList,
              ),
            ),
          );
        } else if (option == 'Assign Tickets') {
          _navigateToAssignTickets();
        } else {
          // Handle other ticket options
          _navigateToTicketPage(option);
        }
        break;
      default:
      // Handle other options
        break;
    }
  }

  void _onTicketSaved(TicketData ticketData) {
    setState(() {
      _ticketStatusList.add(ticketData);
    });
  }

  void _navigateToTicketPage(String ticketOption) {
    // Implement navigation logic for the ticket options
    // For simplicity, let's just show a snackbar with the selected option.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigating to Ticket: $ticketOption')),
    );
  }
  Widget _buildTicketStatusList() {
    if (_ticketStatusList.isEmpty) {
      return Text('No tickets saved yet.');
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: _ticketStatusList.length,
        itemBuilder: (context, index) {
          final ticket = _ticketStatusList[index];
          return ListTile(
            title: Text('Ticket No: ${ticket.ticketNo}'),
            subtitle: Text('Generated Date and Time: ${ticket.generatedDateTime}'),
            onTap: () {
              _showTicketDetails(ticket);
            },
          );
        },
      );
    }
  }

  void _showTicketDetails(TicketData ticket) {
    // Implement the logic to show the ticket details in a separate page or dialog
    // For simplicity, let's just show a snackbar with the ticket details.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ticket Details: \n${ticket.toString()}')),
    );
  }

  void _navigateToAssignTickets() {
    // Pass the _ticketStatusList to the AssignTicketsForm
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssignTicketsForm(
          ticketStatusList: _ticketStatusList,
        ),
      ),
    );
  }
}

class NewTicketForm extends StatefulWidget {
  final Function(TicketData) onTicketSaved;
  final List<TicketData> ticketStatusList;

  NewTicketForm({required this.onTicketSaved, required this.ticketStatusList});

  @override
  _NewTicketFormState createState() => _NewTicketFormState();
}

class _NewTicketFormState extends State<NewTicketForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _enteredBy = '';
  String _priority = 'High';
  String _status = 'Open';
  String _ticketType = 'complaint'; //Default ticket type
  String _domains = '';
  String _header = '';
  String _description = '';
  String _customerID = '';
  String _customerName = '';
  String _customerDepartment = '';
  String _customerContactNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Ticket'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Priority'),
                    value: _priority,
                    onChanged: (value) {
                      setState(() {
                        _priority = value!;
                      });
                      },
                    items: ['High', 'Critical'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  _buildTextFormField('Entered By', (value) => _enteredBy = value!, 'Please enter the person who entered the ticket.'),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Status'),
                    value: _status,
                    onChanged: (value) {
                      setState(() {
                        _status = value!;

                      });
                },
                    items: ['Open', 'In Progress', 'Closed'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Ticket Type'),
                    value: _ticketType,
                    onChanged: (value) {
                      setState(() {
                        _ticketType = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: 'complaint',
                        child: Text('Complaint'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'query',
                        child: Text('Query'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'request',
                        child: Text('Request'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'other',
                        child: Text('Other'),
                      ),
                    ],
                  ),
              _buildTextFormField('Domain(s)', (value) => _domains = value!, 'Please enter the domain(s) of the ticket.'),
              _buildTextFormField('Header', (value) => _header = value!, 'Please enter the header of the ticket.'),
              _buildTextFormField('Description', (value) => _description = value!, 'Please enter the description of the ticket.'),
              _buildTextFormField('Customer ID', (value) => _customerID = value!, 'Please enter the customer ID.'),
              _buildTextFormField('Customer Name', (value) => _customerName = value!, 'Please enter the customer name.'),
              _buildTextFormField('Customer Department', (value) => _customerDepartment = value!, 'Please enter the customer department.'),
              _buildTextFormField('Customer Contact Number', (value) => _customerContactNumber = value!, 'Please enter the customer contact number.'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save and submit the ticket
                  _saveAndSubmitTicket();
                },
                child: Text('Save & Submit'),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildTextFormField(String label, void Function(String) onChanged, String errorMessage) {
    return TextFormField(
      style: TextStyle(fontSize: 16), // Decrease the font size
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
    );
  }

  void _saveAndSubmitTicket() {
    if (_formKey.currentState!.validate()) {
      // Generate Ticket Number and Current Date Time
      final now = DateTime.now();
      final generatedDateTime = '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}';
      final ticketNo = 'T${widget.ticketStatusList.length + 1}';

      // Create TicketData object and pass it to the parent widget
      final ticketData = TicketData(
        ticketNo: ticketNo,
        generatedDateTime: generatedDateTime,
        enteredBy: _enteredBy,
        priority: _priority,
        status: _status,
        ticketType: _ticketType,
        domains: _domains,
        header: _header,
        description: _description,
        customerID: _customerID,
        customerName: _customerName,
        customerDepartment: _customerDepartment,
        customerContactNumber: _customerContactNumber,
      );

      widget.onTicketSaved(ticketData);

      // Show a snackbar to indicate the ticket is saved and submitted.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ticket Saved and Submitted!')),
      );
    }
  }
}

class TicketData {
  final String ticketNo;
  final String generatedDateTime;
  final String enteredBy;
  final String priority;
  final String status;
  final String ticketType;
  final String domains;
  final String header;
  final String description;
  final String customerID;
  final String customerName;
  final String customerDepartment;
  final String customerContactNumber;

  TicketData({
    required this.ticketNo,
    required this.generatedDateTime,
    required this.enteredBy,
    required this.priority,
    required this.status,
    required this.ticketType,
    required this.domains,
    required this.header,
    required this.description,
    required this.customerID,
    required this.customerName,
    required this.customerDepartment,
    required this.customerContactNumber,
  });

  @override
  String toString() {
    return 'Ticket No: $ticketNo\n'
        'Generated Date and Time: $generatedDateTime\n'
        'Entered By: $enteredBy\n'
        'Priority: $priority\n'
        'Status: $status\n'
        'Ticket Type: $ticketType\n'
        'Domains: $domains\n'
        'Header: $header\n'
        'Description: $description\n'
        'Customer ID: $customerID\n'
        'Customer Name: $customerName\n'
        'Customer Department: $customerDepartment\n'
        'Customer Contact Number: $customerContactNumber';
  }
}

class AssignTicketsForm extends StatefulWidget {
  final List<TicketData> ticketStatusList;

  const AssignTicketsForm({required this.ticketStatusList});

  @override
  _AssignTicketsFormState createState() => _AssignTicketsFormState();
}

class _AssignTicketsFormState extends State<AssignTicketsForm> {
  String _assignedPerson = '';
  String _status = 'Open'; // Default status is 'Open'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Tickets'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Status'),
              value: _status,
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
              items: ['Open', 'In Progress', 'Closed'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Assign the ticket
                _assignTicket();
              },
              child: Text('Assign Ticket'),
            ),
          ],
        ),
      ),
    );
  }

  void _assignTicket() {
    // Implement the logic to assign the ticket
    // For simplicity, let's just show a snackbar with the assigned person and status.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ticket Assigned to: $_assignedPerson\nStatus: $_status')),
    );
  }
}