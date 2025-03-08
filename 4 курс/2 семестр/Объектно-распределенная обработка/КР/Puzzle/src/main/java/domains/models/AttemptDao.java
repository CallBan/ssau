package domains.models;


import utils.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import domains.dto.AttemptRequest;
import domains.dto.AttemptResponse;
import domains.dto.UserScoreResponse;

public class AttemptDao {
	UserDao userDao = new UserDao();
    // Метод для добавления новой попытки
	public void addAttempt(AttemptRequest attempt) {
	    String sql = "INSERT INTO attempts (user_id, moves, time_spent, success, score, num_pairs) VALUES (?, ?, ?, ?, ?, ?)";
	    
	    try (Connection conn = DatabaseUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setInt(1, attempt.getUserId());
	        pstmt.setInt(2, attempt.getMoves());
	        
	        // Отправляем timeSpent как количество секунд
	        long seconds = Long.parseLong(attempt.getTimeSpent());
	        pstmt.setLong(3, seconds); // Используем setLong для хранения времени в секундах
	        
	        pstmt.setBoolean(4, attempt.isSuccess());
	        pstmt.setInt(5, attempt.getScore());
	        pstmt.setInt(6, attempt.getNumPairs());  // Добавляем количество выбранных пар
	        
	        pstmt.executeUpdate();
	        System.out.println("Попытка успешно добавлена.");
	    } catch (SQLException e) {
	        e.printStackTrace(); // Обработка исключений
	    }
	}




    // Метод для получения всех попыток
    public List<AttemptResponse> getAllAttempts() {
        List<AttemptResponse> attempts = new ArrayList<>();
        String sql = "SELECT * FROM attempts";

        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
             
            while (rs.next()) {
                AttemptResponse attempt = new AttemptResponse(rs.getInt("id"), 
                		rs.getInt("user_id"), rs.getInt("moves"), rs.getString("time_spent"),
                		rs.getBoolean("success"), rs.getInt("score"), rs.getInt("score"),
                		rs.getTimestamp("game_date").toLocalDateTime());
                attempts.add(attempt);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Обработка исключений
        }
        
        return attempts;
    }

    // Метод для получения попыток конкретного пользователя
    public List<AttemptResponse> getAttemptsByUserId(int userId) {
        List<AttemptResponse> attempts = new ArrayList<>();
        String sql = "SELECT * FROM attempts WHERE user_id = ? ORDER BY attempts.game_date desc";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
            	AttemptResponse attempt = new AttemptResponse(rs.getInt("id"), 
                		rs.getInt("user_id"), rs.getInt("moves"), rs.getString("time_spent"),
                		rs.getBoolean("success"), rs.getInt("score"),  rs.getInt("num_pairs"), 
                		rs.getTimestamp("game_date").toLocalDateTime());
                
                attempts.add(attempt);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Обработка исключений
        }
        
        return attempts;
    }
    
 // Метод для получения пользователей и их рейтингов
    public List<UserScoreResponse> getUserScores() {
        List<UserScoreResponse> userScores = new ArrayList<>();
        String sql = "SELECT username, SUM(score) AS total_score " +
                     "FROM attempts a " +
                     "JOIN users u ON a.user_id = u.id " + // Предполагается, что у вас есть таблица пользователей
                     "GROUP BY u.id " +
                     "ORDER BY total_score DESC " +
                     "LIMIT 10"; // Ограничиваем до 10 лучших результатов

        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            int rank = 1; // Начинаем с 1 для ранжирования
            while (rs.next()) {
                String username = rs.getString("username");
                int totalScore = rs.getInt("total_score");
                
                UserScoreResponse userScore = new UserScoreResponse(username, totalScore, rank);
                userScores.add(userScore);
                rank++; // Увеличиваем ранг для следующего пользователя
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Обработка исключений
        }
        
        return userScores;
    }


}

