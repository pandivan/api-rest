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



@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Table(schema="dimension")
public class Tienda
{
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idTienda;
	private Long idGeografia;
	private String nit;
	private String nombre;
	private String password;
	private String direccion;
	private String telefono;
	private String email;
}