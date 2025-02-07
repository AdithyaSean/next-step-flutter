package com.nextstep.users.mapper;

import com.nextstep.users.dto.InstitutionDTO;
import com.nextstep.users.model.Institution;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface InstitutionMapper {
    InstitutionMapper INSTANCE = Mappers.getMapper(InstitutionMapper.class);

    InstitutionDTO institutionToInstitutionDTO(Institution institution);

    Institution institutionDTOToInstitution(InstitutionDTO institutionDTO);
}
