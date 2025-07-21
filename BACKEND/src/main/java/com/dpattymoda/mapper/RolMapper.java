package com.dpattymoda.mapper;

import com.dpattymoda.dto.response.RolResponse;
import com.dpattymoda.entity.Rol;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

/**
 * Mapper para conversión entre Rol y DTOs
 */
@Mapper(componentModel = "spring")
public interface RolMapper {

    @Mapping(target = "id", source = "id")
    @Mapping(target = "nombreRol", source = "nombreRol")
    @Mapping(target = "descripcion", source = "descripcion")
    @Mapping(target = "activo", source = "activo")
    RolResponse toResponse(Rol rol);
}