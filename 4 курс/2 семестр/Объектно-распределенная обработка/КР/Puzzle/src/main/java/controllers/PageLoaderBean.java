package controllers;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import utils.config;



@ManagedBean(name="pageLoader")
@ViewScoped
public class PageLoaderBean {
	public String loadGamePage() {
		return config.GAME_PAGE_FILE_PATH; 
	}
	
	public String loadLoginPage() {
		return config.AUTH_PAGE_FILE_PATH; 
	}
	
	public String loadStatisticPage() {
		return config.PROFILE_PAGE_FILE_PATH;
	}
	
	public String loadAboutDeveloperPage() {
		return config.ABOUT_DEVELOPER_PAGE_FILE_PATH;
	}
	
	public String loadAboutSystemrPage() {
		return config.ABOUT_SYSTEM_PAGE_FILE_PATH;
	}
}
