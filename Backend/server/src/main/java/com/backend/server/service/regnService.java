package com.backend.server.service;

import com.backend.server.model.userRegistrationModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.simple.JdbcClient;

public class regnService {
    @Autowired
    private JdbcClient jdbcClient;

    public boolean checkUserExists(String email) {
        String sql = "SELECT COUNT(*) FROM login WHERE userid = ?";
        Integer count = jdbcClient.sql(sql)
                .param(email)
                .query((rs, rowNum) -> rs.getInt(1))
                .stream()
                .findFirst()
                .orElse(0);
        return count > 0;
    }

    // Register a new user
    public String registerUser(userRegistrationModel userRegn) {
        if (checkUserExists(userRegn.email())) {
            return "User already exists";
        }

        // Insert into the login table
        String insertLoginSQL = "INSERT INTO login (userid, password) VALUES (?, ?)";
        jdbcClient.sql(insertLoginSQL)
                .param(userRegn.email())
                .param(userRegn.password())
                .update();

        // Retrieve the generated token
        String getTokenSQL = "SELECT token FROM login WHERE userid = ?";
        String generatedToken = jdbcClient.sql(getTokenSQL)
                .param(userRegn.email())
                .query((rs, rowNum) -> rs.getString("token")) // Retrieve the token
                .stream()
                .findFirst()
                .orElse(null); // Handle case where token is not found

        // Insert into the users table with the correct column name
        String insertUserSQL = "INSERT INTO users (email, name, password, mobile_number, token) VALUES (?, ?, ?, ?, ?)";
        jdbcClient.sql(insertUserSQL)
                .param(userRegn.email())
                .param(userRegn.password())
                .param(userRegn.name())
                .param(userRegn.mobileNo())// This should correspond to the field in SignupRequest
                .param(generatedToken) // Include the generated token
                .update();

        return "Signup successful";
    }
}
