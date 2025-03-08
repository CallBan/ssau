package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;
import java.sql.PreparedStatement;

public class DatabaseUtil {

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(config.URL, config.USER, config.PASSWORD);
    }

    public static void initializeDatabase() {
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {

            // Проверка существования таблицы users
            boolean usersTableExists = checkTableExists(conn, "users");
            boolean attemptsTableExists = checkTableExists(conn, "attempts");

            // Создание таблицы пользователей, если она не существует
            if (!usersTableExists) {
                String createUsersTable = "CREATE TABLE users (" +
                        "id SERIAL PRIMARY KEY, " +
                        "username VARCHAR(50) UNIQUE NOT NULL, " +
                        "password VARCHAR(255) NOT NULL" +
                        ");";
                stmt.executeUpdate(createUsersTable);
                System.out.println("Таблица users создана.");
            }

            // Создание таблицы попыток, если она не существует
            if (!attemptsTableExists) {
                String createAttemptsTable = "CREATE TABLE attempts (" +
                        "id SERIAL PRIMARY KEY, " +
                        "user_id INT REFERENCES users(id) ON DELETE CASCADE, " +
                        "moves INT NOT NULL, " +
                        "time_spent BIGINT NOT NULL, " +
                        "success BOOLEAN NOT NULL, " +
                        "score INT NOT NULL, " +
                        "num_pairs INT NOT NULL, " +
                        "game_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                        ");";
                stmt.executeUpdate(createAttemptsTable);
                System.out.println("Таблица attempts создана.");
            }

            // Если таблицы были созданы, добавляем тестовые данные
            if (!usersTableExists || !attemptsTableExists) {
                insertTestData(conn);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static boolean checkTableExists(Connection conn, String tableName) throws SQLException {
        try (ResultSet rs = conn.getMetaData().getTables(null, null, tableName, null)) {
            return rs.next(); // Если таблица существует, вернет true
        }
    }

    private static void insertTestData(Connection conn) {
        Random random = new Random(); // Создаем экземпляр Random для генерации случайных чисел

        try {
            // Вставка 3 пользователей
            String[] usernames = {"user1", "user2", "user3"};
            String password = "password123"; // Пароль для всех пользователей

            for (String username : usernames) {
                // Вставка пользователя
                String insertUserQuery = "INSERT INTO users (username, password) VALUES (?, ?);";
                try (PreparedStatement pstmt = conn.prepareStatement(insertUserQuery, Statement.RETURN_GENERATED_KEYS)) {
                    pstmt.setString(1, username);
                    pstmt.setString(2, password);
                    pstmt.executeUpdate();

                    // Получаем ID вставленного пользователя
                    try (var generatedKeys = pstmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int userId = generatedKeys.getInt(1);

                            // Вставка 5 попыток для каждого пользователя
                            String insertAttemptQuery = "INSERT INTO attempts (user_id, moves, time_spent, success, score, num_pairs) " +
                                    "VALUES (?, ?, ?, ?, ?, ?);";
                            try (PreparedStatement attemptStmt = conn.prepareStatement(insertAttemptQuery)) {
                                for (int i = 1; i <= 5; i++) {
                                    attemptStmt.setInt(1, userId);
                                    attemptStmt.setInt(2, i * 10); // Пример: moves = 10, 20, 30, 40, 50
                                    attemptStmt.setLong(3, i * 1000); // Пример: time_spent = 1000, 2000, 3000, 4000, 5000 мс
                                    attemptStmt.setBoolean(4, i % 2 == 0); // Пример: success = true/false

                                    // Генерируем случайное значение для score в диапазоне от 50 до 150
                                    int randomScore = 50 + random.nextInt(101); // 0-100 + 50 = 50-150
                                    attemptStmt.setInt(5, randomScore); // Устанавливаем случайный score

                                    attemptStmt.setInt(6, i); // Пример: num_pairs = 1, 2, 3, 4, 5
                                    attemptStmt.executeUpdate();
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}