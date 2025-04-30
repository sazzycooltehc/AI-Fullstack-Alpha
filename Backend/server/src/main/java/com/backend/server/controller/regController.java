package com.backend.server.controller;

import com.backend.server.model.userRegistrationModel;
import com.backend.server.service.regnService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@CrossOrigin(origins = "http://localhost:4200")
@RequestMapping("/api")
public class regController {
    @Autowired
    private regnService register;

    @PostMapping("/signup")
    public ResponseEntity<Map<String, String>> signup(@RequestBody userRegistrationModel userRegn) {
        Map<String, String> response = new HashMap<>();
        String result = register.registerUser(userRegn);


        response.put("message", result);

        if ("Registration is successful".equals(result)) {
            return ResponseEntity.ok(response);
        } else {
            return ResponseEntity.status(400).body(response);
        }
    }
}
