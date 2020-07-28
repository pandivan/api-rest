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
public class Catalogo
{
	private List<Categoria> lstCategorias;
	private List<Producto> lstProductos;
}