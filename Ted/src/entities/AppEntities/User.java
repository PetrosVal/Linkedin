package entities.AppEntities;

public class User {

   // private Integer id;
    private String username;
    private String password;
    private String email;
    private String phone;
    private String country;
    private String address;
    private Integer role;


    public User (String username, String password, String email, String phone,
                 String country, String address, Integer role) {


        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.country = country;
        this.address = address;
        this.role = role;
    }


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }


}
