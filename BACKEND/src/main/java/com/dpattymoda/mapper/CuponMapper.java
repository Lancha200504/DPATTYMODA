package com.dpattymoda.mapper;

import com.dpattymoda.dto.response.CuponResponse;
import com.dpattymoda.entity.Cupon;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.Arrays;
import java.util.List;

/**
 * Mapper para conversión entre Cupon y DTOs
 */
@Mapper(componentModel = "spring")
public interface CuponMapper {

    @Mapping(target = "id", source = "id")
    @Mapping(target = "codigoCupon", source = "codigoCupon")
    @Mapping(target = "nombre", source = "nombre")
    @Mapping(target = "descripcion", source = "descripcion")
    @Mapping(target = "tipoDescuento", source = "tipoDescuento")
    @Mapping(target = "valorDescuento", source = "valorDescuento")
    @Mapping(target = "montoMinimoCompra", source = "montoMinimoCompra")
    @Mapping(target = "montoMaximoDescuento", source = "montoMaximoDescuento")
    @Mapping(target = "fechaInicio", source = "fechaInicio")
    @Mapping(target = "fechaFin", source = "fechaFin")
    @Mapping(target = "usosMaximos", source = "usosMaximos")
    @Mapping(target = "usosPorUsuario", source = "usosPorUsuario")
    @Mapping(target = "usosActuales", source = "usosActuales")
    @Mapping(target = "soloPrimeraCompra", source = "soloPrimeraCompra")
    @Mapping(target = "aplicableEnvio", source = "aplicableEnvio")
    @Mapping(target = "categoriasIncluidas", expression = "java(arrayToList(cupon.getCategoriasIncluidas()))")
    @Mapping(target = "productosIncluidos", expression = "java(arrayToList(cupon.getProductosIncluidos()))")
    @Mapping(target = "usuariosIncluidos", expression = "java(arrayToList(cupon.getUsuariosIncluidos()))")
    @Mapping(target = "activo", source = "activo")
    @Mapping(target = "codigoPromocional", source = "codigoPromocional")
    @Mapping(target = "vigente", expression = "java(cupon.estaVigente())")
    @Mapping(target = "puedeUsarse", expression = "java(cupon.puedeUsarse())")
    @Mapping(target = "agotado", expression = "java(cupon.estaAgotado())")
    @Mapping(target = "usosRestantes", expression = "java(cupon.getUsosRestantes())")
    @Mapping(target = "porcentajeUso", expression = "java(cupon.getPorcentajeUso())")
    @Mapping(target = "fechaCreacion", source = "fechaCreacion")
    @Mapping(target = "fechaActualizacion", source = "fechaActualizacion")
    CuponResponse toResponse(Cupon cupon);

    default <T> List<T> arrayToList(T[] array) {
        return array != null ? Arrays.asList(array) : null;
    }
}