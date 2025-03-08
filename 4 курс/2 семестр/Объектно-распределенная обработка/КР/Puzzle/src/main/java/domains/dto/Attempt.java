package domains.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Attempt {
    private int userId;           // Идентификатор пользователя
    private int moves;            // Количество ходов
    private String timeSpent;     // Время, затраченное на попытку
    private boolean success;      // Успех попытки
    private int score;            // Балл, полученный за попытку
    private int numPairs;
    private LocalDateTime gameDate; // Дата и время игры
    
    // Формат для отображения даты
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm:ss");
    
    public Attempt() {
    }
    
    public Attempt(int userId, int moves, String timeSpent, boolean success, int score, int numPairs, LocalDateTime gameDate) {
        this.userId = userId;
        this.moves = moves;
        this.timeSpent = timeSpent;
        this.success = success;
        this.score = score;
        this.numPairs = numPairs;
        this.gameDate = gameDate;
    }
    
    public String getResult() {
    	if (success) {
    		return "Да";
    	}
    	else {
    		return "Нет";
    	}
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getMoves() {
        return moves;
    }

    public void setMoves(int moves) {
        this.moves = moves;
    }

    public String getTimeSpent() {
        return timeSpent;
    }

    public void setTimeSpent(String timeSpent) {
        this.timeSpent = timeSpent;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public LocalDateTime getGameDate() {
        return gameDate;
    }

    public void setGameDate(LocalDateTime gameDate) {
        this.gameDate = gameDate;
    }

    // Метод для получения отформатированной даты
    public String getFormattedGameDate() {
        return gameDate.format(formatter);
    }

	public int getNumPairs() {
		return numPairs;
	}

	public void setNumPairs(int numPairs) {
		this.numPairs = numPairs;
	}
}
