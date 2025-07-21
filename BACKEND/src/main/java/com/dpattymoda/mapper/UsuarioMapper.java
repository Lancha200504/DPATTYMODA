package com.dpattymoda.mapper;

import com.dpattymoda.dto.response.UsuarioResponse;
import com.dpattymoda.entity.Usuario;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Mapper para conversión entre Usuario y DTOs
 */
@Mapper(componentModel = "spring", uses = {RolMapper.class})
public abstract class UsuarioMapper {

    @Autowired
    private ObjectMapper objectMapper;

    @Mapping(target = "id", source = "id")
    @Mapping(target = "email", source = "email")
    @Mapping(target = "nombres", source = "nombres")
    @Mapping(target = "apellidos", source = "apellidos")
    @Mapping(target = "nombreCompleto", expression = "java(usuario.getNombreCompleto())")
    @Mapping(target = "telefono", source = "telefono")
    @Mapping(target = "dni", source = "dni")
    @Mapping(target = "ruc", source = "ruc")
    @Mapping(target = "direccion", source = "direccion")
    @Mapping(target = "fechaNacimiento", source = "fechaNacimiento")
    @Mapping(target = "genero", source = "genero")
    @Mapping(target = "rol", source = "rol")
    @Mapping(target = "activo", source = "activo")
    @Mapping(target = "emailVerificado", source = "emailVerificado")
    @Mapping(target = "ultimoAcceso", source = "ultimoAcceso")
    @Mapping(target = "fechaCreacion", source = "fechaCreacion")
    @Mapping(target = "fechaActualizacion", source = "fechaActualizacion")
    public abstract UsuarioResponse toResponse(Usuario usuario);

    public String toJson(Usuario usuario) {
        try {
            return objectMapper.writeValueAsString(usuario);
        } catch (JsonProcessingException e) {
            return "{}";
        }
    }
}