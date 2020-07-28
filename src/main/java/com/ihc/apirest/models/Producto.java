package com.ihc.apirest.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;



@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Table(schema="dimension")
public class Producto
{
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idProducto;
	private Long idEmpresa;
	private Long idCatalogo;
	private Long idEstado;
	private String categoriaNivel1;
	private String categoriaNivel2;
	private String categoriaNivel3;
	private String categoriaNivel4;
	private String categoriaNivel5;
	private String ean;
	private String nombre;
	private int nivel;
	private Double valor;
	private String urlImagenCategoria;
	private String urlImagenProducto;

	@Transient
	private int cantidad;
	@Transient
	private boolean isSeleccionado;
}