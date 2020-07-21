package com.ihc.apirest.models;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;



@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Categoria
{
	// private String idCategoria;
	private String nombre;
	private String urlImagenCategoria;
	private String color;
	private List<Producto> lstProductos;
}