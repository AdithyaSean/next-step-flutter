package com.nextstep.users.dto;

import com.nextstep.users.model.UserRole;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDateTime;
import java.util.UUID;

public class UserDTO {
    private UUID id;

    @NotBlank(message = "Username is mandatory")
    private String username;

    @NotBlank(message = "Name is mandatory")
    private String name;

    @Email(message = "Email should be valid")
    @NotBlank(message = "Email is mandatory")
    private String email;

    @NotBlank(message = "Password is mandatory")
    private String password;

    @NotBlank(message = "Telephone is mandatory")
    private String telephone;

    @NotNull(message = "Role is mandatory")
    private UserRole role;

    private boolean active;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public UserDTO() {
    }

    public UUID getId() {
        return this.id;
    }

    public @NotBlank(message = "Username is mandatory") String getUsername() {
        return this.username;
    }

    public @NotBlank(message = "Name is mandatory") String getName() {
        return this.name;
    }

    public @Email(message = "Email should be valid") @NotBlank(message = "Email is mandatory") String getEmail() {
        return this.email;
    }

    public @NotBlank(message = "Password is mandatory") String getPassword() {
        return this.password;
    }

    public @NotBlank(message = "Telephone is mandatory") String getTelephone() {
        return this.telephone;
    }

    public @NotNull(message = "Role is mandatory") UserRole getRole() {
        return this.role;
    }

    public boolean isActive() {
        return this.active;
    }

    public LocalDateTime getCreatedAt() {
        return this.createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return this.updatedAt;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public void setUsername(@NotBlank(message = "Username is mandatory") String username) {
        this.username = username;
    }

    public void setName(@NotBlank(message = "Name is mandatory") String name) {
        this.name = name;
    }

    public void setEmail(@Email(message = "Email should be valid") @NotBlank(message = "Email is mandatory") String email) {
        this.email = email;
    }

    public void setPassword(@NotBlank(message = "Password is mandatory") String password) {
        this.password = password;
    }

    public void setTelephone(@NotBlank(message = "Telephone is mandatory") String telephone) {
        this.telephone = telephone;
    }

    public void setRole(@NotNull(message = "Role is mandatory") UserRole role) {
        this.role = role;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}