package com.ihc.apirest.controllers;


import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Component
@Slf4j
public class WebSocketHandler extends TextWebSocketHandler 
{
    private Set<WebSocketSession> sesionesClientes = new HashSet<>();
    private Set<WebSocketSession> sesionesTiendas = new HashSet<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) 
    {
        // System.out.println("New WebSocket connection with id:::::: "+ session.getId() + " desde el cliente:: " + session.getRemoteAddress().getHostName() + " Websocket::: " + session.getUri().getPath());

        if("/tienda-websocket".equals(session.getUri().getPath()))
        {
            sesionesTiendas = Stream.concat(sesionesTiendas.stream(), Stream.of(session)).collect(Collectors.toSet());
        }
        else
        {
            sesionesClientes = Stream.concat(sesionesClientes.stream(), Stream.of(session)).collect(Collectors.toSet());
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) 
    {
        if("/tienda-websocket".equals(session.getUri().getPath()))
        {
            sesionesTiendas = sesionesTiendas.stream().filter(s -> !session.equals(s)).collect(Collectors.toSet());
        }
        else
        {
            sesionesClientes = sesionesClientes.stream().filter(s -> !session.equals(s)).collect(Collectors.toSet());
        }
        
    }

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) 
    {
        System.out.println(message);
        
        if("/cliente-websocket".equals(session.getUri().getPath()))
        {
            sesionesTiendas.forEach((ses) -> 
            {
                try 
                {
                    ses.sendMessage(message);
                } 
                catch (Exception ex) 
                {
                    log.error("Couldn't send WebSocket message to session with id::::: ", session.getId());
                }
            });
        }
    }
}