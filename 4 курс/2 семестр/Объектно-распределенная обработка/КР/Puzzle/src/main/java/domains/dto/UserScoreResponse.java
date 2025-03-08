package domains.dto;

public class UserScoreResponse {
    private String username; // Имя пользователя
    private int totalScore;
    private int rank; // Место в рейтинге

    public UserScoreResponse(String username, int totalScore, int rank) {
        this.username = username;
        this.totalScore = totalScore;
        this.rank = rank;
    }

    // Геттеры и сеттеры
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(int totalScore) {
        this.totalScore = totalScore;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }
}
