package com.ihc.apirest.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;



@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
public class Producto
{
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idProducto;
	private Long idEmpresa;
	private Long idCatalogo;
	private String categoriaNivel1;
	private String categoriaNivel2;
	private String categoriaNivel3;
	private String categoriaNivel4;
	private String categoriaNivel5;
	private String ean;
	private String nombre;
	private int nivel;
	private Double precio;
	private int estado;
}