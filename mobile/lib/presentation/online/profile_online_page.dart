// lib/presentacion/online/profile_online_page.dart
import 'package:flutter/material.dart';
import '../../services/user_service.dart';
import '../../data/remote/models/user_model.dart';
import '../../widgets/loading_widget.dart';

class ProfileOnlinePage extends StatefulWidget {
  final UserModel user;

  const ProfileOnlinePage({super.key, required this.user});

  @override
  State<ProfileOnlinePage> createState() => _ProfileOnlinePageState();
}

class _ProfileOnlinePageState extends State<ProfileOnlinePage> {
  final UserService _userService = UserService();
  final _formKey = GlobalKey<FormState>();

  late UserModel _user;
  bool _isLoading = false;
  bool _isEditing = false;

  final TextEditingController _nombreCompletoController =
      TextEditingController();
  final TextEditingController _fechaNacimientoController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _nombreCompletoController.text = _user.nombreCompleto ?? '';
    if (_user.fechaNacimiento != null) {
      _fechaNacimientoController.text =
          "${_user.fechaNacimiento!.day}/${_user.fechaNacimiento!.month}/${_user.fechaNacimiento!.year}";
    }
  }

  Future<void> _actualizarPerfil() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final datosActualizados = {
      'nombre_completo': _nombreCompletoController.text.trim(),
      'fecha_nacimiento': _user.fechaNacimiento?.toIso8601String(),
    };

    final usuarioActualizado = await _userService.actualizarPerfil(
      datosActualizados,
    );

    setState(() {
      _isLoading = false;
      _isEditing = false;
    });

    if (!mounted) return;

    if (usuarioActualizado != null) {
      setState(() => _user = usuarioActualizado);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado exitosamente')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar el perfil')),
      );
    }
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _user.fechaNacimiento ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _user.fechaNacimiento) {
      setState(() {
        _user = _user.copyWith(fechaNacimiento: picked);
        _fechaNacimientoController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Mi Perfil Online'),
        backgroundColor: Colors.purple[900],
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => _isEditing = true),
            ),
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => setState(() => _isEditing = false),
            ),
        ],
      ),
      body: _isLoading
          ? const LoadingWidget(message: 'Actualizando perfil...')
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Información Básica
                    Card(
                      color: Colors.grey[900],
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Información Básica',
                              style: TextStyle(
                                color: Colors.purpleAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),

                            // Email (solo lectura)
                            _infoRow('Email', _user.email, Icons.email),
                            const Divider(color: Colors.grey),

                            // Nombre de Usuario (solo lectura)
                            _infoRow(
                              'Usuario',
                              _user.nombreUsuario,
                              Icons.person,
                            ),
                            const Divider(color: Colors.grey),

                            // Nombre Completo (editable)
                            _isEditing
                                ? TextFormField(
                                    controller: _nombreCompletoController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      labelText: 'Nombre Completo',
                                      labelStyle: TextStyle(
                                        color: Colors.purpleAccent,
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                  )
                                : _infoRow(
                                    'Nombre Completo',
                                    _user.nombreCompleto ?? 'No especificado',
                                    Icons.badge,
                                  ),
                            const Divider(color: Colors.grey),

                            // Fecha de Nacimiento (editable)
                            _isEditing
                                ? GestureDetector(
                                    onTap: _seleccionarFecha,
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: _fechaNacimientoController,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: const InputDecoration(
                                          labelText: 'Fecha de Nacimiento',
                                          labelStyle: TextStyle(
                                            color: Colors.purpleAccent,
                                          ),
                                          border: OutlineInputBorder(),
                                          suffixIcon: Icon(
                                            Icons.calendar_today,
                                            color: Colors.purpleAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : _infoRow(
                                    'Fecha de Nacimiento',
                                    _user.fechaNacimiento != null
                                        ? "${_user.fechaNacimiento!.day}/${_user.fechaNacimiento!.month}/${_user.fechaNacimiento!.year}"
                                        : 'No especificada',
                                    Icons.cake,
                                  ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Estadísticas del Juego
                    Card(
                      color: Colors.grey[900],
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Estadísticas del Juego',
                              style: TextStyle(
                                color: Colors.purpleAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),

                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              childAspectRatio: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: [
                                _statCard(
                                  'Puntos XP',
                                  _user.puntosExperiencia.toString(),
                                  Colors.yellow,
                                ),
                                _statCard(
                                  'Cristales',
                                  _user.cristalesMagicos.toString(),
                                  Colors.cyan,
                                ),
                                _statCard(
                                  'Nivel',
                                  _user.nivelFisicoActual,
                                  Colors.green,
                                ),
                                _statCard(
                                  'Rango',
                                  _user.rangoActual?.toString() ?? 'Novato',
                                  Colors.orange,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Información de Cuenta
                    Card(
                      color: Colors.grey[900],
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Información de Cuenta',
                              style: TextStyle(
                                color: Colors.purpleAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),

                            _infoRow(
                              'Tipo de Usuario',
                              _user.tipoUsuario,
                              Icons.security,
                            ),
                            const Divider(color: Colors.grey),
                            _infoRow(
                              'Fecha de Registro',
                              '${_user.fechaRegistro.day}/${_user.fechaRegistro.month}/${_user.fechaRegistro.year}',
                              Icons.date_range,
                            ),
                            const Divider(color: Colors.grey),
                            _infoRow(
                              'Último Acceso',
                              '${_user.ultimoAcceso.day}/${_user.ultimoAcceso.month}/${_user.ultimoAcceso.year} ${_user.ultimoAcceso.hour}:${_user.ultimoAcceso.minute}',
                              Icons.access_time,
                            ),
                            const Divider(color: Colors.grey),
                            _infoRow(
                              'Estado',
                              _user.estaActivo ? 'Activo' : 'Inactivo',
                              Icons.check_circle,
                              color: _user.estaActivo
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Botón de Guardar (solo en modo edición)
                    if (_isEditing)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: _actualizarPerfil,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purpleAccent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 15,
                              ),
                            ),
                            child: const Text(
                              'GUARDAR CAMBIOS',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _infoRow(String label, String value, IconData icon, {Color? color}) {
    return Row(
      children: [
        Icon(icon, color: color ?? Colors.purpleAccent, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                value,
                style: TextStyle(
                  color: color ?? Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statCard(String title, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Extensión para copiar UserModel (necesitamos agregar esto al final del archivo)
extension UserModelCopyWith on UserModel {
  UserModel copyWith({
    int? id,
    String? email,
    String? nombreUsuario,
    String? nombreCompleto,
    String? tipoUsuario,
    DateTime? fechaNacimiento,
    String? nivelFisicoActual,
    int? puntosExperiencia,
    int? cristalesMagicos,
    int? rangoActual,
    DateTime? fechaRegistro,
    DateTime? ultimoAcceso,
    bool? estaActivo,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      nombreUsuario: nombreUsuario ?? this.nombreUsuario,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      tipoUsuario: tipoUsuario ?? this.tipoUsuario,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      nivelFisicoActual: nivelFisicoActual ?? this.nivelFisicoActual,
      puntosExperiencia: puntosExperiencia ?? this.puntosExperiencia,
      cristalesMagicos: cristalesMagicos ?? this.cristalesMagicos,
      rangoActual: rangoActual ?? this.rangoActual,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
      ultimoAcceso: ultimoAcceso ?? this.ultimoAcceso,
      estaActivo: estaActivo ?? this.estaActivo,
    );
  }
}
