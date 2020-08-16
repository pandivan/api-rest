package com.ihc.apirest.controllers;

import com.ihc.apirest.models.Pedido;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;



// @Controller
public class PedidoWSController 
{

    // @MessageMapping("/ws")
    // @SendTo("/topic/tiendas/pedido")
    // public String enviarPedidoTiendas(String pedido) throws Exception 
    // {
    //     System.out.println("soy el servidor y recibi el pedio " + pedido);
    //     Thread.sleep(1000); // simulated delay

    //     System.out.println("Enviando respuesta al cliente....");
    //     return "Soy la respuesta del servidor al pedio : " + pedido;
    // }
}