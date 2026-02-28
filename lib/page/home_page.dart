import 'package:flutter/material.dart';
import 'package:aplikasi_manajemen_tiket_konser/model/ticket.dart';
import 'package:aplikasi_manajemen_tiket_konser/page/ticket_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Ticket> _tickets = [];

  void _addTicket() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TicketFormPage()),
    );

    if (result != null && result is Ticket) {
      setState(() {
        _tickets.add(result);
      });
    }
  }

  void _editTicket(Ticket ticket, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TicketFormPage(ticket: ticket)),
    );

    if (result != null && result is Ticket) {
      setState(() {
        _tickets[index] = result;
      });
    }
  }

  void _deleteTicket(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Tiket'),
        content: const Text('Apakah Anda yakin ingin menghapus tiket ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _tickets.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konser Island'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: _tickets.isEmpty
          ? const Center(child: Text('Belum ada tiket. Ketuk + untuk menambah.'))
          : ListView.builder(
              itemCount: _tickets.length,
              itemBuilder: (context, index) {
                final ticket = _tickets[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      ticket.concertName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${ticket.artist}\n${ticket.date} @ ${ticket.venue}'),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editTicket(ticket, index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTicket(index),
                        ),
                      ],
                    ),
                    onTap: () => _editTicket(ticket, index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTicket,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
