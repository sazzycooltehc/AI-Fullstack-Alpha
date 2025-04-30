package com.backend.server.model;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("users")
public record userRegistrationModel(
        @Id String email,
        String name,
        String password,
        String mobileNo
) { }
