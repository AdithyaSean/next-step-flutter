package com.nextstep.users.controller;

import com.nextstep.users.dto.UserDTO;
import com.nextstep.users.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/users")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public ResponseEntity<List<UserDTO>> getAllUsers() {
        return ResponseEntity.ok(userService.getAllUsers());
    }

    @GetMapping("/")
    public ResponseEntity<UserDTO> getUser(@RequestHeader("UUID") UUID id) {
        return ResponseEntity.ok(userService.getUserById(id));
    }

    @DeleteMapping
    public ResponseEntity<String> deleteUser(@RequestHeader("UUID") UUID id) {
        return ResponseEntity.ok(userService.deleteUser(id));
    }
}
