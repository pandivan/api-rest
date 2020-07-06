package com.ihc.apirest.repository;

import com.ihc.apirest.models.Cliente;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;



@Repository
public interface ClienteRepository extends JpaRepository<Cliente, Long>
{   
    Cliente findByCedula(String cedula);

    Cliente findByTelefonoOrEmail(String telefono, String email);

    @Query("select c from Cliente c where (c.telefono = ?1 or c.email = ?2) and c.password = ?3")
    Cliente validarCliente(String telefono, String email, String password);
}