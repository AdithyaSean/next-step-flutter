package com.nextstep.users.service;

import com.nextstep.users.dto.UserDTO;
import com.nextstep.users.mapper.UserMapper;
import com.nextstep.users.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final UserMapper userMapper = UserMapper.INSTANCE;

    public AuthService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Transactional(readOnly = true)
    public UserDTO login(String username, String password) {
        return userMapper.userToUserDTO(userRepository.findUserByUsernameAndPassword(username, password).orElseThrow(() -> new RuntimeException("Wrong credentials")));
    }
}