package com.backend.server.repository;

import com.backend.server.model.loginUserModel;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface loginRepository extends CrudRepository<loginUserModel, Integer> {
    Optional<loginUserModel> findByUseridAndPassword(String userid, String password);
}
