package domains.models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domains.dto.UserRequest;
import domains.dto.UserResponse;
import utils.DatabaseUtil;

public class UserDao {
    // Метод для сохранения пользователя в базе данных
    public void save(UserRequest user) {
        String sql = "INSERT INTO users (username, password) VALUES (?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Обработка исключений
        }
    }

    // Метод для получения пользователя по имени
    public UserResponse findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        UserResponse user = null;
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new UserResponse(rs.getInt("id"), rs.getString("username"), rs.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Обработка исключений
        }
        return user;
    }
    
 // Метод для получения имени пользователя по ID
    public String getUsernameById(int userId) {
        String username = "";
        String sql = "SELECT id, username FROM users WHERE id = ?"; // Предполагаем, что у вас есть таблица users
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
            	System.out.println(rs.getString("username"));
                UserResponse user = new UserResponse(rs.getInt("id"), rs.getString("username"), "");
                username = user.getUsername();
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Обработка исключений
        }
        
        return username;
    }


    // Метод для получения всех пользователей
    public List<UserResponse> findAll() {
        List<UserResponse> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
            	UserResponse user = new UserResponse(rs.getInt("id"), rs.getString("username"), rs.getString("password"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Обработка исключений
        }
        return users;
    }
}
