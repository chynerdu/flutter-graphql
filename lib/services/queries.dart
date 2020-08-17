
String getTodos = """
   query getMyTodos {
      todos(where: { is_public: { _eq: false} }, order_by: { created_at: desc }) {
        id
        title
        is_completed
      }
    }
""";

String addTodos = """
  mutation addTodos(\$title: String) {
    insert_todos(objects: [{ title: \$title }]) {
      returning {
        id
        title
        is_completed
        is_public
        created_at
      }
    }
  }
""";