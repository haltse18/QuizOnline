/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package halt.listener;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Web application lifecycle listener.
 *
 * @author Luong Thanh Ha
 */
public class MyContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        String realPath = context.getRealPath("/");
        String filename = "WEB-INF\\SiteMap.txt";
        
        try {
            Map<String, String> SiteMap = readSiteMap(realPath + filename);
            if (SiteMap != null) {
                context.setAttribute("SITE_MAP", SiteMap);
            }else{
                System.out.println("Map is null");
            }
        } catch (IOException ex) {
            Logger.getLogger(MyContextListener.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    public Map<String, String> readSiteMap(String filename) throws FileNotFoundException, IOException {
        Map<String, String> map = new HashMap<>();
        FileReader fr = null;
        BufferedReader br = null;
        try{
            fr = new FileReader(filename);
            br = new BufferedReader(fr);
            while (br.ready()){
                String s = br.readLine();
                String[] arr = s.split("=");
                map.put(arr[0], arr[1]);
            }
            return map;
        }finally{
            if (br != null) {
                br.close();
            }
            if (fr != null) {
                fr.close();
            }
        }
        
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        
    }
}
