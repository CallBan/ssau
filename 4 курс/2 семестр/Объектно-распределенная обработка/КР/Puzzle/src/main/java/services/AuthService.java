package services;

import domains.dto.CustomUser;
import domains.dto.UserRequest;
import domains.dto.UserResponse;
import domains.models.UserDao;

public class AuthService {
    private UserDao userDao = new UserDao();

    public CustomUser authenticate(String username, String password) {
        UserResponse user = userDao.findByUsername(username);
        if(user == null) {
        	return null;
        }
        CustomUser  advanceUser  = new CustomUser(user);
        if (advanceUser.getPassword().equals(password)) {
            advanceUser.setLoggedIn(true);
            return advanceUser ;
        }
        return null;
    }
    
    public CustomUser register(String username, String password) {
        // Проверка, существует ли пользователь с таким же именем
        if (userDao.findByUsername(username) != null) {
            System.out.println("Пользователь с таким именем уже существует");
            return null; // Пользователь уже существует
        }
        UserRequest user  = new UserRequest(username, password);
        userDao.save(user);
        CustomUser advanceUser =  new CustomUser(userDao.findByUsername(user.getUsername()));
        advanceUser.setLoggedIn(true);
        return advanceUser; // Регистрация успешна
    }

    public void logout(CustomUser user) {
        user.setLoggedIn(false);
    }
}
