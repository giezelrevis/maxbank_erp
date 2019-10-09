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
public class LoanJInternalFrame extends javax.swing.JInternalFrame {

    /**
     * Creates new form LoanJInternalFrame
     */
     public LoanJInternalFrame(String repcode) throws SQLException, IOException {
        initComponents();
        
        
        //this is the old code
    
    }   
    
    public LoanJInternalFrame() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        J = new javax.swing.JProgressBar();
        btnGenerate = new javax.swing.JButton();
        btnCancel = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jCalReportCutOff = new org.freixas.jcalendar.JCalendarCombo();

        setTitle("Loan");

        J.setMaximum(23);
        J.setStringPainted(true);

        btnGenerate.setText("Generate");
        btnGenerate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnGenerateActionPerformed(evt);
            }
        });

        btnCancel.setText("Cancel");
        btnCancel.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnCancelActionPerformed(evt);
            }
        });

        jLabel1.setText("Report Cut-Off Date:");

        jCalReportCutOff.setName("fsDateString"); // NOI18N
        jCalReportCutOff.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jCalReportCutOffActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addGap(18, 18, 18)
                        .addComponent(jCalReportCutOff, javax.swing.GroupLayout.PREFERRED_SIZE, 244, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(btnCancel)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(btnGenerate))
                    .addComponent(J, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap(24, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(16, 16, 16)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(jCalReportCutOff, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(J, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGap(10, 10, 10)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnCancel)
                    .addComponent(btnGenerate))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents
   private static final SimpleDateFormat SDF = new SimpleDateFormat( "yyyy-MM-dd" );
    private void btnGenerateActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnGenerateActionPerformed
    
        System.out.println("START");
        Thread thread = new Thread(new Runnable(){
            @Override
            public void run()
            {
                String dateString = SDF.format( jCalReportCutOff.getDate() );
                

          
            }
        });
        thread.start();
    }//GEN-LAST:event_btnGenerateActionPerformed
    
     private static String loanSched11B1(String dateString){
        
        String sqlstr = "";
        sqlstr +=" with A as (select 'A' as id, C.description,  ";
	sqlstr +=" sum(case when F.loan_performance_id_id = 1 then F.balance_amount -   ";
		sqlstr +=" case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as current,  ";
	sqlstr +=" sum(case when F.loan_performance_id_id = 2 then F.balance_amount -   ";
		sqlstr +=" case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end) as pdnynp,  ";
	sqlstr +=" sum(case when F.loan_performance_id_id = 3 then F.balance_amount -   ";
		sqlstr +=" case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end) as pdnp,  ";
	sqlstr +=" sum(case when F.loan_performance_id_id = 4 then F.balance_amount -   ";
		sqlstr +=" case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end) as lit,  ";
	sqlstr +=" sum(case when B.total_provision is null then 0 else B.total_provision end) as allowance  ";	
	sqlstr +=" from cfg_acct_gl_template C  ";
	sqlstr +=" left outer join  Loan A on C.id = A.gl_link_id  ";
	sqlstr +=" left outer join Loan_Loss_Provision_Detail B on B.loan_id = A.id  ";
	sqlstr +=" left outer join monthly_pointer_loan F on A.account_no = F.account_no and F.ref_date = '"+dateString+"'  ";
	sqlstr +=" where A.balance_amount > 0 and C.type = 6  ";
	sqlstr +=" group by C.description)  ";
	sqlstr +=" select 'A' as id, X.id as id2, X.description, A.current, A.pdnynp, A.pdnp, A.lit, A.allowance  ";
	sqlstr +=" from cfg_acct_gl_template X  ";
	sqlstr +=" left outer join A on A.description = X.description  ";
	sqlstr +=" where X.type = 6 and X.id in (38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,60)  ";
	sqlstr +=" order by id, id2  ";
         System.out.println("query" + sqlstr);
         return sqlstr;
     }
     private static String loanSched11A1(String dateString){
     String sqlstr;
        sqlstr = "";
                    sqlstr += "with A as (select 'A' as id, C.description,  ";
            sqlstr += "sum(case when F.loan_performance_id_id = 1 then F.balance_amount -  ";
                    sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as current,  ";
            sqlstr += "sum(case when F.loan_performance_id_id = 2 then F.balance_amount -   ";
                    sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end) as pdnynp,  ";
            sqlstr += "sum(case when F.loan_performance_id_id = 3 then F.balance_amount -   ";
                    sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end) as pdnp,  ";
            sqlstr += "sum(case when F.loan_performance_id_id = 4 then F.balance_amount -   ";
                    sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end) as lit,  ";
            sqlstr += "sum(case when B.total_provision is null then 0 else B.total_provision end) as allowance  ";	
            sqlstr += "from cfg_acct_gl_template C  ";
            sqlstr += "left outer join  Loan A on C.id = A.gl_link_id  ";
            sqlstr += "left outer join Loan_Loss_Provision_Detail B on B.loan_id = A.id  ";
            sqlstr += "left outer join monthly_pointer_loan F on A.account_no = F.account_no and F.ref_date = '"+dateString+"'  ";
            sqlstr += "where A.balance_amount > 0 and C.type = 6  ";
            sqlstr += "group by C.description),  ";
            sqlstr += "B as (select 'B - DOSRI', D.description,  ";
            sqlstr += "sum(case when F.loan_performance_id_id = 1 then F.balance_amount -   ";
                    sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as current,  ";
            sqlstr += "sum(case when F.loan_performance_id_id = 2 then F.balance_amount -   ";
                    sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end) as pdnynp,  ";
            sqlstr += "sum(case when F.loan_performance_id_id = 3 then F.balance_amount -   ";
                    sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end) as pdnp,  ";
            sqlstr += "sum(case when F.loan_performance_id_id = 4 then F.balance_amount -   ";
                    sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end) as lit,  ";
            sqlstr += "sum(case when B.total_provision is null then 0 else B.total_provision end) as allowance  ";	
            sqlstr += "from loan_security D   ";
            sqlstr += "left outer join loan A on A.loan_Security_id = D.id  ";
            sqlstr += "left outer join Loan_Loss_Provision_Detail B on B.loan_id = A.id  ";
            sqlstr += "left outer join monthly_pointer_loan F on A.account_no = F.account_no and F.ref_date = '"+dateString+"'  ";
            sqlstr += "inner join customer C on A.customer_id = C.id  ";
            sqlstr += "where A.balance_amount > 0 and C.dosri_code_id <> 1  ";
            sqlstr += "group by D.description),   ";
            sqlstr += "C as (select 'C - NON-DOSRI', D.description,   ";
            sqlstr += "sum(case when F.loan_performance_id_id = 1 then F.balance_amount -  ";
                    sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as current,  ";
            sqlstr += "sum(case when F.loan_performance_id_id = 2 then F.balance_amount -   ";
                    sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end) as pdnynp,  ";
            sqlstr += "sum(case when F.loan_performance_id_id = 3 then F.balance_amount -   ";
                    sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end) as pdnp,  ";
            sqlstr += "sum(case when F.loan_performance_id_id = 4 then F.balance_amount -   ";
                    sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end) as lit,  ";
            sqlstr += "sum(case when B.total_provision is null then 0 else B.total_provision end) as allowance  ";	
            sqlstr += "from loan_security D   ";
            sqlstr += "left outer join loan A on A.loan_Security_id = D.id  ";
            sqlstr += "left outer join Loan_Loss_Provision_Detail B on B.loan_id = A.id  ";
            sqlstr += "left outer join customer C on A.customer_id = C.id  ";
            sqlstr += "left outer join monthly_pointer_loan F on A.account_no = F.account_no and F.ref_date = '"+dateString+"'  ";
            sqlstr += "where C.dosri_code_id = 1  ";
            sqlstr += "group by D.description)  ";
            sqlstr += "select 'A' as id, X.id as id2, X.description, A.current, A.pdnynp, A.pdnp, A.lit, A.allowance  ";
            sqlstr += "from cfg_acct_gl_template X  ";
            sqlstr += "left outer join A on A.description = X.description  ";
            sqlstr += "where X.type = 6  ";
            sqlstr += "union  ";
            sqlstr += "select 'B - DOSRI' as id, X.id, X.description, B.current, B.pdnynp, B.pdnp, B.lit, B.allowance  ";
            sqlstr += "from loan_security X  ";
            sqlstr += "left outer join B on B.description = X.description  ";
            sqlstr += "union  ";
            sqlstr += "select 'C - Non-DOSRI' as id, X.id, X.description, C.current, C.pdnynp, C.pdnp, C.lit, C.allowance  ";
            sqlstr += "from loan_security X  ";
            sqlstr += "left outer join C on C.description = X.description  ";
            sqlstr += "union   ";
            sqlstr += "select 'D', 999,'Allowance', sum(case when A.loan_performance_id_id = 1 then   ";
                    sqlstr += "case when B.total_provision is null then 0 else B.total_provision end else 0 end ) as current,  ";
            sqlstr += "sum(case when A.loan_performance_id_id = 2 then   ";
                    sqlstr += "case when B.total_provision is null then 0 else B.total_provision end else 0 end )as pdnynp,  ";
            sqlstr += "sum(case when A.loan_performance_id_id = 3 then   ";
                    sqlstr += "case when B.total_provision is null then 0 else B.total_provision end else 0 end ) as pdnp,  ";
            sqlstr += "sum(case when A.loan_performance_id_id = 4 then   ";
                    sqlstr += "case when B.total_provision is null then 0 else B.total_provision end else 0 end ) as lit,  ";
            sqlstr += "sum(case when B.total_provision is null then 0 else B.total_provision end) as allowance  ";
            sqlstr += "from loan A   ";
            sqlstr += "left outer join Loan_Loss_Provision_Detail B on B.loan_id = A.id  ";
            sqlstr += "order by id, id2  ";
     return sqlstr;
     }
     
     private static String loanSched11D1(String dateString){
          String sqlstr= "";
          
                    sqlstr += "with A as (select 'A' as id, C.description,   ";
          sqlstr += "sum(case when F.loan_project_id = 2 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as AgricultureForestryandFishing,  ";
          sqlstr += "sum(case when F.loan_project_id = 3 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as MiningAndQuarrying,  ";
          sqlstr += "sum(case when F.loan_project_id = 4 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as Manufacturing,  ";
          sqlstr += "sum(case when F.loan_project_id = 5 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as ElectricityGasSteam,  ";
          sqlstr += "sum(case when F.loan_project_id = 6 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as WaterSupplySewerageWaste,  ";
          sqlstr += "sum(case when F.loan_project_id = 7 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as Construction,  ";
          sqlstr += "sum(case when F.loan_project_id = 8 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as WholesaleAndRetailTrade,  ";
          sqlstr += "sum(case when F.loan_project_id = 9 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as AccomodationFood,  ";
          sqlstr += "sum(case when F.loan_project_id = 10 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as TransportationAndStorage,  ";
          sqlstr += "sum(case when F.loan_project_id = 11 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as InformationAndCommunication,  ";
          sqlstr += "sum(case when F.loan_project_id = 12 then F.balance_amount -  ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as Financial,  ";
          sqlstr += "sum(case when F.loan_project_id = 13 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as RealEstate,  ";
          sqlstr += "sum(case when F.loan_project_id = 14 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as ProfessionalScientific,  ";
          sqlstr += "sum(case when F.loan_project_id = 15 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as AdministrativeAndSupport,  ";
          sqlstr += "sum(case when F.loan_project_id = 16 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as PublicAdministration,  ";
          sqlstr += "sum(case when F.loan_project_id = 17 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as Education,  ";
          sqlstr += "sum(case when F.loan_project_id = 18 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as HumanHealth, ";
          sqlstr += "sum(case when F.loan_project_id = 19 then F.balance_amount -  ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as ArtsEntertainment,  ";
          sqlstr += "sum(case when F.loan_project_id = 20 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as OtherService,  ";
          sqlstr += "sum(case when F.loan_project_id = 21 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as ActivitiesHouseholds,  ";
          sqlstr += "sum(case when F.loan_project_id = 22 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as ActivitiesExtraTerritorial  ";	
          sqlstr += "from cfg_acct_gl_template C  ";
          sqlstr += "left outer join  Loan A on C.id = A.gl_link_id  ";
          sqlstr += "left outer join Loan_Loss_Provision_Detail B on B.loan_id = A.id  ";
          sqlstr += "left outer join monthly_pointer_loan F on A.account_no = F.account_no and F.ref_date = '"+dateString+"'  ";
          sqlstr += "where A.balance_amount > 0 and C.type = 6  ";
          sqlstr += "group by C.description),  ";
          sqlstr += "B as (select 'B', D.description,   ";
          sqlstr += "sum(case when F.loan_project_id = 2 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as AgricultureForestryandFishing,  ";
          sqlstr += "sum(case when F.loan_project_id = 3 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as MiningAndQuarrying,  ";
          sqlstr += "sum(case when F.loan_project_id = 4 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as Manufacturing,  ";
          sqlstr += "sum(case when F.loan_project_id = 5 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as ElectricityGasSteam,  ";
          sqlstr += "sum(case when F.loan_project_id = 6 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as WaterSupplySewerageWaste,  ";
          sqlstr += "sum(case when F.loan_project_id = 7 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as Construction,  ";
          sqlstr += "sum(case when F.loan_project_id = 8 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as WholesaleAndRetailTrade,  ";
          sqlstr += "sum(case when F.loan_project_id = 9 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as AccomodationFood,  ";
          sqlstr += "sum(case when F.loan_project_id = 10 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as TransportationAndStorage,  ";
          sqlstr += "sum(case when F.loan_project_id = 11 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as InformationAndCommunication,  ";
          sqlstr += "sum(case when F.loan_project_id = 12 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as Financial,  ";
          sqlstr += "sum(case when F.loan_project_id = 13 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as RealEstate,  ";
          sqlstr += "sum(case when F.loan_project_id = 14 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as ProfessionalScientific,  ";
          sqlstr += "sum(case when F.loan_project_id = 15 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as AdministrativeAndSupport,  ";
          sqlstr += "sum(case when F.loan_project_id = 16 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as PublicAdministration,  ";
          sqlstr += "sum(case when F.loan_project_id = 17 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as Education,  ";
          sqlstr += "sum(case when F.loan_project_id = 18 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as HumanHealth,  ";
          sqlstr += "sum(case when F.loan_project_id = 19 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as ArtsEntertainment,  ";
          sqlstr += "sum(case when F.loan_project_id = 20 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as OtherService,  ";
          sqlstr += "sum(case when F.loan_project_id = 21 then F.balance_amount -  ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as ActivitiesHouseholds,  ";
          sqlstr += "sum(case when F.loan_project_id = 22 then F.balance_amount -   ";
                  sqlstr += "case when B.uid_balance is null then 0 else B.uid_balance - B.loan_service_charge - B.other_deferred_credit end else 0 end ) as ActivitiesExtraTerritorial  ";		
          sqlstr += "from loan_performance_id D   ";
          sqlstr += "left outer join loan A on A.loan_performance_id_id = D.id  ";
          sqlstr += "left outer join Loan_Loss_Provision_Detail B on B.loan_id = A.id  ";
          sqlstr += "left outer join monthly_pointer_loan F on A.account_no = F.account_no and F.ref_date = '"+dateString+"'  ";
          sqlstr += "where A.balance_amount > 0   ";
          sqlstr += "group by D.description)  ";
          //-- main query
          sqlstr += "select 'A' as id, X.id as id2, X.description, A.AgricultureForestryandFishing, A.MiningAndQuarrying, A.ElectricityGasSteam,   ";
          sqlstr += "A.WaterSupplySewerageWaste, A.Construction, A.WholesaleAndRetailTrade,A.AccomodationFood, A.TransportationAndStorage,  ";
          sqlstr += "A.InformationAndCommunication,A.Financial, A.RealEstate, A.ProfessionalScientific, A.AdministrativeAndSupport,  ";
          sqlstr += "A.PublicAdministration, A.Education, A.HumanHealth, A.ArtsEntertainment, A.OtherService, A.ActivitiesHouseholds,  ";
          sqlstr += "A.ActivitiesExtraTerritorial  ";
          sqlstr += "from cfg_acct_gl_template X  ";
          sqlstr += "left outer join A on A.description = X.description  ";
          sqlstr += "where X.type = 6  ";
          sqlstr += "union  ";
          sqlstr += "select 'B' as id, X.id, X.description, B.AgricultureForestryandFishing, B.MiningAndQuarrying, B.ElectricityGasSteam,   ";
          sqlstr += "B.WaterSupplySewerageWaste, B.Construction, B.WholesaleAndRetailTrade,B.AccomodationFood, B.TransportationAndStorage,  ";
          sqlstr += "B.InformationAndCommunication,B.Financial, B.RealEstate, B.ProfessionalScientific, B.AdministrativeAndSupport,  ";
          sqlstr += "B.PublicAdministration, B.Education, B.HumanHealth, B.ArtsEntertainment, B.OtherService, B.ActivitiesHouseholds,  ";
          sqlstr += "B.ActivitiesExtraTerritorial  ";
          sqlstr += "from loan_performance_id X  ";
          sqlstr += "left outer join B on B.description = X.description  ";
          sqlstr += "order by id, id2  ";
          
          
          
          return sqlstr;
          }

     
     
    private void btnCancelActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCancelActionPerformed
        //reportparameterframe.setDefaultCloseOperation(JInternalFrame.DISPOSE_ON_CLOSE);
        this.dispose();
    }//GEN-LAST:event_btnCancelActionPerformed

    private void jCalReportCutOffActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jCalReportCutOffActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jCalReportCutOffActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private static javax.swing.JProgressBar J;
    private javax.swing.JButton btnCancel;
    private javax.swing.JButton btnGenerate;
    private org.freixas.jcalendar.JCalendarCombo jCalReportCutOff;
    private javax.swing.JLabel jLabel1;
    // End of variables declaration//GEN-END:variables
}