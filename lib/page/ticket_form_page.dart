import 'package:flutter/material.dart';
import 'package:aplikasi_manajemen_tiket_konser/model/ticket.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.ticket?.concertName ?? '');
    _artistController = TextEditingController(text: widget.ticket?.artist ?? '');
    _venueController = TextEditingController(text: widget.ticket?.venue ?? '');
    _priceController = TextEditingController(text: widget.ticket?.price ?? '');
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

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _saveTicket() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final ticketData = {
        'nama_konser': _nameController.text.trim(),
        'nama_artis': _artistController.text.trim(),
        'tanggal_konser': _dateController.text,
        'lokasi_venue': _venueController.text.trim(),
        'harga': _priceController.text.trim(),
      };

      if (widget.ticket == null) {
        await Supabase.instance.client.from('konser').insert(ticketData);
      } else {
        await Supabase.instance.client
            .from('konser')
            .update(ticketData)
            .eq('id', widget.ticket!.id!);
      }

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.ticket == null ? 'Tiket berhasil disimpan!' : 'Tiket berhasil diperbarui!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal: $e'), backgroundColor: Colors.red, behavior: SnackBarBehavior.floating),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.ticket == null ? 'Tambah Tiket Baru' : 'Edit Tiket'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600), // Batas lebar untuk layar tablet/desktop
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildSectionHeader(Icons.info_outline, 'Informasi Konser'),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _nameController,
                            label: 'Nama Konser',
                            icon: Icons.music_note,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _artistController,
                            label: 'Nama Artis',
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 24),
                          _buildSectionHeader(Icons.location_on_outlined, 'Waktu & Tempat'),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _dateController,
                            readOnly: true,
                            onTap: _selectDate,
                            decoration: const InputDecoration(
                              labelText: 'Tanggal Konser',
                              prefixIcon: Icon(Icons.calendar_today),
                              hintText: 'Pilih Tanggal',
                            ),
                            validator: (v) => v!.isEmpty ? 'Pilih tanggal konser' : null,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _venueController,
                            label: 'Lokasi / Venue',
                            icon: Icons.place,
                          ),
                          const SizedBox(height: 24),
                          _buildSectionHeader(Icons.payments_outlined, 'Biaya'),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _priceController,
                            label: 'Harga Tiket',
                            icon: Icons.attach_money,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _saveTicket,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                widget.ticket == null ? 'SIMPAN TIKET' : 'UPDATE TIKET',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20), // Tambahan padding bawah agar tidak mepet edge
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      validator: (value) => (value == null || value.trim().isEmpty) ? '$label tidak boleh kosong' : null,
    );
  }
}
