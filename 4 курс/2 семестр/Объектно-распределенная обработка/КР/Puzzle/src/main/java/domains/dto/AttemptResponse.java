package domains.dto;

import java.time.LocalDateTime;

public class AttemptResponse extends Attempt {
    private int id;                // Уникальный идентификатор попытки
    
    public AttemptResponse() {
    	
    }
    
    public AttemptResponse(int id, int userId, int moves, String timeSpent, boolean success, int score, int numPairs, LocalDateTime gameDate) {
    	super(userId, moves, timeSpent, success, score, numPairs, gameDate);
    	this.id = id;
    	System.out.println(gameDate);
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}

