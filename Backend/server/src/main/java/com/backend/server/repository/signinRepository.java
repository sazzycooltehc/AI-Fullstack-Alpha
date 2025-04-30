package com.backend.server.repository;

import com.backend.server.model.userRegistrationModel;
import org.springframework.data.repository.CrudRepository;

public interface signinRepository extends CrudRepository<userRegistrationModel, String> {
}
