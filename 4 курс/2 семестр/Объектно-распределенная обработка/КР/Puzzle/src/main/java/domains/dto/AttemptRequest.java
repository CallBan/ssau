package domains.dto;

import java.time.LocalDateTime;

public class AttemptRequest extends Attempt {
	public AttemptRequest(int userId, int moves, String timeSpent, boolean success, int score, int numPairs) {
		super(userId, moves, timeSpent, success, score, numPairs, LocalDateTime.now());
	}
}
