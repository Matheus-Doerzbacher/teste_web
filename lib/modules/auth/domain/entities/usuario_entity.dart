class UsuarioEntity {
  final int id;
  final String username;
  final String name;
  final String email;
  final String? token;
  final int idGrupoUsuario;
  final int idUsuario;
  final bool isSuperuser;
  final String password;
  final bool isActive;

  UsuarioEntity({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    this.token,
    required this.idGrupoUsuario,
    required this.idUsuario,
    this.isSuperuser = false,
    required this.password,
    this.isActive = true,
  });

  // Método fromJson
  factory UsuarioEntity.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return UsuarioEntity(
      id: user['id'] as int,
      username: user['username'] as String,
      name: user['name'] as String,
      email: user['email'] as String,
      token: json['token'] as String?,
      idGrupoUsuario: user['id_grupo_usuario'] as int,
      idUsuario: user['id_usuario'] as int,
      isSuperuser: user['is_superuser'] as bool? ?? false,
      password: user['password'] as String,
      isActive: user['is_active'] as bool? ?? true,
    );
  }

  // Método toJson
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': {
        'id': id,
        'username': username,
        'name': name,
        'email': email,
        'id_grupo_usuario': idGrupoUsuario,
        'id_usuario': idUsuario,
        'is_superuser': isSuperuser,
        'password': password,
        'is_active': isActive,
      }
    };
  }

  // Método copyWith
  UsuarioEntity copyWith({
    int? id,
    String? username,
    String? name,
    String? email,
    String? token,
    int? idGrupoUsuario,
    int? idUsuario,
    bool? isSuperuser,
    String? password,
    bool? isActive,
  }) {
    return UsuarioEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      idGrupoUsuario: idGrupoUsuario ?? this.idGrupoUsuario,
      idUsuario: idUsuario ?? this.idUsuario,
      isSuperuser: isSuperuser ?? this.isSuperuser,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
    );
  }
}
