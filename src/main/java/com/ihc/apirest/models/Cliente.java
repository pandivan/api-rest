package com.ihc.apirest.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;



@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
public class Cliente
{
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idCliente;
	private Long idBarrio;
	private Long idTiempoFechaCreacion;
	private String cedula;
	private String nombre;
	private String telefono;
	private String direccion;
	private String email;
	private Date fechaNacimiento;
	private String sexo;
	private String tipoCliente;

	@OneToMany(mappedBy = "dimension.cliente", cascade = CascadeType.ALL)
    private List<Visita> lstVisitas;
}