class AuthDemoData {
  static final Map<String, Map<String, dynamic>> _users = {
    "ahmed": {
      "password": "123456",
      "token": "demo_token_ahmed_12345",
      "role": "employee",
      "user": {
        "id": 1,
        "name": "أحمد محمد",
        "userName": "ahmed",
        "email": "ahmed@example.com",
        "ordersLimit": 5,
        "role": "employee",
      },
    },
    "barista": {
      "password": "123456",
      "token": "demo_token_barista_67890",
      "role": "barista",
      "user": {
        "id": 2,
        "name": "أم أحمد",
        "userName": "barista",
        "email": "barista@example.com",
        "ordersLimit": 3,
        "role": "barista",
      },
    },
    "employee": {
      "password": "123456",
      "token": "demo_token_employee_11111",
      "role": "employee",
      "user": {
        "id": 3,
        "name": "سارة علي",
        "userName": "employee",
        "email": "employee@example.com",
        "ordersLimit": 5,
        "role": "employee",
      },
    },
  };

  static Map<String, dynamic>? login(String username, String password) {
    if (_users.containsKey(username)) {
      final user = _users[username]!;
      if (user['password'] == password) {
        return {'user': user['user'], 'token': user['token']};
      }
    }
    return null;
  }

  static bool logout() {
    return true;
  }
}
