package domains.dto;

public class UserResponse extends User {
	private int id;
    
    public UserResponse() {
    	
    }
    
	public UserResponse(int id, String username, String password) {
		super(username, password);
		this.id = id;
    }
    
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
}
