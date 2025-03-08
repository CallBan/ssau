package controllers;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class GameEngine implements Serializable {
    private static final long serialVersionUID = 1L; // Добавьте serialVersionUID

    private int gridSize;
    private List<Card> cards;
    private Card firstSelectedCard;
    private Card secondSelectedCard;
    private boolean isCheckingMatch;
    private int pairsFound;

    public GameEngine(int numberOfPairs) {
        this.gridSize = numberOfPairs * 2;
        this.cards = generateCards(numberOfPairs);
        this.pairsFound = 0;
        this.isCheckingMatch = false;
    }
    
    public int getFoundPairs() {
    	return pairsFound;
    }

    private List<Card> generateCards(int numberOfPairs) {
        List<Card> cards = new ArrayList<>();
        for (int i = 0; i < numberOfPairs; i++) {
            Card card1 = new Card(i);
            Card card2 = new Card(i);
            cards.add(card1);
            cards.add(card2);
        }
        Collections.shuffle(cards);
        return cards;
    }

    public void selectCard(Card selectedCard) {
        if (isCheckingMatch || selectedCard.isMatched() || selectedCard.equals(firstSelectedCard)) {
            return;
        }

        selectedCard.setRevealed(true);

        if (firstSelectedCard == null) {
            firstSelectedCard = selectedCard;
        } else {
            secondSelectedCard = selectedCard;
            isCheckingMatch = true;
            checkMatch();
        }
    }

    private void checkMatch() {
        if (firstSelectedCard.getId() == secondSelectedCard.getId()) {
            firstSelectedCard.setMatched(true);
            secondSelectedCard.setMatched(true);
            pairsFound++;
            firstSelectedCard = null;
            secondSelectedCard = null;
            System.out.println("Match found!");
        } else {
            System.out.println("No match, hiding cards...");
            firstSelectedCard.setRevealed(false);
            secondSelectedCard.setRevealed(true);
            firstSelectedCard = secondSelectedCard;
        }
        isCheckingMatch = false;
    }

    public boolean isGameComplete() {
        return pairsFound == gridSize / 2;
    }

    public List<Card> getCards() {
        return cards;
    }
}
