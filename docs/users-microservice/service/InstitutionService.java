package com.nextstep.users.service;

import com.nextstep.users.dto.InstitutionDTO;
import com.nextstep.users.mapper.InstitutionMapper;
import com.nextstep.users.model.Institution;
import com.nextstep.users.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class InstitutionService {

    private final UserRepository userRepository;
    private final InstitutionMapper institutionMapper = InstitutionMapper.INSTANCE;

    public InstitutionService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Transactional
    public InstitutionDTO createInstitution(InstitutionDTO institutionDTO) {
        Institution institution = institutionMapper.institutionDTOToInstitution(institutionDTO);
        institution = userRepository.save(institution);
        return institutionMapper.institutionToInstitutionDTO(institution);
    }
}