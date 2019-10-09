/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package expresso_report_package;

import java.awt.Dimension;
import java.awt.HeadlessException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.JFrame;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.view.JRViewer;

/**
 *
 * @author Aris
 */
public class CreateJasperReportOutPut {
    private static HashMap hm;
    
    public static void showReport(String pjasperFileName) throws SQLException, IOException{
        
        hm = null;
        
        Connection conn = ConnectionManager.getConnection();
       
        try {
         System.out.println("Start ....");
         // Get jasper report
         //String jrxmlFileName = "C:/Users/Aris/Documents/NetBeansProjects/ReportingPackage/jasper/DAV_DepositorInformation.jrxml";
         
         //String pdfFileName = "C:/Users/Aris/Documents/NetBeansProjects/ReportingPackage/jasper/DAV_DepositorInformation.pdf";
         
         hm = new HashMap();
         
         // Generate jasper print
         JasperPrint jprint = (JasperPrint) JasperFillManager.fillReport(pjasperFileName, null, conn);

         // Export pdf file
         //JasperExportManager.exportReportToPdfFile(jprint, pdfFileName); System.out.println("Done exporting reports to pdf");
         //Viewer for JasperReport
         JRViewer jv = new JRViewer(jprint);

        //Insert viewer to a JFrame to make it showable
        JFrame jf = new JFrame();
        jf.getContentPane().add(jv);
        jf.validate();
        jf.setVisible(true);
        //jf.setSize(new Dimension(800,600));
        jf.setExtendedState(JFrame.MAXIMIZED_BOTH);
        //jf.setLocation(300,100);
        jf.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        } catch (JRException ex) {
         

        } catch (HeadlessException e) {
         System.out.print("Exceptiion" + e);
        }
    }
}
