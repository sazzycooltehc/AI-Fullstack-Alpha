package com.backend.server.service;

import com.backend.server.model.loginUserModel;
import com.backend.server.repository.loginRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class loginService {

    @Autowired
    private loginRepository loginRepo;

    //public static final Logger logger = LoggerFactory.getLogger(loginContoller.class);
    private static final Logger logger = LoggerFactory.getLogger(loginService.class.getName());

    public String login(String userid, String password) {
        logger.info("Attempting login for userid: " + userid);

        Optional<loginUserModel> user = loginRepo.findByUseridAndPassword(userid, password);

        if (user.isPresent()) {
            logger.info("Login successful for userid: " + userid);
            return "Login success! Token: " + user.get().token();
        } else {
            logger.info("Invalid login for userid: " + userid);
            return "Invalid userid or password";
        }
    }

}
