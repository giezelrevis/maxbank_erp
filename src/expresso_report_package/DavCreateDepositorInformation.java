/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package expresso_report_package;

import java.awt.Dimension;
import java.awt.HeadlessException;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;
import net.sf.jasperreports.engine.JRException;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.view.JRViewer;
/**
 *
 * @author Aris
 */
public class DavCreateDepositorInformation {
    
    private static String refdate;
    private static String sql1;
    private static String filename;
    
    private static String jasperFileName;
    public static void saveFile(String davrepid) throws FileNotFoundException, IOException, SQLException, JRException{
        //davrepid
        //1 - Depositor Infomation Report
        //2 - Deposit Infromation Report
        
        
        
        Connection conn = ConnectionManager.getConnection();
        System.out.println(conn);
        try {
            Statement st = conn.createStatement();
            String sql;
            sql = "select to_char(run_date, 'yyyy-MM-dd')::text as run_date from branch where id=1";
            ResultSet rs = st.executeQuery(sql);
            while (rs.next())
                {
                    refdate = rs.getString(1);
                }
            rs.close();
            st.close();
            } catch (SQLException ex) {
            Logger.getLogger(DavCreateDepositorInformation.class.getName()).log(Level.SEVERE, null, ex);
        }
        
            
        String current = new java.io.File( "." ).getCanonicalPath();
        
        System.out.println("Current dir:"+current);
        //String currentDir = System.getProperty("user.dir");
        //System.out.println("Current dir using System:" +currentDir);
        System.out.println("Current adapter path:" +current+filename);
        
        System.out.println(davrepid);
        
        if (davrepid.equals("1")){ 
            sql1 = "select concat_ws(',',mergedcifview.customer_id, mergedcifview.depo_name, mergedcifview.depo_mn, mergedcifview.depo_bd) from mergedcifview";
            // jasperFileName = "C:/Users/Aris/Documents/NetBeansProjects/ReportingPackage/jasper/DAV_DepositorInformation.jasper";
            jasperFileName = "jasper/DAV_DepositorInformation.jasper";
            System.out.println("depositor information: " + jasperFileName);
            //filename = "\\output\\"+"DAVDepositorInformation_" + refdate+".csv";
            CreateJasperReportOutPut.showReport(jasperFileName);
        }
        else if (davrepid.equals("2")){
            sql1 = "select dav from davdepositinformationview";
            jasperFileName = "jasper/DAV_DepositInformation.jasper";
            System.out.println("depositor information: " + jasperFileName);
            //filename = "\\output\\"+"DAVDepositInformation_" + refdate+".csv";
            CreateJasperReportOutPut.showReport(jasperFileName);
        }
        else if (davrepid.equals("3")){
            System.out.println("DAV CSV AKO1");
            filename = "\\output\\"+"DAVDepositInformation_" + refdate+".csv";
            File connStr = new File(current+filename);
            try {

                Statement st = conn.createStatement();
                sql1 = "select dav from davdepositinformationview";
                System.out.println("DAV CSV AKO2");
                ResultSet rs1 = st.executeQuery(sql1);
                System.out.println("DAV CSV AKO3");
                try (PrintWriter output = new PrintWriter(connStr)) {
                    while (rs1.next()){   
                    System.out.println("DAV CSV AKO4");
                    output.println(rs1.getString(1));
                        }
                    output.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(DavCreateDepositorInformation.class.getName()).log(Level.SEVERE, null, ex);
            }
        
            
        }
        
    }

}
