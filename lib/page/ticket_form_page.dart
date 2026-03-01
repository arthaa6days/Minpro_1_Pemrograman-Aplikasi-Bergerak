import 'package:flutter/material.dart';
import 'package:aplikasi_manajemen_tiket_konser/model/ticket.dart';

class TicketFormPage extends StatefulWidget {
  final Ticket? ticket;

  const TicketFormPage({super.key, this.ticket});

  @override
  State<TicketFormPage> createState() => _TicketFormPageState();
}

class _TicketFormPageState extends State<TicketFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _artistController;
  late TextEditingController _venueController;
  late TextEditingController _priceController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.ticket?.concertName ?? '');
    _artistController = TextEditingController(text: widget.ticket?.artist ?? '');
    _venueController = TextEditingController(text: widget.ticket?.venue ?? '');
    _priceController = TextEditingController(text: widget.ticket?.price.toString() ?? '');
    _dateController = TextEditingController(text: widget.ticket?.date ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _artistController.dispose();
    _venueController.dispose();
    _priceController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ticket == null ? 'Tambah Tiket' : 'Edit Tiket'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Konser',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Nama konser tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _artistController,
                decoration: const InputDecoration(
                  labelText: 'Nama Artis',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Nama artis tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal (e.g. 20 Mei 2024)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Tanggal tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _venueController,
                decoration: const InputDecoration(
                  labelText: 'Lokasi/Venue',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Lokasi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Harga Tiket',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    double.tryParse(value!) == null ? 'Masukkan harga yang valid' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final ticket = Ticket(
                      id: widget.ticket?.id ?? DateTime.now().toString(),
                      concertName: _nameController.text,
                      artist: _artistController.text,
                      date: _dateController.text,
                      venue: _venueController.text,
                      price: double.parse(_priceController.text),
                    );
                    Navigator.pop(context, ticket);
                  }
                },
                child: Text(
                  widget.ticket == null ? 'Simpan' : 'Update',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

