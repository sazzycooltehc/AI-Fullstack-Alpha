package com.backend.server.controller;

import com.backend.server.service.loginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:4200")
public class loginContoller {

    @Autowired
    private loginService loginAPI;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestParam String userid, @RequestParam String password) {
        String result = loginAPI.login(userid, password);
        
        if (result.startsWith("Login success")) {
            String token = result.substring(result.indexOf("Token: ") + 7);
            return ResponseEntity.ok(Map.of("message", "Login successful", "token", token)); 
        } else {
            return ResponseEntity.status(401).body(Map.of("message", "Login failed"));
        }
    }
}
