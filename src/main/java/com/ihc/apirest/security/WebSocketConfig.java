// package com.ihc.apirest.security;

// import com.ihc.apirest.controllers.WebSocketHandler;

// import org.springframework.context.annotation.Configuration;
// // import org.springframework.messaging.simp.config.MessageBrokerRegistry;
// // import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
// // import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
// // import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;


// import org.springframework.web.socket.config.annotation.EnableWebSocket;
// import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
// import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

// // @Configuration
// // @EnableWebSocketMessageBroker
// // public class WebSocketConfig implements WebSocketMessageBrokerConfigurer 
// // {

// //   @Override
// //   public void configureMessageBroker(MessageBrokerRegistry config) 
// //   {
// //     //Método que permite escribir mensajes desde el servidor hacia los clientes a traves de la URI "/topic"
// //     config.enableSimpleBroker("/topic");

// //     //Método que permite recibir los mensajes del cliente en el servidor a traves de la URI "/app"
// //     config.setApplicationDestinationPrefixes("/app");
// //   }

// //   @Override
// //   public void registerStompEndpoints(StompEndpointRegistry registry) 
// //   {
// //     //Nombre oficial del web-socket, adicional espera que la conexión desde el cliente se haga por SockeJS
// //     registry.addEndpoint("/tiendas-websocket").withSockJS();
// //   }
// // }


// //TODO: Habilitar este metodo es el bueno
// @Configuration
// @EnableWebSocket
// public class WebSocketConfig implements WebSocketConfigurer 
// {
//     private final WebSocketHandler webSocketHandler;

//     public WebSocketConfig(WebSocketHandler webSocketHandler) 
//     {
//         this.webSocketHandler = webSocketHandler;
//     }

//     public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) 
//     {
//         registry.addHandler(webSocketHandler, "/tienda-websocket").setAllowedOrigins("*");
        
//         registry.addHandler(webSocketHandler, "/cliente-websocket").setAllowedOrigins("*");
//     }
// }