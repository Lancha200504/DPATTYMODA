package com.dpattymoda.mapper;

import com.dpattymoda.dto.response.ProductoBasicoResponse;
import com.dpattymoda.entity.Producto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

/**
 * Mapper para conversión entre Producto y DTOs básicos
 */
@Mapper(componentModel = "spring")
public interface ProductoMapper {

    @Mapping(target = "id", source = "id")
    @Mapping(target = "codigoProducto", source = "codigoProducto")
    @Mapping(target = "nombreProducto", source = "nombreProducto")
    @Mapping(target = "descripcionCorta", source = "descripcionCorta")
    @Mapping(target = "marca", source = "marca")
    @Mapping(target = "precioBase", source = "precioBase")
    @Mapping(target = "precioOferta", source = "precioOferta")
    @Mapping(target = "precioVenta", expression = "java(producto.getPrecioVenta())")
    @Mapping(target = "calificacionPromedio", source = "calificacionPromedio")
    @Mapping(target = "totalReseñas", source = "totalReseñas")
    @Mapping(target = "nombreCategoria", expression = "java(producto.getCategoria() != null ? producto.getCategoria().getNombreCategoria() : null)")
    @Mapping(target = "imagenes", expression = "java(getImagenesArray(producto))")
    ProductoBasicoResponse toBasicoResponse(Producto producto);

    default String[] getImagenesArray(Producto producto) {
        if (producto.getImagenes() == null || producto.getImagenes().isEmpty()) {
            return new String[0];
        }
        try {
            com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
            return mapper.readValue(producto.getImagenes(), String[].class);
        } catch (Exception e) {
            return new String[0];
        }
    }
}