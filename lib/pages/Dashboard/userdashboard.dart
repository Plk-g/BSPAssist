import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Dashboard',
      home: UserDashboardPage(),
    );
  }
}

class UserDashboardPage extends StatelessWidget {
  final List<TicketData> submittedTickets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewTicketPage(submittedTickets)), // Navigate to New Ticket page
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Set the background color to white
              elevation: 0, // Remove the shadow
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('New Ticket', style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TicketStatusPage(submittedTickets)), // Navigate to Ticket Status page
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
              // TODO: Implement Closed Ticket functionality
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Set the background color to white
              elevation: 0, // Remove the shadow
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Closed Ticket', style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}

class NewTicketPage extends StatefulWidget {
  final List<TicketData> submittedTickets;

  NewTicketPage(this.submittedTickets);

  @override
  _NewTicketPageState createState() => _NewTicketPageState();
}

class _NewTicketPageState extends State<NewTicketPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPriority;
  String? _selectedTicketType;

  @override
  void initState() {
    super.initState();
    _selectedPriority = 'Critical';
    _selectedTicketType = 'Request';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Ticket'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Entered By'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the Entered By field.';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Priority'),
                value: _selectedPriority,
                items: ['Critical', 'High', 'Medium'].map((priority) {
                  return DropdownMenuItem<String>(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPriority = value;
                  });
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please select the Priority field.';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Ticket Type'),
                value: _selectedTicketType,
                items: ['Request', 'Complaint', 'Query'].map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTicketType = value;
                  });
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please select the Ticket Type field.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the Status field.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Domain(s)'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the Domain(s) field.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Header'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the Header field.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the Description field.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Customer ID'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the Customer ID field.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the Customer Name field.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Customer Department'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the Customer Department field.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Customer Contact Number'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the Customer Contact Number field.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Form is valid, proceed with ticket submission
                    // Save the ticket and the date and time
                    saveTicket();
                    Navigator.pop(context);
                  } else {
                    // Form is not valid, show error message
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Please fill all the mandatory fields.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Submit Ticket'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveTicket() {
    // Build the ticket data
    TicketData ticketData = TicketData(
      enteredBy: enteredByController.text,
      priority: _selectedPriority!,
      ticketType: _selectedTicketType!,
      status: statusController.text,
      domains: domainController.text,
      header: headerController.text,
      description: descriptionController.text,
      customerID: customerIdController.text,
      customerName: customerNameController.text,
      customerDepartment: customerDepartmentController.text,
      customerContactNumber: customerContactNumberController.text,
      submitDateTime: DateTime.now(),
    );

    // Add the ticket data to the submittedTickets list
    widget.submittedTickets.add(ticketData);
  }

  // Controllers for each TextFormField
  final TextEditingController enteredByController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController domainController = TextEditingController();
  final TextEditingController headerController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController customerIdController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerDepartmentController = TextEditingController();
  final TextEditingController customerContactNumberController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    enteredByController.dispose();
    statusController.dispose();
    domainController.dispose();
    headerController.dispose();
    descriptionController.dispose();
    customerIdController.dispose();
    customerNameController.dispose();
    customerDepartmentController.dispose();
    customerContactNumberController.dispose();
    super.dispose();
  }
}

class TicketData {
  final String enteredBy;
  final String priority;
  final String ticketType;
  final String status;
  final String domains;
  final String header;
  final String description;
  final String customerID;
  final String customerName;
  final String customerDepartment;
  final String customerContactNumber;
  final DateTime submitDateTime;

  TicketData({
    required this.enteredBy,
    required this.priority,
    required this.ticketType,
    required this.status,
    required this.domains,
    required this.header,
    required this.description,
    required this.customerID,
    required this.customerName,
    required this.customerDepartment,
    required this.customerContactNumber,
    required this.submitDateTime,
  });
}

class TicketStatusPage extends StatelessWidget {
  final List<TicketData> submittedTickets;

  TicketStatusPage(this.submittedTickets);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Status'),
      ),
      body: ListView.builder(
        itemCount: submittedTickets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Ticket ${index + 1}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Entered By: ${submittedTickets[index].enteredBy}'),
                Text('Priority: ${submittedTickets[index].priority}'),
                Text('Ticket Type: ${submittedTickets[index].ticketType}'),
                Text('Status: ${submittedTickets[index].status}'),
                Text('Domain(s): ${submittedTickets[index].domains}'),
                Text('Header: ${submittedTickets[index].header}'),
                Text('Description: ${submittedTickets[index].description}'),
                Text('Customer ID: ${submittedTickets[index].customerID}'),
                Text('Customer Name: ${submittedTickets[index].customerName}'),
                Text('Customer Department: ${submittedTickets[index].customerDepartment}'),
                Text('Customer Contact Number: ${submittedTickets[index].customerContactNumber}'),
                Text('Date and Time: ${submittedTickets[index].submitDateTime.toString()}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
