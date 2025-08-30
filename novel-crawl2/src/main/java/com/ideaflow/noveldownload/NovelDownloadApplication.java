package com.ideaflow.noveldownload;


import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.Environment;
import org.springframework.util.StringUtils;

import java.net.InetAddress;
import java.net.UnknownHostException;

@SpringBootApplication
@MapperScan(basePackages = {"com.ideaflow.noveldownload.**.mapper"})
public class NovelDownloadApplication {

    public static void main(String[] args) throws UnknownHostException {


        ConfigurableApplicationContext application = SpringApplication.run(NovelDownloadApplication.class, args);
        Environment env = application.getEnvironment();
        String ip = InetAddress.getLocalHost().getHostAddress();
        String port = env.getProperty("server.port");
        port = StringUtils.hasText(port) ? port : "8080";
        String active = env.getProperty("spring.profiles.active");
        String path = env.getProperty("server.servlet.context-path");
        path = StringUtils.hasText(path) ? path : "";

        String websocketPath = env.getProperty("ideaflow.websocket.path");
        String h2 = "/h2-console";

        System.out.println(
            "\n----------------------------------------------------------" +
            "\n  Application is running! Access URLs:" +
            "\n  Local:             http://localhost:" + port + path + "/" +
            "\n  前端页面:           http://" + ip + ":" + port + path + "/" +
            "\n  Websocket Path:    ws://" + ip + ":" + port + websocketPath + "/" +
            "\n  /h2-console:       http://" + ip + ":" + port + h2 + "/" +
            "\n  Project path:      " + System.getProperty("user.dir") +
            "\n  Resource path:     " + NovelDownloadApplication.class.getResource("/").getPath() +
            "\n----------------------------------------------------------"
        );
    }

}
