/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package expresso_report_package;

/**
 *
 * @author JM Marquez
 */

import com.sun.media.sound.InvalidFormatException;
import java.awt.Cursor;
import java.io.*;
import java.util.*;
import java.util.Calendar;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.POIXMLException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFFormulaEvaluator;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class FSConsoReportJInternalFrame extends javax.swing.JInternalFrame {
    private static final SimpleDateFormat SDF = new SimpleDateFormat( "yyyy-MM-dd" );
    /**
     * Creates new form FSConsoReportJInternalFrame
     */
    public FSConsoReportJInternalFrame(String repcode) throws SQLException, IOException {
        initComponents();
        //this is the old code
        Connection conn = ConnectionManager.getConnection();
        Statement st = conn.createStatement();      
        String sql;

        sql = "select name from branch order by id;";
        ResultSet rs = st.executeQuery(sql);
        rs = st.executeQuery(sql);
        while (rs.next())
        {

        }

        rs.close();
    }

    FSConsoReportJInternalFrame() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }


    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jCalReportCutOff = new org.freixas.jcalendar.JCalendarCombo();
        jLabel1 = new javax.swing.JLabel();
        btnCancel = new javax.swing.JButton();
        btnGenerate = new javax.swing.JButton();
        J = new javax.swing.JProgressBar();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();

        setClosable(true);
        setTitle("ERP-FS");
        getContentPane().setLayout(null);

        jCalReportCutOff.setName("fsDateString"); // NOI18N
        jCalReportCutOff.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jCalReportCutOffActionPerformed(evt);
            }
        });
        getContentPane().add(jCalReportCutOff);
        jCalReportCutOff.setBounds(170, 50, 240, 50);

        jLabel1.setFont(new java.awt.Font("DialogInput", 1, 12)); // NOI18N
        jLabel1.setText("Report Cut-Off Date:");
        getContentPane().add(jLabel1);
        jLabel1.setBounds(10, 50, 140, 50);

        btnCancel.setText("Cancel");
        btnCancel.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnCancelActionPerformed(evt);
            }
        });
        getContentPane().add(btnCancel);
        btnCancel.setBounds(170, 150, 90, 40);

        btnGenerate.setText("Generate");
        btnGenerate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnGenerateActionPerformed(evt);
            }
        });
        getContentPane().add(btnGenerate);
        btnGenerate.setBounds(260, 150, 150, 40);

        J.setMaximum(23);
        J.setStringPainted(true);
        getContentPane().add(J);
        J.setBounds(170, 110, 240, 20);

        jLabel2.setFont(new java.awt.Font("DialogInput", 1, 18)); // NOI18N
        jLabel2.setText("CONSOLIDATED FINANCIAL STATEMENT");
        getContentPane().add(jLabel2);
        jLabel2.setBounds(30, 0, 380, 40);

        jLabel3.setFont(new java.awt.Font("DialogInput", 1, 12)); // NOI18N
        jLabel3.setText("Progress");
        getContentPane().add(jLabel3);
        jLabel3.setBounds(10, 100, 70, 30);

        setBounds(0, 0, 431, 274);
    }// </editor-fold>//GEN-END:initComponents

    private void jCalReportCutOffActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jCalReportCutOffActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jCalReportCutOffActionPerformed

    private void btnCancelActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCancelActionPerformed
        //reportparameterframe.setDefaultCloseOperation(JInternalFrame.DISPOSE_ON_CLOSE);
        this.dispose();
    }//GEN-LAST:event_btnCancelActionPerformed
    int selectedIndex,count=0;
    String selectedBranch;
    private void btnGenerateActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnGenerateActionPerformed
        System.out.println("======================= GENERATE CONSOLIDATED FINANCIAL STATEMENT ==========================");

        System.out.println("START");
        Thread thread;
        thread = new Thread(new Runnable(){
            @Override
            public void run(){
                String dateString = SDF.format( jCalReportCutOff.getDate() );
                String prevDayDate = null;
                Calendar cal = Calendar.getInstance();
                //============== GET PREV DAY ===========
                cal.setTime(jCalReportCutOff.getDate()); 
                cal.add(Calendar.DAY_OF_MONTH, -1);
                prevDayDate = SDF.format(cal.getTime());
                System.out.println("dateString: "+dateString);
                System.out.println("prevDayDate: "+prevDayDate);
            //=========================================
                String rep_code = "FRPWORKFILEFS";
                String branchId="";
                btnGenerate.setEnabled(false);
                String xstarter = "START";
                setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
                
                String xmenuAction = "CONSOLIDATED";
                try {

                    //if (chkConsolidateFlag.isSelected() == true){
                        if(xstarter.equalsIgnoreCase("START")){
                            // ============= MAY IF DATI ======================
                            //start

                            String sqlstr = "";
                            Connection conn = ConnectionManager.getConnection();
                            Statement st = conn.createStatement();
                            String excelTemplate = CreateReport.getReportTemplate("FRPWORKFILEFS");
                            System.out.println("booomm...");
                            Integer xrow = 1;
                            Integer xcol = 1;
                            String current = new java.io.File( "." ).getCanonicalPath();
                            XSSFWorkbook report_excel_template; // for xlsx/xlsm
                            // convert it into a POI object
                            //Read Excel document first

                            FileInputStream input_document = new FileInputStream(new File(current+excelTemplate));
                            // convert it into a POI object
                            report_excel_template = new XSSFWorkbook(input_document);
                            //

                            String sqlstr2 = "";
                            Statement st2 = conn.createStatement();

                            ResultSet rs2 = null;
                            if (xmenuAction.equalsIgnoreCase("CONSOLIDATED")){
                                System.out.println("consdition passs");
                                //-- Full trial balance SQL
                                //dateString/prevDayDate
                                sqlstr2 = CreateReport.getReportQueryFSConso(dateString,prevDayDate);
                                
                                System.out.println("query: "+sqlstr2);
                                rs2 = st2.executeQuery(sqlstr2);
                            }
                            if(!rs2.isBeforeFirst()){
                                System.out.println("NO VALUE");
                                XSSFSheet report_worksheet;
                                report_worksheet = report_excel_template.getSheet("ICBS-TB-GL-Worksheet");
                                System.out.println("row value" + report_worksheet.getLastRowNum());

                                for (int x =1; x <=  report_worksheet.getLastRowNum(); x++){
                                    Row row = report_worksheet.getRow(x);
                                    for(int y=1;y<6;y++){
                                        System.out.println("row : " + x + "col :" + y);
                                        System.out.println("CELL CLEANING TB GL");
                                        Cell cell = row.getCell(y);
                                        if (cell == null){
                                            cell = row.createCell(y);
                                        }
                                        cell.setCellValue(" ");

                                    }
                                }
                            }else{
                                System.out.println("WITH DATA VALUE");
                                while (rs2.next()){
                                    System.out.println("ROW GL" + xrow);
                                    System.out.println("Column 1 " + rs2.getString(1));
                                    System.out.println("Column 2 " + rs2.getString(2));
                                    System.out.println("Column 3 " + rs2.getString(3));
                                    System.out.println("Column 4 " + rs2.getString(4));
                                    System.out.println("Column 5 " + rs2.getString(5));
                                    XSSFSheet report_worksheet;
                                    report_worksheet = report_excel_template.getSheet("ICBS-TB-GL-Worksheet");
                                    // System.out.println("row value" + report_worksheet.getLastRowNum());

                                    Row row = report_worksheet.getRow(xrow);

                                    //create new row if row is null
                                    if (row == null) {
                                        // No entries in this row
                                        // Handle empty
                                        // continue;
                                        row = report_worksheet.createRow(xrow);
                                    }

                                    for(int y=1;y<6;y++){
                                        System.out.println("row : " + xrow + "col :" + y);
                                        System.out.println("CELL CLEANING");
                                        System.out.println("rs2.getString(y): "+rs2.getString(y));
                                        String getValue;

                                        Cell cell = row.getCell(y);
                                        if (cell == null){
                                            cell = row.createCell(y);
                                        }
                                        if(y < 4){
                                            if(isNullOrBlank(rs2.getString(y))){
                                                cell.setCellValue(" ");
                                            }else{
                                                cell.setCellValue(rs2.getString(y));
                                            }

                                        }else{
                                            if(isNullOrBlank(rs2.getString(y))){
                                                cell.setCellValue(0.00D);
                                            }else{
                                                cell.setCellValue(Double.parseDouble(rs2.getString(y)));
                                            }
                                            System.out.println("LAST VALUE" + y);
                                        }
                                    } //for loop end

                                    xrow += 1;

                                } // while loop end
                            } // else end
                            System.out.println("====== DONE WRITTING TO FS EXCEL WORKFILE ============");
                            count++;
                            J.setValue(count);
                            Thread.sleep(500);
                            //Overwrite excell
                            //XSSFFormulaEvaluator.evaluateAllFormulaCells(report_excel_template);
                           
                            System.out.println("Evaluating foumulas");
                            //FormulaEvaluator xevaluator = report_excel_template.getCreationHelper().createFormulaEvaluator();
                            //xevaluator.setIgnoreMissingWorkbooks(true);
                            //System.out.println("FORMULA" + xevaluator);
                            /*for (Sheet sheet : report_excel_template){
                                System.out.println("Sheet" + sheet);
                                for(Row r : sheet){
                                    for(Cell c: r ){

                                        if(c.getCellType() == Cell.CELL_TYPE_FORMULA){
                                            xevaluator.evaluateFormulaCell(c);

                                        }
                                    }
                                }
                            }*/

                            System.out.println ("current+excelTemplate " + current+excelTemplate);
                            FileOutputStream output_file =new FileOutputStream(new File(current+excelTemplate));
                            count++;
                            J.setValue(count);

                            //write changes
                            report_excel_template.write(output_file);
                            //close the stream
                            output_file.close();
                            //START
                            //end
                            J.setMaximum(2);
                            
                            FileOutputStream bsp_fs_output_file =new FileOutputStream(new File(current+"\\output\\FS-Conso_"+dateString+".xls"));
                            System.out.println("LOC : " + current+"\\output\\FS-Conso"+dateString+".xls");
                           // System.out.println("REPORT WORKL BOOK" + bsp_depliab_output_file);
                            //write changes
                            report_excel_template.write(bsp_fs_output_file);
                            //close the stream
                            bsp_fs_output_file.close();
                            System.out.println("check fs conso");
                        }
                        count++;
                        J.setValue(count);
                        btnGenerate.setEnabled(true);
                        setCursor(null);
                        JOptionPane.showMessageDialog(rootPane, "Report Complete!");
                        jCalReportCutOff.setDate(new Date());
                        jCalReportCutOff.setNullAllowed(true);
                        J.setValue(0);
                        //            //END FS
                    } catch (SQLException ex) {
                        Logger.getLogger(FSReportJInternalFrame.class.getName()).log(Level.SEVERE, null, ex);
                    } catch (IOException ex) {
                        Logger.getLogger(FSReportJInternalFrame.class.getName()).log(Level.SEVERE, null, ex);
                    } catch (InterruptedException e)
                    {

                    }
                }
            });
            thread.start();
    }//GEN-LAST:event_btnGenerateActionPerformed
    private static boolean isNullOrBlank(String s){
        return (s==null || s.trim().equals(""));
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private static javax.swing.JProgressBar J;
    private javax.swing.JButton btnCancel;
    private javax.swing.JButton btnGenerate;
    private org.freixas.jcalendar.JCalendarCombo jCalReportCutOff;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    // End of variables declaration//GEN-END:variables
}