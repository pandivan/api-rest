package com.ihc.apirest.repository;

import com.ihc.apirest.models.Cliente;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;



@Repository
public interface ClienteRepository extends JpaRepository<Cliente, Long>
{   
    Cliente findByCedula(String cedula);

    Cliente findByTelefonoOrEmail(Cliente cliente);
}