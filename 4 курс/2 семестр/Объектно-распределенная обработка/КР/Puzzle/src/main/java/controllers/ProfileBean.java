package controllers;

import java.util.List;

import javax.annotation.PostConstruct;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import domains.dto.AttemptResponse;
import domains.dto.UserScoreResponse;
import domains.models.AttemptDao;

import javax.faces.bean.ManagedProperty;


@ManagedBean
@ViewScoped
public class ProfileBean {
    private AttemptDao attemptDao = new AttemptDao();
    private List<UserScoreResponse> userScores; // Для рейтинга
    private List<AttemptResponse> userAttempts; // Для личной статистики
    private int currentUserId; // ID текущего пользователя
    private boolean showStatistic1 = true;
    
    
    @ManagedProperty(value="#{userSession}")
    private UserSessionBean userSession;
    
    public UserSessionBean getUserSession() {
        return userSession;
    }

    public void setUserSession(UserSessionBean userSession) {
        this.userSession = userSession;
    }

    @PostConstruct
    public void init() {
        this.currentUserId = userSession.getUser().getId();
        loadUserScores();
        loadUserAttempts();
    }
   

    public void loadUserScores() {
    	showStatistic1 = false;
        userScores = attemptDao.getUserScores();
    }

    public void loadUserAttempts() {
    	showStatistic1 = true;
        userAttempts = attemptDao.getAttemptsByUserId(currentUserId);
    }

    public List<UserScoreResponse> getUserScores() {
        return userScores;
    }

    public List<AttemptResponse> getUserAttempts() {
        return userAttempts;
    }
    
    // Метод для переключения на личную статистику
    public void showUserAttempts() {
        loadUserAttempts();
    }

	public boolean getShowStatistic1() {
		return showStatistic1;
	}

	public void setShowStatistic1(boolean showStatistic1) {
		this.showStatistic1 = showStatistic1;
	}
}
