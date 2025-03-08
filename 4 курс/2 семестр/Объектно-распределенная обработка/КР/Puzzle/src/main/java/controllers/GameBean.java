package controllers;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.SessionScoped;
import javax.faces.bean.ViewScoped;

import controllers.UserSessionBean;
import domains.dto.AttemptRequest;
import domains.models.AttemptDao;

import java.io.Serializable;
import java.util.List;

@ManagedBean
@ViewScoped
public class GameBean implements Serializable {

    private GameEngine gameEngine;
    private int numberOfPairs;
    private boolean gameStarted;
    private long startTime; // Время начала игры
    private int moves; // Количество ходов
    private String timeSpent;
    private boolean isStatSave;

    @ManagedProperty(value="#{userSession}")
    UserSessionBean userSession;
    
    public UserSessionBean getUserSession() {
        return userSession;
    }

    public void setUserSession(UserSessionBean userSession) {
        this.userSession = userSession;
    }
    
    public GameBean() {
        gameStarted = false;
        gameEngine = new GameEngine(numberOfPairs);
        isStatSave = false;
    }
    
	public void resetGame() {
		gameStarted = false;
        gameEngine = new GameEngine(numberOfPairs);
        moves = 0;
        startTime = 0;
        timeSpent = "";
        isStatSave = false;
    }

    public void startNewGame() {
        if (numberOfPairs <= 0) {
            System.out.println("Количество пар должно быть больше нуля.");
            return;
        }
        isStatSave = false;
        gameStarted = true;
        gameEngine = new GameEngine(numberOfPairs);  // Создаем новый объект игры с новым количеством пар
        this.moves = 0;
        timeSpent = "";
        this.startTime = System.currentTimeMillis();
        System.out.println("Game started with " + numberOfPairs + " pairs.");

    }
    
    public int getRemainingPars() {
    	return numberOfPairs - gameEngine.getFoundPairs();
    }
    
    public void selectCard(Card card) {
        gameEngine.selectCard(card);
        moves++; // Увеличиваем количество ходов при каждом выборе карты
    }

    public List<Card> getCards() {
        return gameEngine.getCards();
    }

    public boolean isGameComplete() {
        if (gameEngine.isGameComplete() && gameStarted) {
        	if (!isStatSave) {
        		saveGameStatistics();
        		isStatSave = !isStatSave;
        	}
        	
            return true;
        }
        return false;
    }

    private void saveGameStatistics() {
        long endTime = System.currentTimeMillis();
        timeSpent = String.valueOf((endTime - startTime) / 1000); // Вычисляем затраченное время в миллисекундах

        // Создаем объект AttemptRequest для сохранения в базе данных
        AttemptRequest attemptRequest = new AttemptRequest(
            userSession.getUser().getId(), // Получаем ID пользователя из сессии
            moves,
            timeSpent, // Переводим миллисекунды в секунды
            true, // Успех (можно изменить в зависимости от логики игры)
            calculateScore(), // Метод для расчета баллов
            numberOfPairs
        );

        // Сохраняем попытку через DAO
        AttemptDao attemptDao = new AttemptDao();
        attemptDao.addAttempt(attemptRequest);
    }

    private int calculateScore() {
        // Пример простой логики для расчета баллов
        return Math.max((numberOfPairs * 100) - (moves * 10), 0); // Чем меньше ходов, тем выше балл
    }
    
    public int getCountMove() {
    	return moves;
    }

    public int getNumberOfPairs() {
        return numberOfPairs;
    }

    public void setNumberOfPairs(int numberOfPairs) {
        this.numberOfPairs = numberOfPairs;
    }

	public boolean isGameStarted() {
		return gameStarted;
	}

	public void setGameStarted(boolean gameStarted) {
		this.gameStarted = gameStarted;
	}

	public String getTimeSpent() {
		return timeSpent;
	}

	public void setTimeSpent(String timeSpent) {
		this.timeSpent = timeSpent;
	}
}
