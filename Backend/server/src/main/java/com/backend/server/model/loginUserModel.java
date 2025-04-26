package com.backend.server.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Table("login")
public record loginUserModel(
        @Id @Column("id") int id,
        String userid,
        String password,
        String token
) {}
