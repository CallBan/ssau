package controllers;

import java.io.Serializable;

public class Card implements Serializable {
    private static final long serialVersionUID = 1L; // Добавьте serialVersionUID

    private int id;
    private boolean isRevealed;
    private boolean isMatched;

    public Card(int id) {
        this.id = id;
        this.isRevealed = false;
        this.isMatched = false;
    }

    public int getId() {
        return id;
    }

    public boolean isRevealed() {
        return isRevealed;
    }

    public void setRevealed(boolean revealed) {
        isRevealed = revealed;
    }

    public boolean isMatched() {
        return isMatched;
    }

    public void setMatched(boolean matched) {
        isMatched = matched;
    }
}
