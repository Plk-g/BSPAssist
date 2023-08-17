import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_app/components/text_box.dart';
import 'package:new_app/components/ticketdata.dart';


class UserProfile extends StatefulWidget {
   const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //Ticket History
  List<TicketData> ticketHistory = [];

  //Edit field
  Future<void> editField(String field) async {
    //add implementation to edit user fields
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile Page"),
        backgroundColor: Colors.indigo,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          //profile pic
          Icon(
            Icons.person,
            size: 72,
          ),
          const SizedBox(height: 10),
          //user email id
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 40),
          //user detials
          Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'My Details',
                style: TextStyle(color: Colors.black),
              ),
          ),


          //username
          MyTextBox(
            text: 'PalakGupta',
            sectionName:'UserName',
            onPressed: () => editField('UserName'),
          ),

          //customer Id
          MyTextBox(
            text: 'EMP123',
            sectionName:'EmployeeID',
            onPressed: () => editField('EmployeeID'),
          ),

          // Tickets Table
          _buildTicketsTable(),
        ],
      ),
    );
  }

  Widget _buildTicketsTable() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ticket History:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.vertical, // Allow vertical scrolling
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Allow horizontal scrolling
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Ticket No')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Date/Time')),
                ],
                rows: ticketHistory.map((ticket) {
                  return DataRow(cells: [
                    DataCell(Text(ticket.ticketNo)),
                    DataCell(Text(ticket.status)),
                    DataCell(Text(ticket.dateTime.toString())),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _onTicketSaved(TicketData ticketData){
    setState(() {
      ticketHistory.add(ticketData);
    });
  }
  void _navigateToTicketPage(String ticketOption) {
    final now = DateTime.now();
    final generatedDateTime = now;
        '${now.year}-${_formatTwoDigit(now.month)}-${_formatTwoDigit(now.day)} ${_formatTwoDigit(now.hour)}:${_formatTwoDigit(now.minute)}:${_formatTwoDigit(now.second)}'; // Format the date and time'
    
    // Creating a new TicketData object for the new ticket
    final newTicket = TicketData(
        ticketNo: 'T${ticketHistory.length + 1}', // Generate ticket number,
        dateTime: generatedDateTime,
        status: 'Open'
    );
    //save and submit the ticket
    _onTicketSaved(newTicket);
    
    //show a snackbar 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ticket Raised: $ticketOption')),
     );
    }
  }
  String _formatTwoDigit(int number) {
  return number.toString().padLeft(2, '0');
}

