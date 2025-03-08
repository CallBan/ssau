package utils;

public class config {
	public static final String URL = "jdbc:postgresql://db:5432/memory";
//	public static final String URL = "jdbc:postgresql://127.0.0.1:5432/memory";
	public static final String USER = "postgres";
	public static final String PASSWORD = "7193355112";
	
	public static final String AUTH_PAGE_FILE_PATH = "/pages/login?faces-redirect=true";
	public static final String PROFILE_PAGE_FILE_PATH = "/protected/profile?faces-redirect=true";
	public static final String GAME_PAGE_FILE_PATH = "/protected/game?faces-redirect=true";
	public static final String ABOUT_DEVELOPER_PAGE_FILE_PATH = "/pages/aboutDeveloper?faces-redirect=true";
	public static final String ABOUT_SYSTEM_PAGE_FILE_PATH = "/pages/aboutSystem?faces-redirect=true";
}
