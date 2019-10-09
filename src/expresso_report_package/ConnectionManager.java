/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package expresso_report_package;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author User01
 */
public class ConnectionManager {
        
    public static Connection getConnection() throws SQLException, FileNotFoundException, IOException {
        
        //File connStr = new File("E:\\output\\connection.txt");
        
        //Scanner input = new Scanner(connStr);
        //String connParams = input.nextLine();
        
        //System.out.println(connParams);
        
        String[] params = ConnectionParameters.getFile().split(",");      
        
        String url = params[0] ; 
        String dbname = params[1];
        String driverName = params[2]; 
        String username  = params[3]; 
        String pasword  = params[4];
        
        //input.close();
        Connection con = null;
        try{
            Class.forName(driverName);
            con=DriverManager.getConnection(url+dbname, username ,pasword);
            
            if (con!=null)
                System.out.println("Connection Successfull");
            
        }
        catch(ClassNotFoundException | SQLException ee)
        {
            //ee.printStackTrace();
            //JOptionPane.showMessageDialog(this, ee.getMessage());
            System.out.println("Driver not found.");
        }
        
        return con;
    }
    
}
