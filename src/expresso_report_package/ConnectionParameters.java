/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package expresso_report_package;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;

/**
 *
 * @author User01
 */
public class ConnectionParameters {

    private static String adapter_file = "//cfg//adapter.txt";
    public static String getFile() throws FileNotFoundException, IOException{
        String current = new java.io.File( "." ).getCanonicalPath();
        System.out.println("Current dir:"+current);
        String currentDir = System.getProperty("user.dir");
        //System.out.println("Current dir using System:" +currentDir);
        //System.out.println("Current adapter path:" +current+"\\cfg\\adapter.txt");
        
        File connStr = new File(current+adapter_file);
        
        String connParams;
        try (Scanner input = new Scanner(connStr)) {
            connParams = input.nextLine();
            System.out.println(connParams);
        }
        return connParams+","+current+adapter_file;

    }
    
    public static void saveFile(String url, String dbname, String dbdriver, String dbuser, String dbpwd) throws FileNotFoundException, IOException{
        String current = new java.io.File( "." ).getCanonicalPath();
        System.out.println("Current dir:"+current);
        String currentDir = System.getProperty("user.dir");
        System.out.println("Current dir using System:" +currentDir);
        System.out.println("Current adapter path:" +current+"\\cfg\\adapter.txt");
        
        File connStr = new File(current+adapter_file);
        
        //Connection conn = ConnectionManager.getConnection("jdbc:postgresql://localhost:5433/", "NRBSL_DB", "org.postgresql.Driver", "postgres", "postgres");
        try (PrintWriter output = new PrintWriter(connStr)) {
            //Connection conn = ConnectionManager.getConnection("jdbc:postgresql://localhost:5433/", "NRBSL_DB", "org.postgresql.Driver", "postgres", "postgres");
            output.println(url + "," + dbname + "," + dbdriver + "," + dbuser + "," + dbpwd );
        }
    }
}
