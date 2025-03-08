package controllers;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;

import domains.dto.CustomUser;
import services.AuthService;
import utils.config;

@ManagedBean(name = "userSession") 
@SessionScoped
public class UserSessionBean {
    private CustomUser user = new CustomUser(); // Инициализация пользователя
    private boolean loginFormVisible = true;
    private boolean registerFormVisible = false;
    
    public String login() {
        AuthService authService = new AuthService();
        CustomUser  authenticatedUser  = authService.authenticate(user.getUsername(), user.getPassword());

        if (authenticatedUser  != null) {
            this.user = authenticatedUser ; // Сохраняем аутентифицированного пользователя
            System.out.println("Авторизация успешна");
            return config.PROFILE_PAGE_FILE_PATH; // Перенаправление на домашнюю страницу
        }
        FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Неверный логин или пароль."));
        System.out.println("Неверный логин или пароль.");
        return null; // Возвращаем null для отображения ошибки
    }


    public String logout() {
        System.out.println("Logout метод вызван"); 
        if (user != null) {
            new AuthService().logout(user);
            user = new CustomUser(); // Завершение сессии
        }
        System.out.println("Пока пока, я выхожу...");
        return config.AUTH_PAGE_FILE_PATH; // Перенаправление на страницу входа
    }
    
    public String register() {
        AuthService authService = new AuthService();

        // Проверка длины логина и пароля
        if (user.getUsername().length() < 4 || user.getUsername().length() > 30) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Логин должен содержать от 4 до 30 символов."));
            return null; // Возвращаем null для отображения ошибки
        }
        if (user.getPassword().length() < 4 || user.getPassword().length() > 30) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Пароль должен содержать от 4 до 30 символов."));
            return null; // Возвращаем null для отображения ошибки
        }

        // Проверка на совпадение паролей
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Пароли не совпадают."));
            return null; // Возвращаем null для отображения ошибки
        }

        // Проверка на существование пользователя
        CustomUser  authenticatedUser  = authService.register(user.getUsername(), user.getPassword());
        if (authenticatedUser  != null) {
            System.out.println("Регистрация успешна");
            this.user = authenticatedUser ;
            return config.PROFILE_PAGE_FILE_PATH; // Перенаправление на домашнюю страницу
        }

        // Если пользователь с таким именем уже существует
        FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Пользователь с таким именем уже существует."));
        return null; // Возвращаем null для отображения ошибки
    }
    
    public void showLoginForm() {
        this.loginFormVisible = true;
        this.registerFormVisible = false;
    }

    public void showRegisterForm() {
        this.loginFormVisible = false;
        this.registerFormVisible = true;
    }

    public boolean isLoggedIn() {
        return user != null && user.isLoggedIn();
    }

    public CustomUser getUser () {
        return user;
    }

    // Геттеры для username и password
    public String getUsername() {
        return user.getUsername();
    }

    public void setUsername(String username) {
        user.setUsername(username);
    }

    public String getPassword() {
        return user.getPassword();
    }

    public void setPassword(String password) {
        user.setPassword(password);
    }
    
    public String getConfirmPassword() {
		return user.getConfirmPassword();
	}
	public void setConfirmPassword(String confirmPassword) {
		user.setConfirmPassword(confirmPassword);
	}


	public boolean isLoginFormVisible() {
		return loginFormVisible;
	}


	public void setLoginFormVisible(boolean loginFormVisible) {
		this.loginFormVisible = loginFormVisible;
	}


	public boolean isRegisterFormVisible() {
		return registerFormVisible;
	}


	public void setRegisterFormVisible(boolean registerFormVisible) {
		this.registerFormVisible = registerFormVisible;
	}
}

