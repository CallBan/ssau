package domains.dto;

public class CustomUser extends UserResponse {
	private String confirmPassword;
    private boolean loggedIn;
	
    public CustomUser() {
    	
    }
    
    public CustomUser(UserRequest user) {
    	this.setUsername(user.getUsername());
    	this.setPassword(user.getPassword());
    } 
    
    public CustomUser(UserResponse user) {
    	super(user.getId(), user.getUsername(), user.getPassword());
    }
    
	public boolean isLoggedIn() {
	
		return loggedIn;
	}
	public void setLoggedIn(boolean loggedIn) {
		this.loggedIn = loggedIn;
	}
	public String getConfirmPassword() {
		return confirmPassword;
	}
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
}
