/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package expresso_report_package;

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
/**
 *
 * @author Cyrus Magsino
 */
public class PBSJInternalFrame extends javax.swing.JInternalFrame {

    /**
     * Creates new form PBSJInternalFrame
     */
    public PBSJInternalFrame(String repcode) throws SQLException, IOException {
        initComponents();
        
        
        //this is the old code
    
    }   
    
    public PBSJInternalFrame() {
        initComponents();
    }

    private static boolean isNullOrBlank(String s){
        return (s==null || s.trim().equals(""));
    }
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        jCalReportCutOff = new org.freixas.jcalendar.JCalendarCombo();
        btnCancel = new javax.swing.JButton();
        btnGenerate = new javax.swing.JButton();
        J1 = new javax.swing.JProgressBar();
        jLabel2 = new javax.swing.JLabel();
        jCalReportCutOff1 = new org.freixas.jcalendar.JCalendarCombo();

        setTitle("PBS Report");

        jLabel1.setText("Current Date:");

        jCalReportCutOff.setName("fsDateString"); // NOI18N
        jCalReportCutOff.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jCalReportCutOffActionPerformed(evt);
            }
        });

        btnCancel.setText("Cancel");
        btnCancel.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnCancelActionPerformed(evt);
            }
        });

        btnGenerate.setText("Generate");
        btnGenerate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnGenerateActionPerformed(evt);
            }
        });

        J1.setMaximum(23);
        J1.setStringPainted(true);

        jLabel2.setText("Previous Date:");

        jCalReportCutOff1.setName("fsDateString"); // NOI18N
        jCalReportCutOff1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jCalReportCutOff1ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(J1, javax.swing.GroupLayout.DEFAULT_SIZE, 374, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(btnCancel)
                                .addGap(18, 18, 18)
                                .addComponent(btnGenerate))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel1)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(jCalReportCutOff, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel2)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(jCalReportCutOff1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(jCalReportCutOff, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(jCalReportCutOff1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(13, 13, 13)
                .addComponent(J1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(btnGenerate)
                    .addComponent(btnCancel))
                .addContainerGap(14, Short.MAX_VALUE))
        );

        jLabel1.getAccessibleContext().setAccessibleName("Current Date:");
        jLabel1.getAccessibleContext().setAccessibleDescription("");

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jCalReportCutOffActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jCalReportCutOffActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jCalReportCutOffActionPerformed

    private void btnCancelActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCancelActionPerformed
        //reportparameterframe.setDefaultCloseOperation(JInternalFrame.DISPOSE_ON_CLOSE);
        this.dispose();
    }//GEN-LAST:event_btnCancelActionPerformed
    int count=0;
    String selectedBranch;
    private static final SimpleDateFormat SDF = new SimpleDateFormat( "yyyy-MM-dd" );
    private void btnGenerateActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnGenerateActionPerformed
       
//
        
        Thread thread = new Thread(new Runnable(){
            @Override
            public void run()
            {
                try {
               
                    String sqlstr = "";
                    Connection conn = ConnectionManager.getConnection();    
                    Statement st = conn.createStatement();
                    String excel_input = CreateReport.getReportTemplate("FRPWORKFILE04");
                    String current = new java.io.File( "." ).getCanonicalPath();
                    XSSFWorkbook report_excel_template;
                    FileInputStream input_document = new FileInputStream(new File(current+excel_input));
                    System.out.println("PATH " + current+excel_input);
                    // convert it into a POI object
                    report_excel_template = new XSSFWorkbook(input_document);
                    
                    Integer xrow = 1;
                    Integer xcol = 1;
                    String currentDate = SDF.format( jCalReportCutOff.getDate() );
                    String previousDate = SDF.format( jCalReportCutOff1.getDate() );
                
                sqlstr = " with X as (  ";
                sqlstr +=" select  ";
                sqlstr +=" A.sort_code as sort_code, round(sum(B.debit_balance - B.credit_balance),2) as bal_amt  ";
                sqlstr +=" from gl_sort_code A  ";
                sqlstr +=" left outer join gl_daily_file B on A.sort_code = substring(B.code from 1 for char_length(A.sort_code))  ";
                sqlstr +=" and B.ref_date = '"+previousDate+"' and B.currency_id = 1  ";
                sqlstr +=" group by A.sort_code,A.sort_name  ";
                sqlstr +=" order by A.sort_code,A.sort_name ),  "; 
                sqlstr +=" Y as (  ";
                sqlstr +=" select  ";
                sqlstr +=" A.sort_code as sort_code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end ";
                sqlstr +=" as bal_amt  ";
                sqlstr +=" from gl_sort_code A  ";
                sqlstr +=" left outer join gl_txn_file B on A.sort_code = substring(B.gl_account_code from 1 for char_length(A.sort_code))  ";
                sqlstr +=" inner join gl_account C on B.gl_account_id = C.id   ";
                sqlstr +=" and B.txn_value_date <= '"+previousDate+"' and b.txn_date > '"+previousDate+"' and C.currency_id = 1   ";
                sqlstr +=" group by A.sort_code,A.sort_name  ";
                sqlstr +=" order by A.sort_code,A.sort_name  ";
                sqlstr +=" )  ";
                sqlstr +=" select  ";
                sqlstr +=" 'A-' || A.sort_code as gl, A.sort_name,  ";
                sqlstr +=" case when X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end >= 0  ";
                sqlstr +=" then X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end else (X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt ";
                sqlstr +=" end) * -1 end prev_adj_bal,  ";
                sqlstr +=" ( ";
                sqlstr +=" with X as (  ";
                sqlstr +=" select  ";
                sqlstr +=" A.sort_code as sort_code, round(sum(B.debit_balance - B.credit_balance),2) as bal_amt  ";
                sqlstr +=" from gl_sort_code A  ";
                sqlstr +=" left outer join gl_daily_file B on A.sort_code = substring(B.code from 1 for char_length(A.sort_code))  ";
                sqlstr +=" and B.ref_date = '2018-03-31' and B.currency_id = 1  ";
                sqlstr +=" group by A.sort_code,A.sort_name   ";
                sqlstr +=" order by A.sort_code,A.sort_name ),  "; 
                sqlstr +=" Y as (   ";
                sqlstr +=" select   ";
                sqlstr +=" A.sort_code as sort_code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end ";
                sqlstr += " as bal_amt  ";
                sqlstr +=" from gl_sort_code A   ";
                sqlstr +=" left outer join gl_txn_file B on A.sort_code = substring(B.gl_account_code from 1 for char_length(A.sort_code))   ";
                sqlstr +=" inner join gl_account C on B.gl_account_id = C.id   ";
                sqlstr +=" and B.txn_value_date <= '"+currentDate+"' and b.txn_date > '"+currentDate+"' and C.currency_id = 1  ";
                sqlstr +=" group by A.sort_code,A.sort_name  ";
                sqlstr +=" order by A.sort_code,A.sort_name  ";
                sqlstr +=" )  ";
                sqlstr +=" select  "; 
                sqlstr +=" case when X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end >= 0  ";
                sqlstr +=" then X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end else (X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt ";
                sqlstr +=" end) * -1 end as adj_bal  ";
                sqlstr +=" from gl_sort_code B   ";
                sqlstr +=" inner join X on B.sort_code = X.sort_code   ";
                sqlstr +=" left outer join Y on B.sort_code = Y.sort_code   ";
		sqlstr +=" where B.sort_code = A.sort_code  ";
                sqlstr +=" ) as current_adj_bal   ";
                sqlstr +=" from gl_sort_code A   ";
                sqlstr +=" inner join X on A.sort_code = X.sort_code  ";
                sqlstr +=" left outer join Y on A.sort_code = Y.sort_code  ";
                sqlstr +=" order by gl   ";
                J1.setValue(1);
                System.out.println("Query " + sqlstr);
                ResultSet rs = st.executeQuery(sqlstr);
                if(!rs.isBeforeFirst()){
                   System.out.println("NO VALUE");
                   XSSFSheet report_worksheet;
                   report_worksheet = report_excel_template.getSheet("ICBS-TB-SC");
                   System.out.println("row value" + report_worksheet.getLastRowNum());


                    for (int x =1; x <=  report_worksheet.getLastRowNum(); x++){
                                 Row row = report_worksheet.getRow(x);   
                                   for(int y=1;y<4;y++){
                                   System.out.println("row : " + x + "col :" + y);
                                   System.out.println("CELL CLEANING");
                                      Cell cell = row.getCell(y);
                                       if (cell == null){
                                           cell = row.createCell(y);
                                       }
                                       cell.setCellValue(" ");

                                   }

                               }
                    
                }else{
                      XSSFSheet report_worksheet;
                      report_worksheet = report_excel_template.getSheet("ICBS-TB-SC"); 
                     while (rs.next()){
                     J1.setValue(10);
                     
                        System.out.println("############");
                        System.out.println( "SORT CODE" + rs.getString(1));
                        System.out.println( "Sort NAME" + rs.getString(2));
                        System.out.println( "Prev Balance" + rs.getString(3));
                        System.out.println( "Current Balance" + rs.getString(4));
                    
                       Row row = report_worksheet.getRow(xrow);  
                       if (row == null) {
                                     row = report_worksheet.createRow(xrow); 
                                  } 
                                  for(int y=1;y<5;y++){
                                    System.out.println("row : " + xrow + "col :" + y);
                                    System.out.println("CELL CLEANING" + row.getCell(y));
                                    
                                       Cell cell = row.getCell(y);
                                        if (cell == null){
                                            cell = row.createCell(y);
                                        }
                                       
                                            if(y < 3){
                                                cell.setCellValue(String.valueOf(rs.getString(y)));
                                                }else{
                                   //null 

                                                    System.out.println("i > 3 :" + rs.getString(y));
                                                    if(rs.getString(y) == null || Double.parseDouble(rs.getString(y)) == 0){
                                                        
                                                        cell.setCellValue(0.00D);
                                                    }else{
                                                        System.out.println("rs.is not null");

                                                        cell.setCellValue(Double.parseDouble(rs.getString(y)));
                                                    }
                            
                                             }
                                                        
                                    
                           }  
                                    
                        xrow++;
                     }
                     
                        //write changes
                   System.out.println ("current+excelTemplate " + current+excel_input);
                    FileOutputStream output_file = new FileOutputStream(new File(current+excel_input));
                    report_excel_template.write(output_file);
                    output_file.close();
                    //excell to excell
                    //########################################################################
                    XSSFWorkbook report_excel_template_PBS;
                    String excelPBS = CreateReport.getReportTemplate("PBS");
                    FileInputStream input_document_PBS = new FileInputStream(new File(current+excelPBS));
                  
                    // convert it into a POI object
                    report_excel_template_PBS = new XSSFWorkbook(input_document_PBS);
                    XSSFSheet bsp_pbs_report_worksheet;
                    
                    
                    report_worksheet = report_excel_template.getSheet("WP-PBS-TABLE");    
                    DataFormatter formatter = new DataFormatter();
                    DecimalFormat df = new DecimalFormat("#,##0.00;(-#,##0.00)");
                    FormulaEvaluator evaluator = report_excel_template.getCreationHelper().createFormulaEvaluator();
                    
                    J1.setValue(70);
                    for(int x = 1;x<=report_worksheet.getLastRowNum();x++){
                    
                        Row row = report_worksheet.getRow(x);
                        if (row == null) {
                                     x = report_worksheet.getLastRowNum();
                                     break;
                                     
                                     //row = report_worksheet.createRow(xrow); 
                            } 
                        //NOTE:
                        if(row.getCell(2) == null){
                        System.out.println("ROW " + row.getCell(2));
                        break;
                        }
                        
                        //getCell(3) = row ; getCell(4) = column ; getCell(5) = value;
//                         System.out.println("FRP CONTROL " + report_worksheet.getLastRowNum());
//                         System.out.println("Sheet Name : " + row.getCell(2).toString());
//                         System.out.println("Row : " + formatter.formatCellValue(row.getCell(3), evaluator));
//                         System.out.println("Column : " + formatter.formatCellValue(row.getCell(4), evaluator));
//                        // System.out.println("Value : " + formatter.formatCellValue(row.getCell(5),evaluator));
                      
                         
                         Cell valueCell = row.getCell(5);
                         if (valueCell == null){
                                            valueCell = row.createCell(5);
                                        } 
                         
                         bsp_pbs_report_worksheet = report_excel_template_PBS.getSheet(row.getCell(2).toString());
                         String bsp_cp_row =  formatter.formatCellValue(row.getCell(3), evaluator);
                         String bsp_cp_col =  formatter.formatCellValue(row.getCell(4), evaluator);
                         System.out.println("value cell" + row.createCell(5));
                         String bsp_val_col =  formatter.formatCellValue(valueCell,evaluator);
                      
                         System.out.println("ROW" + bsp_cp_row);
                         System.out.println("COL" + bsp_cp_col);
                         System.out.println("VALUE" + bsp_val_col);
                        
                      
                         //insert value on bsp control_proflist
                         if(bsp_cp_row != ""){
                              Row bspcp_row = bsp_pbs_report_worksheet.getRow(Integer.parseInt(bsp_cp_row));
                          if (bspcp_row == null) {
                                     
                                     continue;
                                     //row = report_worksheet.createRow(xrow); 
                                  } 
                          Cell bsp_cell = bspcp_row.getCell(Integer.parseInt(bsp_cp_col));
                         
                          if (bsp_cell == null){
                                bsp_cell = bspcp_row.createCell(Integer.parseInt(bsp_cp_col));
                             }
                          
                          if(bsp_val_col.isEmpty()){
                           bsp_cell.setCellValue(0.00D);
                          }else{
                          bsp_cell.setCellValue(formatter.formatCellValue(valueCell,evaluator));
                          }
                          
                        
                         }else{ x = report_worksheet.getLastRowNum();}
           
                    }
                    J1.setValue(80);
                    FormulaEvaluator xxevaluator = report_excel_template_PBS.getCreationHelper().createFormulaEvaluator();
                    xxevaluator.setIgnoreMissingWorkbooks(true);
                    System.out.println("FORMULA" + xxevaluator);
                    for (Sheet sheet : report_excel_template_PBS){
                        System.out.println("Sheet" + sheet);
                        for(Row r : sheet){
                            for(Cell c: r ){

                                if(c.getCellType() == Cell.CELL_TYPE_FORMULA){
                                    xxevaluator.evaluateFormulaCell(c);
                                }
                            }
                          }
                        }
                    
                   // input_document_PBS.close();
                    FileOutputStream bsp_pbs_output_file =new FileOutputStream(new File(current+"\\output\\PBS-"+currentDate+".xlsm"));
                     //write changes
                    report_excel_template_PBS.write(bsp_pbs_output_file);
                    //close the stream
                    bsp_pbs_output_file.close(); 
                    
                    //
                    //consolidated control proflist
                    //##############################################
                    XSSFWorkbook report_excel_template_PBSCP;
                    String excelPBSCP = CreateReport.getReportTemplate("PBSCP");
                    FileInputStream input_document_PBSCP = new FileInputStream(new File(current+excelPBSCP));
                   
                    // convert it into a POI object
                    report_excel_template_PBSCP = new XSSFWorkbook(input_document_PBSCP);
                    XSSFSheet bsp_pbscp_report_worksheet;
                    
                    
                    report_worksheet = report_excel_template.getSheet("WP-PBS-CP-TABLE");    
                   
                    J1.setValue(90);
                    for(int x = 1;x<=report_worksheet.getLastRowNum();x++){
                    
                        Row row = report_worksheet.getRow(x);
                        if (row == null) {
                                     x = report_worksheet.getLastRowNum();
                                     break;
                                     
                                     //row = report_worksheet.createRow(xrow); 
                            } 
                        //NOTE:
                        if(row.getCell(2) == null){
                        System.out.println("ROW " + row.getCell(2));
                        break;
                        }
                        
                        //getCell(3) = row ; getCell(4) = column ; getCell(5) = value;
                         System.out.println("FRP CONTROL " + report_worksheet.getLastRowNum());
                         System.out.println("Sheet Name : " + row.getCell(2).toString());
                         System.out.println("Row : " + formatter.formatCellValue(row.getCell(3), evaluator));
                         System.out.println("Column : " + formatter.formatCellValue(row.getCell(4), evaluator));
                         System.out.println("Value : " + formatter.formatCellValue(row.getCell(5),evaluator));
                      
                         
                         Cell valueCell = row.getCell(5);
                         if (valueCell == null){
                                            valueCell = row.createCell(5);
                                        } 
               
                         bsp_pbscp_report_worksheet = report_excel_template_PBSCP.getSheet(row.getCell(2).toString());
                         String bsp_cp_row =  formatter.formatCellValue(row.getCell(3), evaluator);
                         String bsp_cp_col =  formatter.formatCellValue(row.getCell(4), evaluator);
                         String bsp_val_col =  formatter.formatCellValue(valueCell,evaluator);
                      
                         System.out.println("ROW" + bsp_cp_row);
                         System.out.println("COL" + bsp_cp_col);
                         System.out.println("VALUE" + bsp_val_col);
                        
                      
                         //insert value on bsp control_proflist
                         if(bsp_cp_row != ""){
                              Row bspcp_row = bsp_pbscp_report_worksheet.getRow(Integer.parseInt(bsp_cp_row));
                          if (bspcp_row == null) {
                                     System.out.println("BREAK");
                                     continue;
                                     //row = report_worksheet.createRow(xrow); 
                                  } 
                          Cell bsp_cell = bspcp_row.getCell(Integer.parseInt(bsp_cp_col));
                         
                          if (bsp_cell == null){
                                bsp_cell = bspcp_row.createCell(Integer.parseInt(bsp_cp_col));
                             }
                          
                          if(bsp_val_col.isEmpty()){
                           bsp_cell.setCellValue(0.00D);
                          }else{
                          bsp_cell.setCellValue(formatter.formatCellValue(valueCell,evaluator));
                          }
                          
                        
                         }else{ x = report_worksheet.getLastRowNum();}
           
                    }
                    
                     //Overwrite excell
            XSSFFormulaEvaluator.evaluateAllFormulaCells(report_excel_template_PBSCP);
            FormulaEvaluator xevaluator = report_excel_template_PBSCP.getCreationHelper().createFormulaEvaluator();
            xevaluator.setIgnoreMissingWorkbooks(true);
            System.out.println("FORMULA" + xevaluator);
            for (Sheet sheet : report_excel_template_PBSCP){
                System.out.println("Sheet" + sheet);
                for(Row r : sheet){
                    for(Cell c: r ){
                        
                        if(c.getCellType() == Cell.CELL_TYPE_FORMULA){
                            xevaluator.evaluateFormulaCell(c);
                            
                        }
                    }
                  }
                }
                    
                    
                    FileOutputStream bsp_pbscp_output_file =new FileOutputStream(new File(current+"\\output\\PBSCP-"+currentDate+".xlsm"));
                     //write changes
                     System.out.println("  "+ current+"\\output\\PBSCP-"+currentDate+".xlsm" );
                    report_excel_template_PBSCP.write(bsp_pbscp_output_file);
                    //close the stream
                    bsp_pbscp_output_file.close(); 
                    
                    
                    J1.setValue(100);
                    JOptionPane.showMessageDialog(rootPane, "Report Complete!");
                    J1.setValue(0);
                    System.out.println("Done");
                }       
                   
                } catch (SQLException ex) {
                    Logger.getLogger(PBSJInternalFrame.class.getName()).log(Level.SEVERE, null, ex);
                } catch (IOException ex) {
                    Logger.getLogger(PBSJInternalFrame.class.getName()).log(Level.SEVERE, null, ex);
                }     
            }
        });
        thread.start();
    }//GEN-LAST:event_btnGenerateActionPerformed

    private void jCalReportCutOff1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jCalReportCutOff1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jCalReportCutOff1ActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private static javax.swing.JProgressBar J1;
    private javax.swing.JButton btnCancel;
    private javax.swing.JButton btnGenerate;
    private org.freixas.jcalendar.JCalendarCombo jCalReportCutOff;
    private org.freixas.jcalendar.JCalendarCombo jCalReportCutOff1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    // End of variables declaration//GEN-END:variables
}
